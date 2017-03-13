//
//  VarityShowInfoModel.h
//  LetvIpadClient
//
//  Created by zhaocy on 14-9-16.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/VideoListModel.h>

@interface VarityShowMonthInfo : NSObject

@property (nonatomic, copy) NSString *year;     // 年份
@property (nonatomic, copy) NSString *month;    // 月份

- (id)initWithYear:(NSString *)year andMonth:(NSString *)month;

@end

@interface VarityShowInfoModel : NSObject

@property (nonatomic, strong) VideoListModel *videoListModel;           // 剧集列表
@property (nonatomic, strong) NSArray *arrayOrderedVarietyMonths;       // 倒序排列的月份列表
@property (nonatomic, assign) NSInteger indexForVideoList;              // 当前剧集列表在月份列表的位置（index从0开始）
@property (nonatomic, strong) NSString<Optional>* showOuterVideolist;   //是否展示周边视频
// 接口返回数据
+ (VarityShowInfoModel *)varityShowInfoModelWithDict:(NSDictionary *)dictBody;

// 获取下一月信息：第*年，第*月
- (void)getNextMonthInfo:(void (^)(NSString* nextYear, NSString* nextMonth))finishBlock;

@end
