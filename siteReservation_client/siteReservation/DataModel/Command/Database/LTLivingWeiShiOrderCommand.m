//
//  LTLivingWeiShiOrderCommand.m
//  LetvMobileClient
//
//  Created by xingbo on 2017/2/14.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import "LTLivingWeiShiOrderCommand.h"

#define ArchivePatch [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/starTVOrder.archiver"]

@interface LTLivingWeiShiOrderCommand ()

@property (nonatomic, copy) NSMutableArray *orderArray;

@end

@implementation LTLivingWeiShiOrderCommand

- (BOOL)stickTopChannelID:(NSString *)channelId
{
    if ([NSObject empty:channelId]) {
        return NO;
    }
    
    [self.orderArray insertObject:channelId atIndex:0];
    
    return [self archive];
}

- (NSArray *)sortDataArray:(NSArray<LTLiveChannelListDetailModel *>*)dataArray
{
    if ([NSObject empty:self.orderArray] || [NSObject empty:dataArray]) {
        return dataArray;
    }
    __block NSMutableArray *backArray = [dataArray mutableCopy];
    __block NSMutableArray *destArray = [[NSMutableArray alloc] init];
    
    LTLiveChannelListDetailModel * (^searchChannelBlock)(NSString *cid) =  ^LTLiveChannelListDetailModel *(NSString *cid) {
        __block LTLiveChannelListDetailModel *result = nil;
        [backArray enumerateObjectsUsingBlock:^(LTLiveChannelListDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.channelId isEqualToString:cid]) {
                result = obj;
                *stop = YES;
            }
        }];
        [backArray removeObject:result];
        return result;
    };
    
    [self.orderArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LTLiveChannelListDetailModel *result = searchChannelBlock(obj);
        if (![NSObject empty:result]) {
            [destArray addObject:result];
        }
    }];
    
    [destArray addObjectsFromArray:backArray];
    
    return destArray;
}

- (BOOL)archive
{
    BOOL flag = [NSKeyedArchiver archiveRootObject:self.orderArray toFile:ArchivePatch];
    return flag;
}

- (NSArray *)unArchive
{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:ArchivePatch];
    return array;
}

- (NSMutableArray *)orderArray
{
    if (!_orderArray) {
        NSArray *array = [self unArchive];
        if (array) {
            _orderArray = [array mutableCopy];
        }else {
            _orderArray = [[NSMutableArray alloc] init];
        }
        
    }
    return _orderArray;
}


@end
