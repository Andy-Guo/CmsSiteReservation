//
//  LTSearchDataModel.m
//  LetvIphoneClient
//
//  Created by bob on 13-11-7.
//
//

#import "LTSearchDataModel.h"


@implementation LTSearchImagesData

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"150*200" : @"img_150_200",
                                                       @"300*400" : @"img_300_400",
                                                       @"200*150" : @"img_200_150",
                                                       @"400*300" : @"img_400_300",
                                                       @"120*160" : @"img_120_160",
                                                       }];
}

- (NSString *)getWidthImg {
    NSString *imageName = @"";
    
    if ([self.img_400_300 length] > 0) {
        imageName = self.img_400_300;
    }
    else if ([self.img_200_150 length] > 0) {
        imageName = self.img_200_150;
    }
    else if ([self.img_300_400 length] > 0) {
        imageName = self.img_300_400;
    }
    else if ([self.img_150_200 length] > 0) {
        imageName = self.img_150_200;
    }
    else if ([self.img_120_160 length] > 0) {
        imageName = self.img_120_160;
    }
    
    return imageName;
}

- (NSString *)getHeightImg {
    NSString *imageName = @"";
    
    if ([self.img_300_400 length] > 0) {
        imageName = self.img_300_400;
    }
    else if ([self.img_150_200 length] > 0) {
        imageName = self.img_150_200;
    }
    else if ([self.img_120_160 length] > 0) {
        imageName = self.img_120_160;
    }
    if ([self.img_400_300 length] > 0) {
        imageName = self.img_400_300;
    }
    else if ([self.img_200_150 length] > 0) {
        imageName = self.img_200_150;
    }
    
    return imageName;
}


@end

@implementation LTSpecialAlbumData
@end

@implementation LTVideoPlayUrlsElemData
@end

@implementation LTSearchVidEpisodeData
@end

@implementation LTSearchVideoListElemData
@end

@implementation LTSearchStarWorksData
@end

@implementation LTSearchStarInfoData @end

@implementation LTSearchVideoData @end

@implementation LTSearchAlbumData

- (void)setUnfold:(BOOL)isUnfold {
    if (isUnfold) {
        self.isUnfold = [NSString stringWithFormat:@"1"];
    }
    else {
        self.isUnfold = [NSString stringWithFormat:@"0"];
    }
}

- (BOOL)getIsUnfold {
    BOOL isUnfold = NO;
    
    if ([self.isUnfold isEqualToString:@"1"]) {
        isUnfold = YES;
    }
    
    return isUnfold;
}

- (BOOL)isMainVideo {
    BOOL isMain = NO;
    
    if ([self.videoType isEqualToString:@"0001"]) {
        isMain = YES;
    }
    
    return isMain;
}

- (NSString*)getReleaseDate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.releaseDate doubleValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:date];
}

@end

@implementation LTSearchDataModel
@end
