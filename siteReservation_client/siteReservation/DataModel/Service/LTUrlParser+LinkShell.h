//
// Created by Kerberos Zhang on 14-11-20.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTUrlParser.h>
//#import "LTUrlParser.h"

@interface LTUrlParser (LinkShell)
- (BOOL)getShellLinkDDUrl:(NSString *)strUrl
          withFinishBlock:(void (^)(NSString *linkShellUrl))finishBlock;
@end
