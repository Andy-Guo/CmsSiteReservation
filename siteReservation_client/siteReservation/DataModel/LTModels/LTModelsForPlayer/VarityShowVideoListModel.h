//
//  VarityShowVideoListModel.h
//  LeTVMobileDataModel
//
//  Created by liuxuan on 15/9/8.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoListModel;
@interface VarityShowVideoListModel : NSObject

@property (nonatomic, strong) VideoListModel *videoListModel;   //当前videoList
@property (nonatomic, strong) NSString * currentYear;//当前list所在的年
@property (nonatomic, strong) NSArray *arrayOrderedYears;       // 倒序排列的年列表
@property (nonatomic, assign) NSInteger indexForYearList;       // 当前剧集列表在年份列表的位置（index从0开始）
+ (VarityShowVideoListModel *)varityShowVideoListModelWithDict:(NSDictionary *)dictBody;

// 获取下一年
- (void)getNextYear:(void (^)(NSString* nextYear))finishBlock;

@end
