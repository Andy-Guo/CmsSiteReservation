//
// Created by Kerberos Zhang on 14-11-20.
//

#import "LTUrlParser+LinkShell.h"
#import <LeTVMobileFoundation/LTLinkShellModel.h>
//#import "LTLinkShellModel.h"


@implementation LTUrlParser (LinkShell)
- (BOOL)getShellLinkDDUrl:(NSString *)strUrl
          withFinishBlock:(void (^)(NSString *linkShellUrl))finishBlock
{
    if (![LTLinkShellModel isServiceEnabled]) {
        finishBlock(nil);
        return NO;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ddurlLinkShell = [LTLinkShellModel getShellLinkGSLBUrl:strUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            finishBlock(ddurlLinkShell);
        });
    });

    return YES;
}
@end