//
//  LTTabListModel.h
//  LeTVMobileDataModel
//
//  Created by bob on 15/3/29.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/VideoListModel.h>
#import <LetvMobileDataModel/RecommendModel.h>
#import <LetvMobileDataModel/VarityShowInfoModel.h>
#import <LetvMobileDataModel/LTSubjectDetailModel.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
#import <LetvMobileDataModel/LTMySelfFocusImageModel.h>
#import <LetvMobileDataModel/LTSurroundVideoModel.h>

@protocol LTTabListModelElem <NSObject>

@end

@interface LTTabListModelElem : JSONModel
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *isCurrent;
@property (nonatomic, strong) NSDictionary<Optional> *data;

@property (nonatomic, readonly) MovieShowStyle movieShowStyle;//非服务器  1:九宫格剧集  2:长列表剧集  3:按月显示
@property (nonatomic, readonly) BlockContent <Optional>* textLinkData;//非服务器 文字推广
@end


@interface LTTabListModel : JSONModel
@property (nonatomic, strong) MovieDetailModel<Optional>* albumInfo; // 正在播放的专辑信息
@property (nonatomic, strong) VideoModel<Optional> * videoInfo;//正在播放的视频信息
@property (nonatomic, strong) NSDictionary<Optional> *tabDesc;
@property (nonatomic, strong) NSDictionary<Optional> *tabZtList;
@property (nonatomic, strong) NSDictionary<Optional> *tabVideoList;
@property (nonatomic, strong) NSDictionary<Optional> *tabComment;
@property (nonatomic, strong) NSDictionary<Optional> *tabRelate;
@property (nonatomic, strong) LTSurroundVideoModel<Optional> *OuterVideoInfo;//周边视频
@property (nonatomic, strong) LTSubjectDetailModel<Optional> * subjectDetail;//非服务器返回
@property (nonatomic, readonly,getter=isRecommendData)BOOL recommendData;
@property (nonatomic, readonly,getter=isSubjectData)BOOL subjectData;
@property (nonatomic, readonly) LTTabListModelElem<Optional> * tabListModelElem;//非服务器
@property (nonatomic, strong)NSString<Optional>* showSurroundVideo;//非服务器 是否要展示周边视频

-(VideoListModel*)getVideoListModel;
-(RecommendModel*)getRecommendModel;
-(VarityShowInfoModel*)getVarityShowInfoModel;
-(LTSubjectDetailModel*)getLTSubjectDetailModel;
-(NSArray*)getTabsTitle;
-(MovieHalfScreenShowStyle)getHalfScreenShowStyle;
-(MovieShowStyle)getMovieShowStyle;
-(BlockContent*)getTextLink;
- (NSString *)getFirstTabTitleName;
@end

