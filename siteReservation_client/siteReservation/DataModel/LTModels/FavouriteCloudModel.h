//
//  FavouriteCloudModel.h
//  LeTVMobileDataModel
//
//  Created by yanyijie on 15/6/10.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/MovieInfo.h>

@interface FavVideoPlayRecord : JSONModel
@property (nonatomic,copy)NSString<Optional> *video_id;
@property (nonatomic,copy)NSString<Optional> *video_next_id;
@property (nonatomic,copy)NSString<Optional> *video_current_time;
@property (nonatomic,copy)NSString<Optional> *current_episode;
@end

@protocol Pic_All @end
@interface Pic_All : JSONModel

@property (nonatomic,copy)NSString<Optional> *pic_180_135;
@property (nonatomic,copy)NSString<Optional> *pic_200_150;
@property (nonatomic,copy)NSString<Optional> *pic_320_200;
@property (nonatomic,copy)NSString<Optional> *pic_400_250;
@property (nonatomic,copy)NSString<Optional> *pic_960_540;
@property (nonatomic,copy)NSString<Optional> *pic_1080_608;
@property (nonatomic,copy)NSString<Optional> *pic_1440_810;
@property (nonatomic,copy)NSString<Optional> *pic_400_300;

@end

@protocol FavouriteCloudModel @end
@interface FavouriteCloudModel : JSONModel

@property (nonatomic,copy)NSString<Optional> *fav_id;
@property (nonatomic,strong)id<Optional> starring;
@property (nonatomic,copy)NSString<Optional> *favorite_type;
@property (nonatomic,copy)NSString<Optional> *channel_id;
@property (nonatomic,copy)NSString<Optional> *video_id;
@property (nonatomic,copy)NSString<Optional> *play_id;
@property (nonatomic,copy)NSString<Optional> *category;
@property (nonatomic,copy)NSString<Optional> *episode;
@property (nonatomic,copy)NSString<Optional> *product;
@property (nonatomic,copy)NSString<Optional> *offline;

@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *sub_title;
@property (nonatomic,copy)NSString<Optional> *category_name;
@property (nonatomic,copy)NSString<Optional> *sub_category;
@property (nonatomic,copy)NSString<Optional> *platform_can_play;
@property (nonatomic,copy)NSString<Optional> *create_time;
@property (nonatomic,copy)NSString<Optional> *is_end;
@property (nonatomic,copy)NSString<Optional> *platform_now_episodes;
@property (nonatomic,copy)NSString<Optional> *platform_now_video_id;
@property (nonatomic,copy)NSString<Optional> *productName;

@property (nonatomic,copy)NSString<Optional> *singer;

@property (nonatomic,strong)Pic_All<Optional>  *pic_all;
@property (nonatomic,strong)FavVideoPlayRecord<Optional> *play_record;


- (NSString *)getIcon;
- (NSString *)getTitle;
- (NSString *)getSubTitle;

- (MovieInfo *)createMovieInfo;
@end


@protocol FavListMode @end

@interface FavListMode:JSONModel

@property (nonatomic,copy)NSString<Optional> *page;
@property (nonatomic,copy)NSString<Optional> *pagesize;
@property (nonatomic,copy)NSString<Optional> *total;
@property (nonatomic,strong)NSArray<FavouriteCloudModel,Optional> *items;

@end

