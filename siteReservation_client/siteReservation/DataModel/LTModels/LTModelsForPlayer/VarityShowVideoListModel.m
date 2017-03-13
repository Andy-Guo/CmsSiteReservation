//
//  VarityShowVideoListModel.m
//  LeTVMobileDataModel
//
//  Created by liuxuan on 15/9/8.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "VarityShowVideoListModel.h"
#import "VideoModel.h"
#import "VideoListModel.h"

@implementation VarityShowVideoListModel


+ (VarityShowVideoListModel *)varityShowVideoListModelWithDict:(NSDictionary *)dictBody
{
    if (![dictBody isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    __block VarityShowVideoListModel *varityShowVideoList = nil;
 
    NSArray * years = [dictBody allKeys];
    
    if (![NSObject empty:years]) {
        years = [years sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([obj1 floatValue] > [obj2 floatValue]) {
                return NSOrderedAscending;
            }
            if ([obj1 floatValue] < [obj2 floatValue]) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        NSMutableArray * sortYears = [[NSMutableArray alloc]init];
        varityShowVideoList = [[VarityShowVideoListModel alloc]init];
        varityShowVideoList.arrayOrderedYears = sortYears;
        @synchronized(self) {
            dispatch_queue_t queue = dispatch_queue_create([@"filter" UTF8String], NULL);
            @try {
                if (![NSObject empty:years]) {
                    dispatch_apply([years count], queue, ^(size_t index) {
                        
                        NSString * year = OBJECT_OF_ATINDEX(years, index);
                        if ([self trimmingDigit:year]) {
                            [sortYears addObject:[NSString safeString:year]];
                            NSArray *videoList = [NSString getArrayValue:[dictBody objectAtPath:year]];
                            if (videoList && [videoList isKindOfClass:[NSArray class]] && videoList.count > 0) {
                                VideoListModel * listModel = [VideoListModel videoListModelWithVideoJsonArray:videoList atYear:year];
                                varityShowVideoList.videoListModel = listModel;
                                varityShowVideoList.indexForYearList = index;
                            }
                        }
                    });
                }
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                ;
            }
            queue = nil;
        }

    }
    return varityShowVideoList;
}

- (void)getNextYear:(void (^)(NSString* nextYear))finishBlock
{
    if ([NSString isBlankString:self.videoListModel.year] || [NSObject empty:self.videoListModel.videoInfo])
    {
        if (finishBlock) {
            finishBlock(nil);
        }
        return;
    }
    
    NSInteger nextIndex = -1;
    if (self.indexForYearList < 0) {
        nextIndex = 0;
    }
    else{
        nextIndex = self.indexForYearList + 1;
    }
    
    if (nextIndex >= self.arrayOrderedYears.count) {
        nextIndex = -1;
    }
    
    if (nextIndex < 0) {
        if (finishBlock) {
            finishBlock(nil);
        }
        return;
    }
    
    NSString * nextYear = OBJECT_OF_ATINDEX(self.arrayOrderedYears, nextIndex);
    if (finishBlock) {
        finishBlock(nextYear);
    }
    return;
}

#pragma mark -- 判断是不是纯数字
+ (BOOL)trimmingDigit:(NSString*)str {
    BOOL isDigitStr = YES;
    if ([str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length >0) {
         isDigitStr = NO;
        return isDigitStr;
    }
    return isDigitStr;
}



@end
