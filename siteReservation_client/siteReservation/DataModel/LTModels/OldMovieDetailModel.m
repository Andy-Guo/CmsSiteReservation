//
//  OldMovieDetailModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-3.
//
//

#import "OldMovieDetailModel.h"
//#import "NSString+HTTPExtensions.h"
#import "NSString+MovieInfo.h"

@implementation OldMovieDetailModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"isend" : @"isEnd",
            @"time_length" : @"duration",
            @"director":@"directory",
            @"actor":@"starring",
            @"intro":@"desc",
            @"subcate":@"subCategory",
            @"tv":@"playTv",
            @"rcompany":@"school",
            @"needJump":@"jump",
            @"":@"",
            }];
    
    
    
}

- (NSString*)getIcon{
    
    NSString *iconUrl = @"";
#ifdef LT_IPAD_CLIENT
    if ([DeviceManager isRetina]) {
        iconUrl = self.icon_300x400;
    }
#endif
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.icon_400x300;
    }
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.icon_200x150;
    }
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.icon;
    }
    
    return iconUrl;
}

- (NSString *)getSinglePrice
{
    CGFloat singleprice = [self.singlePrice floatValue];
    return [NSString stringWithFormat:@"￥%.2f", singleprice];
}

- (VIPAllowMonth) getAllowMonth
{
    VIPAllowMonth allowMonth = VIP_ALLOWMONTH_UNDEFINE;

    allowMonth = [self.allowMonth intValue];

    if (    allowMonth < VIP_ALLOWMONTH_UNDEFINE
        ||  allowMonth >= VIP_ALLOWMONTH_COUNT) {
        allowMonth = VIP_ALLOWMONTH_UNDEFINE;
    }
    
    return allowMonth;
}

- (LT_VIDEO_AT)getVideoAt{
    
    return [NSString formateVideoAtValue:self.at];
}
- (BOOL)isAlbum{
    
    NSString *strVideoType = self.type;
    if (    ![NSString isBlankString:strVideoType]
        &&  [strVideoType integerValue] == ALBUM_FROM_VRS) {
        return YES;
    }
    
    return NO;
}

- (BOOL)IsNeedJump{
    
    NSString *needJumpValue = self.jump;
    
    if ([NSString isBlankString:needJumpValue]) {
        return NO;
    }
    
    return [needJumpValue isEqualToString:@"2"];
}

- (BOOL)isNeedPay{
    BOOL bNeedPay = (2 == [self.pay integerValue]);
    
    return bNeedPay;
}

- (BOOL) isPrevue{
    
    NSString *strStamp = self.albumtype_stamp;
    
    if ([NSString isBlankString:strStamp]) {
        return NO;
    }
    
    if ([strStamp integerValue] != 2) {
        return NO;
    }
    
    return YES;
    
}
- (NSString *)getUpdateInfo:(BOOL)bNeedEndInfo{
    
    if (![self isJuji]) {
        return @"";
    }
    
    NSString *strCountValue = self.count;
    if ([strCountValue integerValue] <= 0) {
        return @"";
    }
    
    NSString *isEndValue = self.isEnd;
    if (    ![NSString isBlankString:isEndValue]
        &&  [isEndValue isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"更新至", nil),strCountValue,NSLocalizedString(@"集", nil)];
    }
    else if (bNeedEndInfo){
        return [NSString stringWithFormat:@"%@%@", strCountValue,NSLocalizedString(@"集全", nil)];
    }
    
    return @"";
    
}

- (BOOL)isJuji{
    NSString *strVideoType = self.type;
    BOOL isFromLibrary = NO;
    if (    ![NSString isBlankString:strVideoType]
        &&  [strVideoType integerValue] == ALBUM_FROM_VRS) {
        isFromLibrary = YES;
    }
    
    if (!isFromLibrary) {
        return NO;
    }
    
    NSString *strStyle = self.style;
    NSInteger nStyle = 0;

    nStyle = [strStyle integerValue];
    if (nStyle <= 0) {
        nStyle = 2;
    }
    
    if (1 != nStyle) {
        return NO;
    }
    
    return YES;

}

- (NSString*) getVipTag
{
    BOOL bNeedPay = (2 == [self.pay integerValue]);
    if (bNeedPay) {
        return @"VIP";
    }
    else{
        return @"";
    }
    
}

- (NSMutableArray *)getSpecArray
{
    NSMutableArray *arraySpec = [NSMutableArray array];
    if (    [kCidMovie isEqualToString:self.cid]
        ||  [kCidTV isEqualToString:self.cid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"导演", nil)
                                                      andValue:self.directory]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"主演", nil)
                                                      andValue:self.starring]];
        
    }
    else if ([kCidAnime isEqualToString:self.cid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil)
                                                      andValue:self.area]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil)
                                                      andValue:self.subCategory]];
    }
    else {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"标签", nil)
                                                      andValue:self.tags]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"播放数", nil)
                                                      andValue:self.playcount]];
    }
    return arraySpec;
}

-(BOOL)isMiniFilm{
    if([self.filmstyle integerValue]==43){
        return YES;
    }
    return NO;
    
}

@end
