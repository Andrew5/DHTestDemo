//
//  LYDefineRegular.h
//  LYInfoDemo
//
//  Created by boai on 2022/9/20.
//  正则校验

#ifndef LYDefineRegular_h
#define LYDefineRegular_h

#import "LYDefineFoundation.h"


CG_INLINE BOOL LYRegularWith(NSString *regular, NSString *value) {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular] evaluateWithObject:value];
}

//获取string的字符长度
CG_INLINE NSInteger LYCharNumWith(NSString *value) {
    NSUInteger charCountResult = 0;
    //utf8下 一个汉字 3 字节，一个英文1字节   unicode下所有字符2字节
    NSUInteger nameBytes = [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (nameBytes) {
        NSUInteger unicodeBytes = [value lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
        if (nameBytes * 2 >= unicodeBytes) {
            NSUInteger chiCharNum = (nameBytes * 2 - unicodeBytes) / 4;
            //中文字符的个数 = （utf8字节x2 - unicode字节） / 4
            if (value.length >= chiCharNum) {
                NSUInteger engCharNum = value.length - chiCharNum;
                charCountResult  = chiCharNum * 2 + engCharNum;
            }
            //else error!
        }
        //else error!
    }
    //else cont.
    return charCountResult;
}

//身份证校验
CG_INLINE BOOL LYRegularIDCardWith(NSString *value) {
    return LYRegularWith(@"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)", value);
}

//手机号校验
CG_INLINE BOOL LYRegularPhoneWith(NSString *value) {
//    return value.length != 11;
    //    return LYRegularWith(@"^[1][3,4,5,6,7,8,9][0-9]{9}$", value);
    return LYRegularWith(@"^1[\\d]{10}$", value);
}

//地址校验
CG_INLINE BOOL LYRegularAdressWith(NSString *value) {
    return YES;
    //    NSInteger count = LYCharNumWith(value);
    //    return count < 5 || count > 50;
    //    return LYRegularWith(@"^[\u4E00-\u9FA5A-Za-z0-9]+$", value);
}

//是否包含中文
CG_INLINE BOOL LYRegularContainChineseWith(NSString *value) {
    return LYRegularWith(@"^.*[\\u4e00-\\u9fa5].*$", value);
}

//只能输入汉字
CG_INLINE BOOL LYRegularOnlyChineseWith(NSString *value) {
    return LYRegularWith(@"^[\\u4e00-\\u9fa5]{0,}$", value);
}

//只能输入由数字和26个英文字母组成的字符串
CG_INLINE BOOL LYRegularOnlyLetterAndNumWith(NSString *value) {
    return LYRegularWith(@"^[A-Za-z0-9]+$", value);
}

//公司名字校验
CG_INLINE BOOL LYRegularCompanyName(NSString *value) {
    return YES;
    //    return LYRegularWith(@"^[\u4e00-\u9fa5-(-)-（-）]+$", value);
}

//固定电话校验
CG_INLINE BOOL LYRegularFixedTel(NSString *value) {
    return LYRegularWith(@"^((0\\d{2,3}-\\d{7,9})|(1[3584976]\\d{9}))$", value);
}

//正整数验证
CG_INLINE BOOL LYRegularPositiveInteger(NSString *value) {
    return LYRegularWith(@"^[1-9]\\d*$", value);
}

//姓名验证(不能包含数字和字母)
CG_INLINE BOOL LYRegularUserName(NSString *value) {
    return LYIsStringContainNumberAndLetter(value);
    //    return LYRegularWith(@"^[\\u4e00-\\u9fa5]{1,50}$", value);
}



#endif /* LYDefineRegular_h */

/**
 1.验证用户名和密码：”^[a-zA-Z]\w{5,15}$”
 　　2.验证电话号码：（”^([\\d{3,4}-)\\d{7,8}$](file:///d%7B3,4%7D-)//d%7B7,8%7D$)”）
 　　eg：021-68686868  0511-6868686；
 　　3.验证手机号码：”^1[3|4|5|7|8][0-9]\\d{8}$”；
 　　4.验证身份证号（15位或18位数字）：”\\d{14}[[0-9],0-9xX]”；
 　　5.验证Email地址：(“^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$”)；
 　　6.只能输入由数字和26个英文字母组成的字符串：(“^[A-Za-z0-9]+$”) ;
 　　7.整数或者小数：^[0-9]+([.]{0,1}[0-9]+){0,1}$
 　　8.只能输入数字：”^[0-9]*$”。
 　　9.只能输入n位的数字：”^\\d{n}$”。
 　　10.只能输入至少n位的数字：”^\\d{n,}$”。
 　　11.只能输入m~n位的数字：”^\\d{m,n}$”。
 　　12.只能输入零和非零开头的数字：”^(0|[1-9][0-9]*)$”。
 　　13.只能输入有两位小数的正实数：”^[0-9]+(.[0-9]{2})?$”。
 　　14.只能输入有1~3位小数的正实数：”^[0-9]+(\.[0-9]{1,3})?$”。
 　　15.只能输入非零的正整数：”^\+?[1-9][0-9]*$”。
 　　16.只能输入非零的负整数：”^\-[1-9][]0-9″*$。
 　　17.只能输入长度为3的字符：”^.{3}$”。
 　　18.只能输入由26个英文字母组成的字符串：”^[A-Za-z]+$”。
 　　19.只能输入由26个大写英文字母组成的字符串：”^[A-Z]+$”。
 　　20.只能输入由26个小写英文字母组成的字符串：”^[a-z]+$”。
 　　21.验证是否含有^%&',;=?$\”等字符：”[^%&',;=?$\x22]+”。
 　　22.只能输入汉字：”^[\u4e00-\u9fa5]{0,}$”。
 　　23.验证URL："http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"。
 　　24.验证一年的12个月：”^(0?[1-9]|1[0-2])$”正确格式为：”01″～”09″和”10″～”12″。
 　　25.验证一个月的31天：”^((0?[1-9])|((1|2)[0-9])|30|31)$”正确格式为；”01″～”09″、”10″～”29″和“30”~“31”。
 　　26.获取日期正则表达式：[\\d{4](file:///d%7B4)}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?
 　　评注：可用来匹配大多数年月日信息。
 　　27.匹配双字节字符(包括汉字在内)：[^\x00-\xff]
 　　评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
 　　28.匹配空白行的正则表达式：\n\s*\r
 　　评注：可以用来删除空白行
 　　29.匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</>|<.*? />
 　　评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
 　　30.匹配首尾空白字符的正则表达式：^\s*|\s*$
 　　评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
 　　31.匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
 　　评注：网上流传的版本功能很有限，上面这个基本可以满足需求
 　　32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
 　　评注：表单验证时很实用
 　　33.匹配腾讯QQ号：[1-9][0-9]\{4,\}
 　　评注：腾讯QQ号从10 000 开始
 　　34.匹配中国邮政编码：[1-9]\\d{5}(?!\d)
 　　评注：中国邮政编码为6位数字
 　　35.匹配ip地址：((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。
 练习示例
 */
