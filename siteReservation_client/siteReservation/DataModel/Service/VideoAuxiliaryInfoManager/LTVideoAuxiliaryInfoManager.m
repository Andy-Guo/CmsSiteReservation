//
//  LTVideoAuxiliaryInfoManager.m
//  LetvIphoneClient
//
//  Created by Letv on 14-8-29.
//
//
#ifdef LT_IPAD_CLIENT

#import "LTVideoAuxiliaryInfoManager.h"

@interface LTVideoAuxiliaryInfoManager ()
@property (nonatomic, strong) NSArray *ats; //判断at值是否存在
@property (nonatomic, strong) NSArray *pageStyles;//判断contentStyle是否存在
@property (nonatomic, strong) NSArray *channelPageStyles;
@end

@implementation LTVideoAuxiliaryInfoManager

+ (LTVideoAuxiliaryInfoManager *)defaultManager
{
    static LTVideoAuxiliaryInfoManager *exist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        exist = [[LTVideoAuxiliaryInfoManager alloc] init];
    });
    return exist;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.ats = @[[NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_SmallPlayer],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_FullscreenPlayer_OneVideo],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_FullscreenPlayer_Living],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Web],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_WebView],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_RecommendApp],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Channel],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_VipChannel],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_PayLetvVIP],
#if 0   //联通sdk 适配IPv6
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_UnicomOrder],
#endif
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_MyScore],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Login],

                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Hot],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Sports],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Music],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Ent],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Other],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Hotspot],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Subject],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Star],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Star_Ranklist],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Brand],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Game],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Information],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Finance],
                     ];
        
        // 首页的contenstyle
        self.pageStyles = @[
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title],
                            #ifndef LT_MERGE_FROM_IPAD_CLIENT
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Search],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Hot_Words],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigLeft_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigLeft_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_New_Promotion],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Focus_New],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoBig_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoBig_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Star],
                            #else
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Live],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_BigPoster_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_BigPoster_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoPoster_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoPoster_Title_More],
                            #endif /* LT_MERGE_FROM_IPAD_CLIENT */
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Heavy_Recommend],
                            ];
        // 频道页的contenstyle
        self.channelPageStyles = @[
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_VIP_Promotion],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Movie_List],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Chart],
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Live],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Search],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Hot_Words],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigLeft_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigLeft_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoBig_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoBig_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Navigation_New],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Horizontal_Text_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Horizontal_Text],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Vertical_Text_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Vertical_Text],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_Star],
#else
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_BigPoster_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_BigPoster_Title_More],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoPoster_Title],
                                   [NSString stringWithFormat:@"%ld",(long)PageStyle_TwoPoster_Title_More],
#endif
                                   ];
    }
    return self;
}

- (BOOL)isExistVideoAt:(NSString *)at
{
    BOOL exist = NO;
    if ([self.ats containsObject:at]) {
        exist = YES;
    }
    return exist;
}

- (BOOL)isExistPageStyle:(NSString *)pageStyle
{
    BOOL exist = NO;
    if ([self.pageStyles containsObject:pageStyle]) {
        exist = YES;
    }
    return exist;
}

- (BOOL)isExistChannelPageStyle:(NSString *)pageStyle
{
    BOOL exist = NO;
    if ([self.channelPageStyles containsObject:pageStyle]) {
        exist = YES;
    }
    return exist;
}
@end
#else


#import "LTVideoAuxiliaryInfoManager.h"

@interface LTVideoAuxiliaryInfoManager ()
@property (nonatomic, strong) NSArray *ats; //判断at值是否存在
@property (nonatomic, strong) NSArray *pageStyles;//判断contentStyle是否存在
@property (nonatomic, strong) NSArray *channelPageStyles;
@end

@implementation LTVideoAuxiliaryInfoManager

+ (LTVideoAuxiliaryInfoManager *)defaultManager
{
    static LTVideoAuxiliaryInfoManager *exist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        exist = [[LTVideoAuxiliaryInfoManager alloc] init];
    });
    return exist;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.ats = @[[NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_SmallPlayer],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_FullscreenPlayer_OneVideo],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_FullscreenPlayer_Living],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Web],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_WebView],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_RecommendApp],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Channel],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_VipChannel],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_PayLetvVIP],
#if 0   //联通sdk 适配IPv6
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_UnicomOrder],
#endif
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_MyScore],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Login],

                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Hot],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Sports],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Music],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Ent],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Other],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Hotspot],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Subject],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Star],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Star_Ranklist],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Brand],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Game],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Information],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_Live_Finance],
                     [NSString stringWithFormat:@"%d", LT_VIDEO_AT_5_HK_Sports],
                     ];
        
        // 首页的contenstyle
        self.pageStyles = @[
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Focus],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Live],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Search],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Image],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Navigation],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Movie_List],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Hot_Words],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Chart],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_VIP_Promotion],

#ifndef LT_MERGE_FROM_IPAD_CLIENT
                            /**Phone专用**/
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Title_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_New_Promotion],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Focus_New],
#endif
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Horizontal_Text_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Horizontal_Text],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Vertical_Text_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Vertical_Text],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Navigation_New],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Dynamic_Movie_List],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Activity_Proment],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Star_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Star],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Test],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_subTitle],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Service_Area],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Advertisement],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Member_Activity],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_FloatLayer_Activity],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_More_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_OneBigTop_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_More_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_ThreePoster_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_More_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_NoMore],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_More],
//                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_Middle_NoMore],
//                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_Middle_More],
//                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_Big_NoMore],
//                            [NSString stringWithFormat:@"%ld",(long)PageStyle_H5Web_Big_More],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_VIP_Activity_CHA],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Recommend_ChannelPlayer],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_WithHotVideo_Title],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_WithHotVideo_Title_Exchange],
                            [NSString stringWithFormat:@"%ld",(long)PageStyle_Card_Player_NoMore],
                            ];
        
        // 首页和频道页现在用的一套contentstyle
        self.channelPageStyles = self.pageStyles;
    }
    return self;
}

- (BOOL)isExistVideoAt:(NSString *)at
{
    BOOL exist = NO;
    if ([self.ats containsObject:at]) {
        exist = YES;
    }
    return exist;
}

- (BOOL)isExistPageStyle:(NSString *)pageStyle
{
    BOOL exist = NO;
    if ([self.pageStyles containsObject:pageStyle]) {
        exist = YES;
    }
    return exist;
}

- (BOOL)isExistChannelPageStyle:(NSString *)pageStyle
{
    BOOL exist = NO;
    if ([self.channelPageStyles containsObject:pageStyle]) {
        exist = YES;
    }
    return exist;
}
@end
#endif
