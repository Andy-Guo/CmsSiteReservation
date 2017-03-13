//
//  LTFeedFlowListDataModel.m
//  LetvMobileClient
//
//  Created by meizhen on 2017/2/17.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import "LTFeedFlowListDataModel.h"

@implementation LTFeedFlowDataModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id"  : @"videoId",
                                                       }];
}

- (NSString*) getMinSizeImage {
    if (self.pic) {
        return self.pic;
    }
    return @"";
}
@end


@implementation LTFeedFlowListDataModel

@end
