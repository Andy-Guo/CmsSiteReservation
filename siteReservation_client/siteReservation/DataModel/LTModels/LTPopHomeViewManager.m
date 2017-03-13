//
//  LTPopHomeViewManager.m
//  LetvIphoneClient
//
//  Created by dabao on 15/11/19.
//
//

#import "LTPopHomeViewManager.h"

@implementation LTPopHomeViewManager
+ (LTPopHomeViewManager *)shareClient
{
    static LTPopHomeViewManager *popViewManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popViewManager = [[LTPopHomeViewManager alloc] init];
    });
    return popViewManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showPopView = YES;
    }
    return self;
}
@end
