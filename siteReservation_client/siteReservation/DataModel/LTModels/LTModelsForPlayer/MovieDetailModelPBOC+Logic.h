//
//  PicCollectionModelPBOC+Logic.h
//  LeTVMobileDataModel
//
//  Created by jeason on 16/3/9.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/VideoModel.h>
#import <LetvMobileDataModel/LTOrderInfo.h>
//#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
@interface MovieDetailModelPBOC (Logic)
//iPhone V6.8添加的新字段
- (instancetype)initWithVideoModel:(VideoModel*)model;
// 对应属性（__propertyName）的类型转换
//- (BOOL)download;
//- (LT_STAMP_TYPE)stamp;
//- (BOOL)isEnd;
//- (BOOL)varietyShow;
////该专辑总集数(编辑填写)
//- (NSInteger)episode;
////当前已经更新的正片集数(编辑填写的最大值)
//- (NSInteger)nowEpisodes;
////代表推送到移动端视频总数,包含正片和非正片
//- (NSInteger)platformVideoNum;
////代表推送到移动端视频总数,只包含正片总数(后台系统算出来的)
//- (NSInteger)platformVideoInfo;

// 获取专辑ID
- (NSString *)getAlbumId;
// 是否为短视频连播，首页使用
- (BOOL)isShortVideoSeries;
// 是否支持缓存
- (BOOL)isDownloadSupported;
// 是否是仅会员可下载
- (BOOL)isSupportedVipDownload;
// 更新集数显示字符串
- (NSString *)getUpdateInfo;
// at url
- (NSString *)getAtUrl;
// 是否支持分享到大咔
- (BOOL)isShareToStarcastSupported;

// 显示样式
- (MovieShowStyle)getMovieShowStyle;
// 付费片子显示信息 vip/price
- (NSString *)getVipTag;
// 付费片子订单信息
- (LTOrderInfo *)getOrderInfo;
//得到收藏icon
- (NSString *)getFavIcon;
// icon
- (NSString *)icon;
- (NSString *)getDownloadIcon;
// 是否为跟播剧
- (BOOL)isTVUpdating;
// 是否需要合并VideoList
- (BOOL)isNeedMergeVideoList;
// 是否需要倒序显示
- (BOOL)isNeedOrderVideoListDesc;
// videoList 总数
- (NSInteger)getTotalCountOfVideoInfo;
// 是否已经添加到收藏/追剧
- (BOOL)isAlreadyFavorited;
- (BOOL)isAlreadyFav;


-(BOOL)isMiniFilm;
- (BOOL)isShowWithGroup;
@end
