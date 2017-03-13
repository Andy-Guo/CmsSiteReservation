//
//  LTChannelListModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-6.
//
//

#import "LTChannelListModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTChannelAlbumListModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"jump":@"__jump",
                                                       @"play":@"__play",
                                                       @"pay":@"__pay",
                                                       @"isEnd"        : @"__isEnd",
                                                       @"episodes"      : @"__episodes",
                                                       @"nowEpisodes"  : @"__nowEpisodes",
                                                       }];
}

- (BOOL)isEnd
{
    if ([NSString isBlankString:self.__isEnd]) {
        return TRUE;
    }
    return ([self.__isEnd integerValue] == 1) ? TRUE : FALSE;
}

- (NSInteger)episode
{
    return [self.__episodes integerValue];
}

- (NSInteger)nowEpisodes
{
    return [self.__nowEpisodes integerValue];
}

- (BOOL)jump
{
    return ([self.__jump integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)play
{
    return ([self.__play integerValue] == 1) ? TRUE : FALSE;
}

- (BOOL)pay
{
    return ([self.__pay integerValue] == 1) ? TRUE : FALSE;
}

-(NSString *)getIcon{
    NSString *iconUrl = @"";
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.images.pic169;
    }
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.images.pic200_150;
    }
    
    return iconUrl;
}

- (NSString *)getUpdateInfo
{
    return [self getUpdateInfoWithCid:NewCID_UnDefine];
}

- (NSString *)getUpdateInfoWithCid:(NewMovieCid)cid
{
    if (NewCID_Anime != cid
        && NewCID_TV != cid
        && NewCID_TVProgram != cid) {
        return @"";
    }
    
    if (cid == NewCID_TVProgram) {
        NSInteger episode = [self episode];
        if (self.isEnd && episode > 0) {
            if ([NSString isBlankString:self.aid]) {
                return @"";
            }
            return [NSString stringWithFormat:@"%ld期全", (long)episode, NSLocalizedString(@"期全", nil)];
        }
        else if ([self.__nowEpisodes length] >= 8) {
            NSString *month = [self.__nowEpisodes substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [self.__nowEpisodes substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:NSLocalizedString(@"%@%@-%@期", @"%@%@-%@期"),NSLocalizedString(@"更新至", nil), month, day];
        }
        else {
            return @"";
        }
    }
    
    if (    !self.isEnd
        &&  self.nowEpisodes < self.episode) {
        if (self.nowEpisodes <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%ld%@", NSLocalizedString(@"更新至", nil),(long)self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
        if (self.episode <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%ld%@", (long)self.episode, NSLocalizedString(@"集全", nil)];
        }
    }
    
    return @"";
}

- (NSString *)getUpdateInfoNew {
//    if (ALBUM_FROM_VRS != [self.type integerValue]) {
//        return @"";
//    }
    
    // 否则，根据cid判断
    if ([NSString isBlankString:self.cid]) {
        return @"";
    }
    if (    NewCID_Anime != [self.cid integerValue]
        &&  NewCID_TV != [self.cid integerValue]
        && NewCID_TVProgram != [self.cid integerValue]
        && NewCID_Kids != [self.cid integerValue]) {
        return @"";
    }
    
    if (NewCID_TVProgram == [self.cid integerValue]) {
        NSInteger episode = [self.__episodes integerValue];
        if ([self.__isEnd isEqualToString:@"1"] && episode > 0) {
            return [NSString stringWithFormat:NSLocalizedString(@"%ld期全", @"%ld期全"), (long)episode, NSLocalizedString(@"期全", nil)];
        }
        else if ([self.__nowEpisodes length] >= 8) {
            NSString *month = [self.__nowEpisodes substringWithRange:NSMakeRange(4, 2)];
            NSString *day = [self.__nowEpisodes substringWithRange:NSMakeRange(6, 2)];
            return [NSString stringWithFormat:@"%@-%@期", month, day];
        }
        else {
            return @"";
        }
    }
    
    if (    ![self.__isEnd isEqualToString:@"1"]
        &&  [self.__nowEpisodes integerValue] < [self.__episodes integerValue]) {
        if ([self.__nowEpisodes integerValue] <= 0) {
            return @"";
        }
        else{
            return [NSString stringWithFormat:@"%@%ld%@",NSLocalizedString(@"更新至", nil), (long)self.nowEpisodes, NSLocalizedString(@"集", nil)];
        }
    }
    else{
//        if ([self.episode integerValue] <= 0) {
//            return @"";
//        }
//        else{
//            return [NSString stringWithFormat:NSLocalizedString(@"%@集全", @"%@集全"), self.episode];
//        }
        return @"";
    }
    
    return @"";
    
}

@end

@implementation LTChannelListModel

//    +(JSONKeyMapper*)keyMapper
//    {
//        return [[JSONKeyMapper alloc] initWithDictionary:@{
////                                                           @"album_list":@"list",
//                                                           @"album_count":@"total",
//                                                           @"video_count":@"total",
////                                                            @"video_list":@"list",
//
//                                                           }];
//    }

@end
