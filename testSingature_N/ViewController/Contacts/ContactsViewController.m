//
//  ContactsViewController.m
//  testSingature_N
//
//  Created by rilakkuma on 2022/10/26.
//

#import "ContactsViewController.h"
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>
#import "MBProgressHUD+Add.h"
#import "NSArray+Contains.h"
#import "AFNetworking.h"

@interface ContactsViewController ()
@property (nonatomic) ABAddressBookRef addressBook;
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestAddressBook];
}

- (IBAction)setContacts:(id)sender {
    
    // 加载本地数据
//    [self loadLocalData];
    
    // 加载远程数据
    [self loadrRemoteData];
}

// 加载远程数据
- (void)loadrRemoteData
{
    [MBProgressHUD showMessag:@"正在写入" toView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:@"http://192.168.10.204:8080/user_contacts/getList" parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *contactList = responseObject[@"data"][@"push"];
            [self saveContactsWith:contactList];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"请求失败" toView:self.view];
        }];
    });
}

// 加载本地数据
- (void)loadLocalData
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"contact" ofType:@"json"]];
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSArray *contactList = dataDict[@"data"][@"push"];
    [MBProgressHUD showMessag:@"正在写入" toView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self saveContactsWith:contactList];
    });
}

// 存储通讯录到本地
- (void)saveContactsWith:(NSArray *)contactList
{
    NSMutableArray *contactArr = [self removeRepeatElementWith:contactList];
    [contactArr enumerateObjectsUsingBlock:^(NSDictionary *contact, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addPersonWithFirstName:nil lastName:contact[@"name"] workNumber:contact[@"cell"]];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

// 去除重复元素
- (NSMutableArray *)removeRepeatElementWith:(NSArray *)originArr
{
    NSMutableArray *contactArr = [NSMutableArray array];
    [originArr enumerateObjectsUsingBlock:^(NSDictionary *origin, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![contactArr contains:origin]) {
            [contactArr addObject:origin];
        }
    }];
    return contactArr;
}

- (IBAction)clearContact:(id)sender {
    //取得通讯录中所有人员记录
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    NSMutableArray *people = (__bridge NSMutableArray *)allPeople;
    // 清空通讯录
    [MBProgressHUD showMessag:@"正在清空通讯录" toView:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [people enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removePersonWithRecord:(__bridge ABRecordRef)(obj)];
        }];
        //释放资源
        CFRelease(allPeople);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

/* 请求访问通讯录并获取通讯录所有记录 */
- (void)requestAddressBook{
    //创建通讯录对象
    self.addressBook = ABAddressBookCreate();
    
    //请求访问用户通讯录,注意无论成功与否block都会调用
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error) {
        if (!granted) {
            NSLog(@"未获得通讯录访问权限！");
        }
        //获取所有通讯录记录
        [self initAllPerson];
    });
}

/* 取得所有通讯录记录 */
- (void)initAllPerson{
    //取得通讯录访问授权
    ABAuthorizationStatus authorization = ABAddressBookGetAuthorizationStatus();
    //如果未获得授权
    if (authorization != kABAuthorizationStatusAuthorized) {
        NSLog(@"尚未获得通讯录访问授权！");
        return ;
    }
}

/**
 *  添加一条记录
 *
 *  @param firstName  名
 *  @param lastName   姓
 *  @param workNumber iPhone手机号
 */
- (void)addPersonWithFirstName:(NSString *)firstName
                      lastName:(NSString *)lastName
                    workNumber:(NSString *)workNumber
{
    //创建一条记录
    ABRecordRef recordRef = ABPersonCreate();
    //添加名
    ABRecordSetValue(recordRef,kABPersonFirstNameProperty,(__bridge CFTypeRef)(firstName),NULL);
    //添加姓
    ABRecordSetValue(recordRef,kABPersonLastNameProperty,(__bridge CFTypeRef)(lastName),NULL);
    //创建一个多值属性，因为手机号可以有多个
    ABMutableMultiValueRef multiValueRef = ABMultiValueCreateMutable(kABStringPropertyType);
    //向多值属性中添加工作电话
    ABMultiValueAddValueAndLabel(multiValueRef,(__bridge CFStringRef)(workNumber),kABWorkLabel,NULL);
    //添加属性到指定记录，这里添加的是多值属性
    ABRecordSetValue(recordRef, kABPersonPhoneProperty, multiValueRef, NULL);
    //添加记录到通讯录
    ABAddressBookAddRecord(self.addressBook, recordRef, NULL);
    //保存通讯录，提交更改
    ABAddressBookSave(self.addressBook, NULL);
    //释放资源
    CFRelease(recordRef);
    CFRelease(multiValueRef);
}

/* 删除指定的记录 */
- (void)removePersonWithRecord:(ABRecordRef)recordRef{
    ABAddressBookRemoveRecord(self.addressBook, recordRef, NULL);//删除
    ABAddressBookSave(self.addressBook, NULL);//删除之后提交更改
}
/* 根据姓名删除记录 */
- (void)removePersonWithName:(NSString *)personName{
    CFStringRef personNameRef = (__bridge CFStringRef)(personName);
    //根据人员姓名查找
    CFArrayRef recordsRef = ABAddressBookCopyPeopleWithName(self.addressBook, personNameRef);
    CFIndex count = CFArrayGetCount(recordsRef);//取得记录数
    for (CFIndex i=0; i<count; ++i) {
        ABRecordRef recordRef = CFArrayGetValueAtIndex(recordsRef, i);//取得指定的记录
        ABAddressBookRemoveRecord(self.addressBook, recordRef, NULL);//删除
    }
    //删除之后提交更改
    ABAddressBookSave(self.addressBook, NULL);
    CFRelease(recordsRef);
}

/**
 *  根据记录ID修改联系人信息
 *
 *  @param recordID   记录唯一ID
 *  @param firstName  姓
 *  @param lastName   名
 *  @param workNumber 工作电话
 */
- (void)modifyPersonWithRecordID:(ABRecordID)recordID
                       firstName:(NSString *)firstName
                        lastName:(NSString *)lastName
                      workNumber:(NSString *)workNumber
{
    //根据记录ID获取一条记录
    ABRecordRef recordRef = ABAddressBookGetPersonWithRecordID(self.addressBook, recordID);
    //添加名
    ABRecordSetValue(recordRef,kABPersonFirstNameProperty,(__bridge CFTypeRef)(firstName),NULL);
    //添加姓
    ABRecordSetValue(recordRef,kABPersonLastNameProperty,(__bridge CFTypeRef)(lastName),NULL);
    //创建一个多值属性，因为手机号可以有多个
    ABMutableMultiValueRef multiValueRef = ABMultiValueCreateMutable(kABStringPropertyType);
    //向多值属性中添加工作电话
    ABMultiValueAddValueAndLabel(multiValueRef,(__bridge CFStringRef)(workNumber),kABWorkLabel,NULL);
    //添加属性到指定记录，这里添加的是多值属性
    ABRecordSetValue(recordRef, kABPersonPhoneProperty, multiValueRef, NULL);
    //保存记录，提交更改
    ABAddressBookSave(self.addressBook, NULL);
    //释放资源
    CFRelease(multiValueRef);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
