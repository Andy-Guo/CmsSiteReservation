//
//  FavouriteCloudModel.m
//  LeTVMobileDataModel
//
//  Created by yanyijie on 15/6/10.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "FavouriteCloudModel.h"

@implementation Pic_All

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{
                                @"180*135":@"pic_180_135",
                                @"200*150":@"pic_200_150",
                                @"320*200":@"pic_320_200",
                                @"400*250":@"pic_400_250",
                                @"960*540":@"pic_960_540",
                                @"1080*608":@"pic_1080_608",
                                @"1440*810":@"pic_1440_810",
                                @"400*300":@"pic_400_300"
                                                      }];
}

@end

@implementation FavouriteCloudModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{
                                                      @"favorite_id" : @"fav_id"
            }];
}

- (NSString *)getIcon
{
    if(![NSString empty:self.pic_all.pic_400_300])
    {
        return self.pic_all.pic_400_300;
    }
    
    if (![NSString empty:self.pic_all.pic_200_150]) {
        return self.pic_all.pic_200_150;
    }

    return @"";

}

- (NSString *)getPid
{
    if(![NSString isBlankString:self.play_id])
    {
        return self.play_id;
    }
    
    return @"0";
}

- (NSString *)getVid //优先顺序  播放记录vid-》收藏vid-》pid
{
    if(![NSObject empty:self.play_record])
    {
        if(![NSString isBlankString:self.play_record.video_id])
        {
            return self.play_record.video_id;
        }
    }
    
    if(![NSString isBlankString:self.video_id])
    {
        return self.video_id;
    }
    
    return @"";
}

- (NSInteger)getDataType
{
    return 0;
}

- (NSString *)getTitle
{
    return [NSString safeString:self.title ];
}

- (NSString *)getSubTitle
{
    NSString *info = @"";
    if(![NSString isBlankString:self.category])
    {
        NSInteger category = [self.category integerValue];
        if(category == NewCID_Anime || category == NewCID_TV)
        {
            if([self.is_end boolValue])
            {
                if(![NSString isBlankString:self.platform_now_episodes])
                {
                    info = [NSString stringWithFormat:@"%@%@",self.platform_now_episodes, NSLocalizedString(@"集全", nil)];
                }
            }
            else
            {
                if(![NSString isBlankString:self.platform_now_episodes])
                {
                    info = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"更新至", nil),self.platform_now_episodes, NSLocalizedString(@"集", nil)];
                }
            }
        }
        else if(category == NewCID_MOVIE)
        {
            if(![NSString isBlankString:self.platform_now_episodes])
            {
//                info = NSLocalizedString(@"正片已更新", @"正片已更新");
            }
            else
            {
                info = NSLocalizedString(@"即将上线", @"即将上线");
            }
        }
        else if(category == NewCID_TVProgram)
        {
            if(![NSString isBlankString:self.platform_now_episodes])
            {
                info = [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"更新至", nil), self.platform_now_episodes, NSLocalizedString(@"期", nil)];
            }
        }
//        else if(category == NewCID_Music)
//        {
//            if(![NSString isBlankString:self.singer])
//            {
//                info = self.singer;
//            }
//        }
        
    }
    
    return info;
}


- (NSString *)getFavId
{
    return [NSString safeString:self.fav_id];
}

- (NSString *)getSourceType
{
    NSString *sourceType=[NSString stringWithFormat:@"%d",ALBUM_FROM_VRS];
    if([[self getPid] isEqualToString:[self getVid]]){
        sourceType=[NSString stringWithFormat:@"%d",VIDEO_FROM_VRS];
    }
    return sourceType;
}

- (void)testStaring
{
    if(self.starring)
    {
        id test = self.starring;
        if([test isKindOfClass:[NSArray class]])
        {
            NSArray *star = test;
            if(star.count > 0)
            {
                NSLog(@"...");
            }
        }
    }
}

- (NSString *)getActorAndSingerInfo
{
    if(![NSString isBlankString:self.category])
    {
        NSInteger category = [self.category integerValue];
        if(category == NewCID_MOVIE || category == NewCID_TV)
        {
            id star = self.starring;
            if(star && [star isKindOfClass:[NSArray class]])
            {
                @autoreleasepool
                {
                    NSArray *starArr = star;
                    if(starArr.count > 0)
                    {
                        __block NSString *result = @"";
                        [starArr enumerateObjectsUsingBlock:^(NSString *star, NSUInteger idx, BOOL *stop) {
                            if(![NSString isBlankString:star])
                            {
                                result  = [result stringByAppendingString:star];
                                if(idx != starArr.count-1)
                                {
                                    result  = [result stringByAppendingString:@","];
                                }
                            }
                        }];

                        if(![NSString isBlankString:result])
                        {
                            return result;
                        }
                    }
                }
            }
        }
        else if (category == NewCID_Music)
        {
            NSString *singer = self.singer;
            if(![NSString isBlankString:singer])
            {
                return singer;
            }
        }
    }
    
    return @"";
}

- (NSString *)getCategory
{
    if(![NSString isBlankString:self.category])
    {
        return self.category;
    }
    
    return @"";
}

- (MovieInfo *)createMovieInfo
{
    if([NSString isBlankString:self.fav_id])
        return nil;
    
    MovieInfo *info = [[MovieInfo alloc]init];
    info.favCloudId = [self getFavId];
    info.title = [self getTitle];
    info.subTitle = [self getSubTitle];
    info.icon = [self getIcon];
    info.cid = [self getCategory];
    info.movie_ID = [self getPid];
    info.v_ID = [self getVid];
    info.p_ID = [self getPid];
    info.sourceType = [self getSourceType];
    info.actorAndStarInfo = [self getActorAndSingerInfo];
    info.favVersion = @"-1";
    //[self testStaring];
    return info;
}

@end


@implementation FavListMode


@end

@implementation FavVideoPlayRecord


@end
