//
//  LTRequestURLInfo.m
//  LetvIphoneClient
//
//  Created by zhaocy on 14-5-12.
//
//

#import "LTRequestURLInfo.h"

@implementation LTRequestURLInfo

- (id)init
{
    if (self = [super init]) {
        self.urlDomainType = LTRequestURLDomainTypeNormal;
        self.urlType = LTRequestURL_None;
        self.urlParams = nil;
        self.urlHeadParams =nil;
        self.urlHeadPath = nil;
    }
    
    return self;
}

@end
