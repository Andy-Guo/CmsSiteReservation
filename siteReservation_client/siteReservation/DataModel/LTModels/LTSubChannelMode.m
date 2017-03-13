//
//  LTSubChannelMode.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-5.
//
//

#import "LTSubChannelMode.h"
#import "NSString+MovieInfo.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTSubChannelMode

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"total" : @"__total",
            }];
}

- (NSInteger)total
{
    return [self.__total integerValue];
}

- (NSMutableArray *)getSpecAtIndex:(NSInteger)index
                         ChannelID:(ChannelID)channelID
                       VideoSource:(VIDEOSOURCE)videoSource
                       DataArray:(NSMutableArray *)array{
    
    NSMutableArray *arraySpec = [NSMutableArray array];
    OldMovieDetailModel *dataModel=(OldMovieDetailModel*) array[index];
    switch (channelID) {
        case ChannelMovie:
        case ChannelTV:
        case ChannelLetvProduce:
        case ChannelVip:
        {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"导演", nil) andValue:dataModel.directory]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"主演", nil) andValue:dataModel.starring]];
        }
            break;
        case ChannelAnime:
        case ChannelDocumentary:
        {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil) andValue:dataModel.area]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil) andValue:dataModel.subCategory]];
        }
            break;
        case ChannelEntertainment:
            if (ALBUM_FROM_VRS == videoSource) {
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"上映时间", nil) andValue:dataModel.year]];
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil) andValue:dataModel.area]];
            }
            else {
                NSArray *timeArray = [dataModel.ctime componentsSeparatedByString:@" "];
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"时长", nil) andValue:[NSString formateTimeLength:dataModel.duration]]];
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"更新时间", nil) andValue:timeArray[0]]];
            }
            break;
        case ChannelFashion:
        case ChannelSport:
        case ChannelFinance:
        case ChannelCar:
        case ChannelTravel:
        {
            NSArray *timeArray = [dataModel.ctime componentsSeparatedByString:@" "];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"时长", nil) andValue:[NSString formateTimeLength:dataModel.duration]]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"更新时间", nil) andValue:timeArray[0]]];
        }
            break;
        case ChannelTVProgram:
        {
            NSString *yearString = nil;
            NSString *isEndValue = dataModel.isEnd;
            if (    ![NSString isBlankString:isEndValue]
                &&  [isEndValue isEqualToString:@"0"]) {
                yearString = [NSString stringWithFormat:NSLocalizedString(@"%@期全", nil), dataModel.count, NSLocalizedString(@"all_stage", nil)];
            }
            else{
                yearString = [NSString stringWithFormat:NSLocalizedString(@"%@%@期", nil),NSLocalizedString(@"更新至", nil), dataModel.count];
            }
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"期数", nil) andValue:yearString]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil) andValue:dataModel.subCategory]];
        }
            break;
        case ChannelLetvMake:
        {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"节目类型", nil) andValue:dataModel.subCategory]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"专辑类型", nil) andValue:dataModel.albumtype]];
            
        }
            break;
        case ChannelMusic:
            if (ALBUM_FROM_VRS == videoSource) {
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil) andValue:dataModel.area]];
                [arraySpec addObject:[NSString formatMovieSpecWithName:@"" andValue:dataModel.count]];
            }
            else {
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"歌手", nil) andValue:dataModel.starring]];
                [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"风格", nil) andValue:dataModel.subCategory]];
            }
            break;
        case ChannelOpenClass:
        {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"学校", nil) andValue:dataModel.school]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"讲师", nil) andValue:dataModel.directory]];
        }
            break;
        default:
            break;
    }
    
    return arraySpec;
    
}

- (NSString *)getUpdateInfoAtIndex:(NSInteger)index isNeedEndInfo:(BOOL)bNeedEndInfo DataArray:(NSMutableArray *)array{
    
    if (![self isJujiAtIndex:index DataArray:array]) {
        return @"";
    }
    OldMovieDetailModel *dataModel=(OldMovieDetailModel*) array[index];
    NSString *strCountValue = dataModel.count;
    if ([strCountValue integerValue] <= 0) {
        return @"";
    }
    
    NSString *isEndValue = dataModel.isEnd;
    if (    ![NSString isBlankString:isEndValue]
        &&  [isEndValue isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"更新至", nil), strCountValue,NSLocalizedString(@"集", nil)];
    }
    else if (bNeedEndInfo){
        return [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"更新至", nil), strCountValue, NSLocalizedString(@"集全", nil)];
    }
    
    return @"";
    
}

- (BOOL)isJujiAtIndex:(NSInteger)index DataArray:(NSMutableArray *)array{
    OldMovieDetailModel *dataModel=(OldMovieDetailModel*) array[index];
    NSString *strVideoType = dataModel.type;
    BOOL isFromLibrary = NO;
    if (    ![NSString isBlankString:strVideoType]
        &&  [strVideoType integerValue] == ALBUM_FROM_VRS) {
        isFromLibrary = YES;
    }
    
    if (!isFromLibrary) {
        return NO;
    }
    
    NSString *strStyle = dataModel.style;
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
@end
