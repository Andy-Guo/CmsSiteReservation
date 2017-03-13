//
//  LT_FindBaseModel.m
//  LeTVMobileDataModel
//
//  Created by 王同龙 on 1/19/15.
//  Copyright (c) 2015 Kerberos Zhang. All rights reserved.
//

#import "LT_FindBaseModel.h"

@implementation LT_findColumsDataDataily

@end

@implementation LT_findColumsDataArray
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data":@"dataDetails",
//                                              @"name":@"title",
                                                       
                                                       }];
}
@end

@implementation LT_findColumsData
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data":@"dataBlocks"
                                                       
                                                       }];
}
@end

@implementation LT_FindBaseModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"data":@"datas"
                                         
                                                       }];
}
@end

@implementation LT_ActiveTimeModel
@end
