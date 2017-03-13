//
// Created by Kerberos Zhang on 14-11-18.
//

#import <Foundation/Foundation.h>

@interface NSString (UserCenter)
+ (BOOL)isValidEmail:(NSString *)strEmail;
+ (BOOL)isValidPhoneNumber:(NSString *)strPhoneNumber;
+ (BOOL)isValidPassword:(NSString *)strPassword;
+ (BOOL)isValidUserName:(NSString *)userName;
+ (NSMutableArray *) getFilterEmailDictionary:(NSString *)strEmail;
+ (NSString *)convertSecondToDay:(NSString *)secondStr;
@end
