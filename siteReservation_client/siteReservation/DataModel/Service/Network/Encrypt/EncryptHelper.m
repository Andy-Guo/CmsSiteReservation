//
//  EncryptHelper.m
//  LeTVMobileDataModel
//
//  Created by yanyijie on 15-4-10.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "EncryptHelper.h"
#import "encrypt.h"
#import "LTTimeStampProcess.h"


#define LETV_ENCRYPT_PRIVATE_KEY @"zCezLmB8o76lk"

@implementation EncryptHelper


+ (NSString *)getLTTKByUrlPath:(NSString *)urlPath
{

    NSString *tk = @"";
    
@try
{
    if([NSString isBlankString:urlPath])
    {
        return tk;
    }
    
    char ret_str[64] = {0};
    
    const char *url = [urlPath cStringUsingEncoding:NSUTF8StringEncoding];
    
    
    long long stamp = 0;
    
    NSString *serverTime = [[LTTimeStampProcess sharedInstance] getRoughSeverTimeStamp];
    if([NSString isBlankString:serverTime])
    {
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        stamp = (long)timeStamp;
    }
    else
    {
        stamp = [serverTime longLongValue];
    }
    
    int ret = letv_encrypt((int)stamp, (char *)url, ret_str);
    if(ret == 0)
    {
        tk = [NSString stringWithCString:ret_str encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSString *msg = [NSString stringWithFormat:@"生成TK失败,url = %@",urlPath];
        [[LeTVAppModule sharedModule] letv_LTDataCenter_writeToErrorLogFile:msg];
    }
}@catch(NSException *exception)
{
    NSString *msg = [NSString stringWithFormat: @"生成TK失败,url = %@",urlPath];
    [[LeTVAppModule sharedModule] letv_LTDataCenter_writeToErrorLogFile:msg];
    
    tk = @"";
}
    return tk;
    
    /*
    time_t now;
    int stamp = (int)time(&now);
     //    time_t now;
     //    int stamp = (int)time(&now);
    stamp=1426663357;
    
    NSRange range = [urlPath rangeOfString:@"?"];
    if(range.location != NSNotFound)
    {
        //取  "?"  后面
        NSString *parStr = [urlPath substringWithRange:NSMakeRange(range.location+1, urlPath.length-range.location-1)];
        
        //decode
        parStr = [parStr decodedURLString];
        
        //按照字典顺序排序
        NSString *sortStr = [self sortQueryStrBy:parStr];
        
        //拼接需要加密的串
        NSString *compactStr = [NSString stringWithFormat:@"%@%d%@",LETV_ENCRYPT_PRIVATE_KEY,stamp,sortStr ];
        
        NSString *result = [NSString md5:compactStr];
        
        //tk
        tk = [NSString stringWithFormat:@"%@.%d",result,stamp];
    }
    
    return tk;*/
}

/*
+ (NSString *)sortQueryStrBy:(NSString *)queryString
{
    __block NSString *result = @"";
    static NSString *sign = @"&";
    
    NSArray *array = [queryString componentsSeparatedByString:sign];
    NSArray *sortResult = [array sortedArrayUsingSelector:@selector(compare:)];
    NSInteger arrCount = [sortResult count];
    
    [sortResult enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            result = [result stringByAppendingString:str];
            if(idx != arrCount-1)
            {
                result = [result stringByAppendingString:sign];
            }
        };
    }];
    
    
    return result;
}
*/


@end
