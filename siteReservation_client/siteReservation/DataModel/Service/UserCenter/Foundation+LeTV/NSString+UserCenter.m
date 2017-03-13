//
// Created by Kerberos Zhang on 14-11-18.
//
#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
//#import "Global.h"
#import "NSString+UserCenter.h"
//#import "NSString+HTTPExtensions.h"


@implementation NSString (UserCenter)

+ (BOOL)isValidEmail:(NSString *)strEmail{

    if([NSString isBlankString:strEmail]){
        return NO;
    }

    if(IsValidEmail([[strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] UTF8String])){
        return NO;
    }

    /*
    if ([NSString isBlankString:[strEmail stringByMatching:REGEX_EMAIL]]) {
        return NO;
    }
    */

    return YES;

}

+ (BOOL)isValidPhoneNumber:(NSString *)strPhoneNumber{

    if([NSString isBlankString:strPhoneNumber]){
        return NO;
    }

    if ([NSString isBlankString:[strPhoneNumber stringByMatching:REGEX_PHONENUMBER]]) {
        return NO;
    }

    return YES;

}

+ (BOOL)isValidPassword:(NSString *)strPassword{

    if([NSString isBlankString:strPassword]){
        return NO;
    }

    if ([NSString isBlankString:[strPassword stringByMatching:REGEX_PASSWORD]]) {
        return NO;
    }

    return YES;

}

+ (BOOL)isValidUserName:(NSString *)userName{

    if ([NSString isValidEmail:userName]) {
        return YES;
    }

    if ([NSString isValidPhoneNumber:userName]) {
        return YES;
    }

    return NO;

}

+ (NSMutableArray *) getFilterEmailDictionary:(NSString *)strEmail{

    NSRange range = [strEmail rangeOfString:@"@" options:NSCaseInsensitiveSearch];
    if (range.location == NSNotFound)
    {
        return nil;
    }

    NSString *strMailPrefix = [strEmail substringToString:@"@"];
    if (    nil == strMailPrefix
            ||  [NSString isBlankString:strMailPrefix]) {
        return nil;
    }

    NSString *strMailSuffix = [strEmail substringFromString:@"@"];

    NSArray *arrayWhole = @[@"163.com",
            @"sina.com",
            @"qq.com",
            @"sohu.com",
            @"126.com",
            @"gmail.com",
            @"hotmail.com",
            @"yahoo.com"];

    NSMutableArray *arrayMail = [NSMutableArray array];

    NSUInteger nCount = [arrayWhole count];
    for (int i=0; i<nCount; i++) {
        NSString *strCurrent = arrayWhole[i];
        BOOL bMatched = NO;
        if (    nil == strMailSuffix
                ||  [NSString isBlankString:strMailSuffix]
                ) {
            bMatched = YES;
        }
        else{
            NSComparisonResult result = [strCurrent compare:strMailSuffix
                                                    options:NSCaseInsensitiveSearch
                                                      range:NSMakeRange(0, [strMailSuffix length])];
            if (result == NSOrderedSame){
                bMatched = YES;
            }
        }
        if (bMatched) {
            [arrayMail addObject:[NSString stringWithFormat:@"%@@%@", strMailPrefix, strCurrent]];
        }
    }

    return arrayMail;

}

+ (NSString *)convertSecondToDay:(NSString *)secondStr {
    NSInteger second = [secondStr integerValue];

    BOOL isNegativeNumber = second < 0 ? YES : NO;

    NSInteger day = second / 24 / 60 / 60;

    if (isNegativeNumber) {
        day *= -1;
    }

    NSString *dayStr = [NSString stringWithFormat:@"%ld", (long)day];

    return dayStr;
}
@end
