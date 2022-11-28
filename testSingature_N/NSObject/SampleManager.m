//
//  SampleManager.m
//  LessonSql
//
//  Created by 肖 浩 on 12-11-16.
//  Copyright (c) 2012年 肖 浩. All rights reserved.
//

#import "SampleManager.h"

//数据库的存储路径
#define kDataBasePath [NSHomeDirectory() stringByAppendingFormat:@"/Documents/SampleStudent.db"]

@implementation SampleManager

+ (SampleManager *)instance
{
    static SampleManager *s_SampleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_SampleManager = [[SampleManager alloc] init];
    });
    return s_SampleManager;
}

- (BOOL) isOpenDB
{
    //如果对象不为空，则已经打开数据库的链接
    if (_db != NULL) {
        return YES;
    }
    return sqlite3_open([kDataBasePath UTF8String], &_db) == SQLITE_OK;
}
- (BOOL) createSampleStudentTable
{
    //如果数据库没有打开，返回NO
    if (![self isOpenDB]) {
        return NO;
    }
    //创建数据库的语句
    NSString *_sql = [[NSString alloc] initWithFormat:@"create table if not exists Student(sid integer primary key autoincrement,name text not null,age text not null,image text not null)"];
    
    //执行创建语句，并且返回是否创建成功
    return sqlite3_exec(_db, [_sql UTF8String], NULL, NULL, NULL)== SQLITE_OK;
}
- (BOOL) insertStudent:(SampleStudent *)student
{
    //如果数据库没有打开，返回NO
    if (![self isOpenDB]) {
        return NO;
    }
    //插入学生的语句
    NSString *_sql = [[NSString alloc] initWithFormat:@"insert into Student(name,age,image) values('%@','%@','%@')",student.name,student.age,student.image];
    
    return sqlite3_exec(_db, [_sql UTF8String], NULL, NULL, NULL) == SQLITE_OK;
}
- (BOOL) deleteStudent:(SampleStudent *)student
{
    //如果数据库没有打开，返回NO
    if (![self isOpenDB]) {
        return NO;
    }
    
    //删除学生的语句
    NSString *_sql = [[NSString alloc] initWithFormat:@"delete from Student where sid = %d",student.sid];
    
    return sqlite3_exec(_db, [_sql UTF8String], NULL, NULL, NULL) == SQLITE_OK;
}
- (BOOL) updateStudent:(SampleStudent *)student
{
    //如果数据库没有打开，返回NO
    if (![self isOpenDB]) {
        return NO;
    }
    
    
    //更新学生的语句
    NSString *_sql = [[NSString alloc] initWithFormat:@"update Student set name=%@,age=%@,image=%@ where sid = %d",student.name,student.age,student.image,student.sid];
    
    return sqlite3_exec(_db, [_sql UTF8String], NULL, NULL, NULL) == SQLITE_OK;
}

- (NSArray *) allStudent
{
    //如果数据库没有打开，返回NO
    if (![self isOpenDB]) {
        return nil;
    }
    //实例化学生数组
    NSMutableArray *array = [NSMutableArray array];
    //更新学生的语句
    NSString *_sql = [[NSString alloc] initWithFormat:@"select * from Student"];
    //数据库状态准备
    sqlite3_stmt *_stmt = NULL;
    sqlite3_prepare_v2(_db, [_sql UTF8String], -1, &_stmt, NULL);
    //依次遍历所有的查询结果，根据数据库的状态
    while (sqlite3_step(_stmt) != SQLITE_DONE) {
        //学生编号
        int _sid = sqlite3_column_int(_stmt, 0);
        //学生姓名
        NSString *_name = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(_stmt, 1)];
        //学生年龄
        NSString *_age = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(_stmt, 2)];
        //学生头像地址
        NSString *_image = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(_stmt, 3)];
        //实例化学生对象
        SampleStudent *_student = [[SampleStudent alloc] init];
        _student.name = _name;
        _student.sid = _sid;
        _student.image = _image;
        _student.age = _age;
        
        [array addObject:_student];
        
        //每一次的遍历的内存管理
        _name = nil;
        _age = nil;
        _image = nil;
        _student = nil;
    }
    return array;
}


#pragma mark - 数据库新
//下边函数返回数据库的完整路径 数据库在此目录下创建
- (NSString *) filePath{
    
    /*/ 搜索域名目录路径函数,他的返回值是数组指针,
        把他储存在数组里。
     */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //建立一个字符串 储存路径
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSLog(@"%@, %@",documentsDir,paths);//控制台打印路径
    
    /** 字符串附加路径组建: 后边跟个文件名“database.sql”组成一个完整的文件名路径
      *（这里只是创建了一个完整的带文件名的————完整的字符串————在后边用此字符串来
      * 创建数据库文件）
      */
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}
//创建数据库完成以后 打开数据库
- (void) openDB{
    /**  creat database;创建数据库
      *  (数据库的文件名是 用上边的方法返回的字符串来定义的。
      *  如果数据库已经存在了就打开它，如果不存在就创建一个新的数据库。
      *  如果数据库成功打开，函数就会返回数值0(由常量SQLITE_OK表示)。)
     */
    
    /*open函数 有两个参数 一个是文件名(const char *filename)
     另一个sqlite3对象的一个句柄(sqlite3 **ppDb) 本代码中就是 db */
    
    //C函数无法识别NSString对象，所以用NSString的UTF8String方法转换为C的字符串；
    if (sqlite3_open([[self filePath] UTF8String], &dbNew) != SQLITE_OK) {
        sqlite3_close(dbNew);//此方法用来关闭数据库连接
        NSAssert(0, @"Database failed to open.");//此方法用来停止应用程序
    }
}

//******创建数据表 此方法有三个参数 表名 姓名 邮箱
- (void) createTableNamed:(NSString *) tableName
               withField1:(NSString *) field1
               withField2:(NSString *) field2{
    
    char *err = nil;
    //下边是传说中的SQL语句
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS '%@' ('%@' "" TEXT PRIMARY KEY, '%@' TEXT);",
                     tableName, field1, field2];
    if (sqlite3_exec(dbNew, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(dbNew);
        NSAssert(0, @"Table failed to creat.");//数据库表格常见失败 停止程序
    }//此函数三个重要的参数 sqlite3对象、SQL语句、一个指向用于存储错误消息变量的指针(char **errmsg)
    
    NSLog(@"创建语句%@",sql);//传参后打印出来看看，吼吼
}
//*******插入或更新数据 ++++++++++绑定变量
- (void) insertRecordIntoTableNamed:(NSString *) tableName
                         withField1:(NSString *) field1
                        field1Value:(NSString *) field1Value
                         withField2:(NSString *) field2
                        field2Value:(NSString *) field2Value{
   /*
    //插入语句
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT OR REPLACE INTO '%@' ('%@', '%@') "
                     "VALUES ('%@', '%@')",
                     tableName, field1, field2, field1Value, field2Value];
    
    char *err = nil;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Error Updating Table.");
    }
    NSLog(@"插入语句%@",sql);
    */

    //绑定变量
    NSString *sqlStr = [[NSString alloc] initWithFormat:
                        @"INSERT OR REPLACE INTO '%@' ('%@', '%@')"
                        "VALUES (?,?)", tableName, field1, field2];//注意：？只能插入Value 或者 Where 部分；
    const char *sql = [sqlStr UTF8String];
    
    /** 创建一个sqlite3_stmt对象 并使用sqlite3_prepare_v2()函数将SQL语句编译成为二进制形式，
      * 然后sqlite3_bind_text()函数插入占位符的值；
      * (注意：使用sqlite3_bind_int()函数绑定整型值);
     */
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(dbNew, sql, -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1,
                          [field1Value UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2,
                          [field2Value UTF8String], -1, NULL);
    }
    
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSAssert(0, @"Error updating table.");
    }
    sqlite3_finalize(statement);
//    NSLog(@"%@, %s",statement, sql);
    
}
//*******检索记录
- (void) gatAllRowsFromTableNamed:  (NSString *) tableName{
    
}


- (void)initCSQl
{
    [self openDB];
    [self createTableNamed:@"Contacts"
                withField1:@"email"
                withField2:@"name"];
    
    for (int i = 0; i <= 2; i++) {
        
        NSString *email = [[NSString alloc] initWithFormat:@"user%d@learn2develop.net",i];
        NSString  *name = [[NSString alloc] initWithFormat:@"user %d",i];
        
        [self insertRecordIntoTableNamed:@"Contacts"
                              withField1:@"email" field1Value:email
                              withField2:@"name" field2Value:name];
    }
    // Do any additional setup after loading the view, typically from a nib.
}
@end
