//
//  LTDownItemModel.h
//  LeTVMobileDataModel
//
//  Created by dong on 15/12/22.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/VideoListModel.h>
#import <LetvMobileDataModel/MovieDetailModel.h>
#import <LetvMobileDataModel/VarityShowInfoModel.h>
#import <LetvMobileDataModel/RecommendModel.h>
#import <LetvMobileDataModel/VarityShowVideoListModel.h>

@interface LTDownItemModel : NSObject

@property (nonatomic, strong) NSString * regionName;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger currPageIndex;
@property (nonatomic, assign) MovieShowStyle style;
@property (nonatomic, strong) VideoListModel *videoList;
@property (nonatomic, assign) BOOL isLastItem;
@property (nonatomic, strong) NSString * year;
@property (nonatomic, strong) NSString * currentYear;
@property (nonatomic, strong) MovieDetailModel * movieDetail;
@property (nonatomic, strong) NSMutableArray<VideoModel>* itemsArray;
@property (nonatomic, strong) NSString * pic320_200;
@property (nonatomic, strong) NSString * recommendPidName;

-(NSArray*)getDownItemModelArrayWithVideoList:(VideoListModel *)videoList withMovieDetail:(MovieDetailModel *)MovieDetail withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle withRecommendModel:(NSArray *)RecommendArray subjectListType:(BOOL)subjectType;

@end
