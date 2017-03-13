//
//  LTInvitePopViewManager.m
//  LetvIphoneClient
//
//  Created by Qinxl on 14-7-31.
//
//

#import "LTInvitePopViewManager.h"
//#import "GTMBase64.h"
//#import "NSString+MD5.h"

@interface LTInvitePopViewManager ()

@end

@implementation LTInvitePopViewManager
+ (LTInvitePopViewManager *)sharedInstance
{
    static LTInvitePopViewManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.showInviteFlag=YES;
    });
    return sharedInstance;
}

/**
 邀请url
 */
- (NSString *)inviteUrl{
    NSString* inviteStr = [[NSString alloc] initWithData:[GTMBase64 decodeString:LT_SECRETKEY_INVITEURL] encoding:NSUTF8StringEncoding];
    return inviteStr;
}

/**
 提交红包密码url
 */
- (NSString *)inviterUrl{
    NSString *keyStr=[[NSString alloc] initWithData:[GTMBase64 decodeString:LT_SECRETKEY_INVITEKEY] encoding:NSUTF8StringEncoding];
    NSString *signMd5Str = [NSString md5:[NSString stringWithFormat:@"%@%@",[DeviceManager getDeviceUUID], keyStr]];
    NSString *decodeStr= [[NSString alloc] initWithData:[GTMBase64 decodeString:LT_SECRETKEY_INVITERURL] encoding:NSUTF8StringEncoding];
    
    NSString *inviterStr=[NSString stringWithFormat:decodeStr,[DeviceManager getDeviceUUID],signMd5Str];
    return inviterStr;
}
@end
