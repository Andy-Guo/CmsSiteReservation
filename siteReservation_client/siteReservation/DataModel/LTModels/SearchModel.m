//
//  SearchModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-5.
//
//

#import "SearchModel.h"
//#import "NSString+HTTPExtensions.h"
//#import "NSObject+ObjectEmpty.h"
#import "NSString+MovieInfo.h"

@implementation SearchSuggestModel

@end

@implementation HotWordsModel


@end

@implementation SearchHotWordsModel

@end

@implementation SearchSubNavModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"c" : @"cid",
            }];
    
    
    
}
@end

@implementation SearchModel

- (BOOL)totalValueExist {
    return ![NSString isBlankString:self.total];
}

- (BOOL)isEmptyResult
{
    return (    nil == self.data
            ||  self.data.count <= 0);
}

- (NSMutableArray *)dataArray{
    NSMutableArray *array=[NSMutableArray array];
    [array addObjectsFromArray:self.data];
    if ([NSObject empty:array] || [array count] <= 0) {
        NSArray *filmArray = self.film;
        if ( [filmArray count] > 0) {
            
            //搜索结果为空，推荐 1部电影，2部电视剧
            NSMutableArray *recommandationArray;
            recommandationArray = [NSMutableArray array];
            
            for (int i = 0; i < [self.tv count]; i++) {
                [recommandationArray addObject:self.tv[i]];
            }
            
            for (int i = 0; i < [filmArray count]; i++) {
                [recommandationArray addObject:filmArray[i]];
            }
            array = nil;
            array = [NSMutableArray arrayWithArray:recommandationArray];
            
            return array;
        }
        return nil;
    }
    return self.data;
}

- (OldMovieDetailModel *)dataModel:(NSInteger)index{
    if ([self dataArray].count>0 && index<[self dataArray].count) {
        return  [self dataArray][index];
    }
    return nil;
}

- (SearchSubNavModel *)subNavModel:(NSInteger)index{
    if (self.subNav.count>0 && index <self.subNav.count) {
          return self.subNav[index];
    }
    return nil;
}

- (NSMutableArray *)getSpec:(OldMovieDetailModel *)dataModel{
    
    NSMutableArray *arraySpec = [NSMutableArray array];
    
    NSString *strCid = dataModel.cid;
    if (    [kCidMovie isEqualToString:strCid]
        ||  [kCidTV isEqualToString:strCid]
        ||  [kCidLetvProduce isEqualToString:strCid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"导演", nil) andValue:dataModel.directory]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"主演", nil) andValue:dataModel.starring]];
    }
    else if (   [kCidAnime isEqualToString:strCid]
             || [kCidDocumentary isEqualToString:strCid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil) andValue:dataModel.area]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil) andValue:dataModel.subCategory]];
    }
    else if ([kCidEntertainment isEqualToString:strCid]) {
        if (ALBUM_FROM_VRS == [dataModel.type integerValue]) {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"上映时间", nil) andValue:dataModel.year]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil) andValue:dataModel.subCategory]];
        }
        else {
            NSArray *timeArray = [dataModel.ctime componentsSeparatedByString:@" "];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"时长", nil) andValue:[NSString formateTimeLength:dataModel.duration]]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"更新时间", nil) andValue:timeArray[0]]];
        }
    }
    else if (   [kCidFasion isEqualToString:strCid]
             || [kCidSport isEqualToString:strCid]) {
        NSArray *timeArray = [dataModel.ctime componentsSeparatedByString:@" "];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"时长", nil) andValue:[NSString formateTimeLength:dataModel.duration]]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"更新时间", nil) andValue:timeArray[0]]];
    }
    else if ([kCidTVProgram isEqualToString:strCid]) {
        NSString *yearString = nil;
        NSString *isEndValue = dataModel.isEnd;
        if (    ![NSString isBlankString:isEndValue]
            &&  [isEndValue isEqualToString:@"0"]) {
            yearString = [NSString stringWithFormat:NSLocalizedString(@"%@期全", nil), dataModel.count];
        }
        else {
            yearString = [NSString stringWithFormat:NSLocalizedString(@"%@%@期", nil), NSLocalizedString(@"更新至", nil), dataModel.count];
        }
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"期数", nil) andValue:yearString]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"类型", nil) andValue:dataModel.subCategory]];
    }
    else if ([kCidLetvMake isEqualToString:strCid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"节目类型", nil) andValue:dataModel.subCategory]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"专辑类型", nil) andValue:dataModel.albumtype]];
    }
    else if ([kCidMusic isEqualToString:strCid]) {
        if (ALBUM_FROM_VRS == [dataModel.type integerValue]) {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"地区", nil) andValue:dataModel.area]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:@"" andValue:dataModel.count]];
        }
        else {
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"歌手", nil) andValue:dataModel.starring]];
            [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"风格", nil) andValue:dataModel.subCategory]];
        }
    }
    else if ([kCidOpenClass isEqualToString:strCid]) {
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"学校", nil) andValue:dataModel.school]];
        [arraySpec addObject:[NSString formatMovieSpecWithName:NSLocalizedString(@"讲师", nil) andValue:dataModel.directory]];
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
        return [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"更新至", nil),strCountValue ,NSLocalizedString(@"集", nil)];
    }
    else if (bNeedEndInfo){
        return [NSString stringWithFormat:@"%@%@", strCountValue, NSLocalizedString(@"集全", nil)];
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
