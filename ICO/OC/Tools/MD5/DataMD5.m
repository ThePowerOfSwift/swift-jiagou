//
//  DataMD5.m
//  MeiRenGu
//
//  Created by 美融城 on 2017/3/27.
//  Copyright © 2017年 美融城. All rights reserved.
//

#import "DataMD5.h"

#import <CommonCrypto/CommonCrypto.h>

@interface DataMD5 ()

@end

@implementation DataMD5
+(instancetype)shareDataMD5{
    static DataMD5 *ma ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ma = [DataMD5 new];
        
        
    });
    return ma;
}
-(NSString*)createMd5Id:(NSDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];

    NSArray *keys = [dict allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
       
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"secret"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"timestamp"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
  
    
    //MD5 获取Sign签名
    NSString *md5Sign =[self md5:contentString.copy];
    
    //

    return md5Sign;
    
}



// MD5加密算法
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];


}

@end
