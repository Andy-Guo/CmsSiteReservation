//
//  LTADMergeModel.h
//  LetvIphoneClient
//
//  Created by chen on 14-3-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface LTADCombineModel : JSONModel

/*
 *前贴广告拼接状态，列表中每个元素为每个广告拼接状态，数字大于0 为成功，等于0为失败
 *"ahs": [7, 8, 10]
 */
@property (strong, nonatomic) NSArray* ahs;

/**
 *  @brief 前贴广告时长
 */
@property (strong, nonatomic) NSArray *aht;
/*
 *vs 视频拼装状态  列表中每个元素为拼接状态，数字大于0 为成功，等于0为失败
 *"vs": [14]
 */
@property (strong, nonatomic) NSString* vs;

/*
 *后贴广告拼接状态   列表中每个元素为 每个广告拼接状态，数字大于0 为成功，等于0为失败
 *"ats": [7, 8, 10]
 */
@property (strong, nonatomic) NSArray* ats;
/**
 *  @author wangyiping1, 16-02-29 15:02:46
 *
 *  @brief 中贴状态码
 */
@property (strong, nonatomic) NSArray *ams;
/**
 *  @author wangyiping1, 16-02-29 15:02:38
 *
 *  @brief 中贴广告开始时间
 */
@property (strong, nonatomic) NSArray *amp;
/**
 *  @author wangyiping1, 16-02-29 16:02:23
 *
 *  @brief 中贴广告duration
 */
@property (strong, nonatomic) NSArray *amt;
/*
 *拼接后播放地址
 */
@property (strong, nonatomic) NSString* muri;
@property (strong, nonatomic) NSString* m3u8;

@property (strong, nonatomic) NSString *vid;


- (NSInteger)getAdAhsCount;
- (BOOL)isAhsSuccess:(NSInteger)adIndex;


// 是否拼接失败 [正片拼接失败 或者 前贴/后贴全部拼接失败]
- (BOOL)isCombineFailed;

@end
