//
//  LTVideoAuxiliaryInfoManager.h
//  LetvIphoneClient
//
//  Created by Letv on 14-8-29.
//
//

#import <Foundation/Foundation.h>

@interface LTVideoAuxiliaryInfoManager : NSObject
+ (LTVideoAuxiliaryInfoManager *)defaultManager;

- (BOOL)isExistVideoAt:(NSString *)at;
- (BOOL)isExistPageStyle:(NSString *)pageStyle;
- (BOOL)isExistChannelPageStyle:(NSString *)pageStyle;
@end
