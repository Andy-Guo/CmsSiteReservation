//
//  LTInvitePopViewManager.h
//  LetvIphoneClient
//
//  Created by Qinxl on 14-7-31.
//
//

#import <Foundation/Foundation.h>

@interface LTInvitePopViewManager : NSObject
@property (assign ,nonatomic) BOOL showInviteFlag;
+ (LTInvitePopViewManager *)sharedInstance;

/**
 邀请url
 */
- (NSString *)inviteUrl;

/**
 提交红包密码url
 */
- (NSString *)inviterUrl;

@end
