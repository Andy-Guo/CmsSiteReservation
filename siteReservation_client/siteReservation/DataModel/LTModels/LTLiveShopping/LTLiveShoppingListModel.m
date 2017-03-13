//
//  LTLiveShoppingListModel.m
//  LeTVMobileDataModel
//
//  Created by Daemonson on 16/1/18.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LTLiveShoppingListModel.h"

@implementation LTLiveShoppingListModel

@end

@implementation LTShoppingPicListModel
+(JSONKeyMapper*)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"pic1"      : @"pic_thumbnail1",
                                                       @"pic2"      : @"pic_thumbnail2",
                                                       @"mobilePic" : @"pic_thumbnail3",
                                                       @"tvPic"     : @"pic_detail1",
                                                       @"400x250"   : @"pic_detail2",
                                                       @"960x540"   : @"pic_detail3",
                                                       @"1440x810"  : @"pic_detail4",
                                                       @"400x300"   : @"pic_detail5"}];
}

- (NSMutableArray *)getThumbnailImageUrls {
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    if (![NSString isBlankString:self.pic_thumbnail1]) {
        [urls addObject:self.pic_thumbnail1];
    }
    if (![NSString isBlankString:self.pic_thumbnail2]) {
        [urls addObject:self.pic_thumbnail2];
    }
    if (![NSString isBlankString:self.pic_thumbnail3]) {
        [urls addObject:self.pic_thumbnail3];
    }
    return urls;
}

- (NSMutableArray *)getDetailImageUrls {
    NSMutableArray *urls = [[NSMutableArray alloc] init];
    if (![NSString isBlankString:self.pic_detail1]) {
        [urls addObject:self.pic_detail1];
    }
    if (![NSString isBlankString:self.pic_detail2]) {
        [urls addObject:self.pic_detail2];
    }
    if (![NSString isBlankString:self.pic_detail3]) {
        [urls addObject:self.pic_detail3];
    }
    if (![NSString isBlankString:self.pic_detail4]) {
        [urls addObject:self.pic_detail4];
    }
    if (![NSString isBlankString:self.pic_detail5]) {
        [urls addObject:self.pic_detail5];
    }
    return urls;
}
@end

@implementation LTLiveShoppingModel

@end

@implementation LTProductAttentionModel
/**
 *  获取商品关注人数
 *
 *  @return 商品关注人数
 */
- (NSString *)getProductAttentionCont {
    NSInteger count = [[self.result safeValueForKey:@"cartTotalCount"] integerValue];
    NSString *totalCount = [NSString stringWithFormat:@"%ld", (long)count];
    if ([NSString isBlankString:totalCount]) {
        return @"0";
    }
    //格式化
    totalCount = [NSString getCommentNumberWithNumber:@(count)];
    return totalCount;
}
@end

