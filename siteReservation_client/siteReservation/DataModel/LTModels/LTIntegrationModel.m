//
//  LTIntegrationModel.m
//  LetvIphoneClient
//
//  Created by wd on 14-3-31.
//
//

#import "LTIntegrationModel.h"

//  基本规则
@implementation IntegrationBaseRule

@end


//  写死三种规则
@implementation IntegrationCategory

@end

//  返回结果
@implementation IntegrationResult

@end

// 5.5增加 获取规则项积分记录
@implementation ScoreRecord
+(JSONKeyMapper*)keyMapper{
    return  [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"descript",}];
}
@end