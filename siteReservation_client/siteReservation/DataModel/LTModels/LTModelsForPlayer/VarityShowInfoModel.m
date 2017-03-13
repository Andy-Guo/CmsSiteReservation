//
//  VarityShowInfoModel.m
//  LetvIpadClient
//
//  Created by zhaocy on 14-9-16.
//
//

#import "VarityShowInfoModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation VarityShowMonthInfo

- (id)initWithYear:(NSString *)year andMonth:(NSString *)month
{
    if (self = [super init]) {
        self.year = year;
        self.month = month;
    }
    
    return self;
}

@end

@implementation VarityShowInfoModel

+ (VarityShowInfoModel *)varityShowInfoModelWithDict:(NSDictionary *)dictBody
{
    if (![dictBody isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    __block VarityShowInfoModel *varityShowInfo = [[VarityShowInfoModel alloc] init];
    __block NSMutableArray *arrayOrderedMonths = [NSMutableArray array]; // 年月集合
    NSArray * keyArray = [[dictBody allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 floatValue] > [obj2 floatValue]) {
            return NSOrderedAscending;
        }
        if ([obj1 floatValue] < [obj2 floatValue]) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    @synchronized(self) {
        dispatch_queue_t queue = dispatch_queue_create([@"filter" UTF8String], NULL);
        @try {
            if (keyArray && [keyArray isKindOfClass:[NSArray class]] && keyArray.count>0) {
                dispatch_apply([keyArray count], queue, ^(size_t index) {
                    NSString * year = OBJECT_OF_ATINDEX(keyArray, index);
                    NSDictionary *months = [NSString getDicValue:[dictBody objectAtPath:year]];
                    NSArray *mKeyArray = [[months allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                        if ([obj1 floatValue] > [obj2 floatValue]) {
                            return NSOrderedAscending;
                        }
                        if ([obj1 floatValue] < [obj2 floatValue]) {
                            return NSOrderedDescending;
                        }
                        return NSOrderedSame;
                    }];
                    
                    for (NSString *month in mKeyArray) {
                        
                        VarityShowMonthInfo *monthInfo = [[VarityShowMonthInfo alloc] initWithYear:year andMonth:month];
                        [arrayOrderedMonths addObject:monthInfo];
                        NSArray *arrayVideoList = [months objectForKey:month];
                        if (      nil == arrayVideoList
                            ||    ![arrayVideoList isKindOfClass:[NSArray class]]
                            ||    [arrayVideoList count] <= 0) {
                            continue;
                        }
                        varityShowInfo.videoListModel = [VideoListModel videoListModelWithVideoJsonArray:[months objectForKey:month]
                                                                                                  atYear:year
                                                                                                andMonth:month];
                        varityShowInfo.indexForVideoList = arrayOrderedMonths.count - 1;
                    }
                });
                varityShowInfo.arrayOrderedVarietyMonths = [NSArray arrayWithArray:arrayOrderedMonths];

            }else{
                varityShowInfo = nil;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            ;
        }
        queue = nil;
    }

    return varityShowInfo;
}

- (void)getNextMonthInfo:(void (^)(NSString* nextYear, NSString* nextMonth))finishBlock
{
    if (    nil == self.videoListModel
        ||  [NSString isBlankString:self.videoListModel.year]
        ||  [NSString isBlankString:self.videoListModel.month]) {
        finishBlock(nil, nil);
        return;
    }
    
    NSInteger nextIndex = -1;
    if (self.indexForVideoList < 0) {
        nextIndex = 0;
    }
    else{
        nextIndex = self.indexForVideoList + 1;
    }
    
    if (nextIndex >= self.arrayOrderedVarietyMonths.count) {
        nextIndex = -1;
    }
    
    if (nextIndex < 0) {
        finishBlock(nil, nil);
        return;
    }
    
    VarityShowMonthInfo *monthInfo = self.arrayOrderedVarietyMonths[nextIndex];
    finishBlock(monthInfo.year, monthInfo.month);
    return;
}

@end
