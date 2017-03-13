//
//  RecommendModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-11.
//
//
#import "RecommendModel.h"
//#import "NSString+HTTPExtensions.h"
//#import "NSObject+ObjectEmpty.h"
#import "NSString+MovieInfo.h"
#import "LTDataCenter.h"
#import "LTDownloadCommand.h"


@implementation RecommendItem

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"pic320*200": @"pic320_200",
                                                       @"vid":@"id",
                                                       @"pic300*400": @"pic300_400",
                                                       }];
    
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (void)setDownloadWithNSString:(NSString*)download
{
    _download = (1 == [download integerValue]) ? YES:NO;
}

- (void)setJumpWithNSString:(NSString *)jump
{
    _jump = (1 == [jump integerValue]) ? TRUE : FALSE;
}


- (BOOL)isValidSingleVideoRecommendItem
{
    return (    3 == [self.type integerValue]
            &&  ![NSString isBlankString:self.vid]);
}

- (NSString *)getImageName {

    NSString *imageName = @"";
    
    if (![NSString empty:self.pic320_200]) {
        imageName = self.pic320_200;
    }
    else if (![NSString empty:self.picHT]) {
        imageName = self.picHT;
    }
    else if (![NSString empty:self.picST]) {
        imageName = self.picST;
    }
    
    return imageName;
}
-(void)addStatisticAction:(LTDCPageID)pageID index:(NSInteger)index
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    NSInteger wz =index+1;
    
    NSString *strCid = [NSString stringWithFormat:@"%d", NewCID_UnDefine];
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:LTDCActionPropertyCategoryHalfPlayerRelate];
    NSDictionary *dictAp = @{
                             @"fl"      : [NSString safeString:fl],
                             @"wz"      : ((wz <= 0) ? @"" : [NSString stringWithFormat:@"%ld", (long)wz]),
                             @"name"    : [NSString safeString:self.title],
                             @"pageid"  : pageid,
                             @"iosid"   : [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    [LTDataCenter addActionData:LTDCActionCodeRecommendClick
                 actionProperty:dictAp
                   actionResult:YES
                            cid:[NSString safeString:strCid]
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:self.reid
                           area:self.area
                         bucket:self.bucket
                           rank:[NSString stringWithFormat:@"%ld",(long)index+1]];
    
}
-(void)addStatisticShow:(LTDCPageID)pageID
{
    NSString *pageid =[NSString fomatPageIDEnumCode:pageID];
    
    NSString *fl = [LTDataCenter getActionCodeByActionCategory:LTDCActionPropertyCategoryHalfPlayerRelate];
//    NSString *strCid = [NSString stringWithFormat:@"%d", NewCID_UnDefine];
    NSDictionary *dictAp = @{
                             @"fl"          : fl,
                             @"pageid"      : pageid,
                             @"iosid"   :  [NSString safeString:[DeviceManager getIOSDeviceUUID]]
                             };
    
    
    [LTDataCenter addActionData:LTDCActionCodeShowForRecommend
                 actionProperty:dictAp
                   actionResult:YES
                            cid:self.cid
                            pid:nil
                            vid:nil
                            zid:nil
                     currentUrl:nil
                           reid:self.reid
                           area:self.area
                         bucket:self.bucket
                           rank:nil];
    NSLog(@"个性化推荐曝光,%@",dictAp);
}

- (BOOL)isAlreadyDownloadComplete{
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusComplete == status);
    }
    
    return NO;
}

- (BOOL) isAlreadyDownloading
{
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusDownloading == status || DownloadStatusWait == status ||DownloadStatusPause == status);
    }
    
    return NO;
}


- (NSString *)getDisplayTitle
{
    NSString *titleDisplay = self.title;
    //如果是音乐，title显示 歌曲名称和歌手
    if(![NSString isBlankString:self.singer])
    {
        titleDisplay = [NSString stringWithFormat:@"%@ %@",self.title,self.singer];
    }
    if (NewCID_TVProgram == [self.cid integerValue]) {
        if (![NSString isBlankString:self.subname]) {
            if ([NSString isBlankString:self.episode]) {
                titleDisplay = self.subname;
            }
            else{
                titleDisplay = [NSString stringWithFormat:@"%@:%@", self.episode, self.subname];
            }
        }
    }
    return titleDisplay;
}


-(void)convertMovieDetailModel:(MovieDetailModel *)movieDetail
{
    if (movieDetail != nil && [movieDetail isKindOfClass:[MovieDetailModel class]]) {
        self.vid = nil;
        self.pid = movieDetail.pid;
        self.cid = movieDetail.cid;
        self.title = movieDetail.nameCn;
        self.pidname = movieDetail.nameCn;
        self.subname = movieDetail.subTitle;
        self.picHT = [movieDetail.picCollections getImage320_200];
        self.type = [NSString stringWithFormat:@"%u",movieDetail.type];
        self.jump = movieDetail.jump;
        self.pidname = @"";
        self.episode = movieDetail.episode;
        self.isEnd = movieDetail.isEnd;
        self.nowEpisode = movieDetail.nowEpisodes;
        self.duration = [NSString stringWithFormat:@"%ld", (long)movieDetail.duration];
        self.subCategory = movieDetail.subCategory;
        self.dataArea = movieDetail.area;
        self.releaseDate = movieDetail.releaseDate;
        self.style = movieDetail.style;
        self.singer = movieDetail.singer;
        self.pay = [NSString stringWithFormat:@"%d",movieDetail.pay];
        self.starring = movieDetail.starring;
        self.director = movieDetail.directory;
        self.subCategory = movieDetail.subCategory;
        self.area = movieDetail.area;
        self.playCount = movieDetail.playCount;
        self.score = movieDetail.score;
        self.cornerMark =  movieDetail.cornerMark;//[self getCornerMarkFromMovieDetailModel:movieDetail];
        self.pic300_400 = movieDetail.picCollections.pic300_400;
 
    }
}


-(void)convertVideoModelToRecommendItem:(VideoModel *)video
{
    if (video != nil) {
        self.vid = video.vid;
        self.pid = video.pid;
        self.cid = video.cid;
        self.title = video.nameCn;
        self.subname = video.subTitle;
        self.pic320_200 = [video.picAll getImage320_200];
        self.type = [NSString stringWithFormat:@"%d", VIDEO_FROM_VRS];
        self.jump = video.jump;
        self.pidname = @"";
        self.duration = video.duration/*JEASONduration(non del!!)*/;
        self.subCategory = video.subCategory;
        self.dataArea = video.area;
        self.releaseDate = video.releaseDate;
        self.style = video.style;
        self.videoTypeName = video.videoTypeName;
        self.singer = video.singer;
        self.playCount = video.playCount;
        self.cornerMark = video.cornerMark;
        self.brList = [video getInnerBrList]/*JEASONbrList no del!!!!*/;
        self.download = video.download;
        self.mid = video.mid;
    }
}

-(NSString*)getCornerMarkFromMovieDetailModel:(MovieDetailModel*)dataModel
{
    if (!dataModel) {
        return @"";
    }
    if (![NSString isBlankString:dataModel.cornerMark]) {
        return dataModel.cornerMark;
    }
    NSInteger cid = [dataModel.cid integerValue];
    NSString * episodesTitle = @"";
    if (cid == NewCID_Anime || cid == NewCID_TV) {
        if ([dataModel.isEnd integerValue] == 1 ) {
            if ([dataModel.episode integerValue] > 0) {
                episodesTitle = [episodesTitle stringByAppendingFormat:@"%@%@",dataModel.episode,NSLocalizedString(@"集全", nil)];
            }
        }else{
            if ([dataModel.nowEpisodes integerValue] > 0) {
                episodesTitle = [episodesTitle stringByAppendingFormat:@"%@%@%@",
                                 NSLocalizedString(@"更新至", nil),
                                 dataModel.nowEpisodes,
                                 NSLocalizedString(@"集", nil)];
            }
        }
    }else if(cid == NewCID_MOVIE){
        if (![NSString isBlankString:dataModel.score]) {
            episodesTitle = [episodesTitle stringByAppendingFormat:@"%@%@",dataModel.score,NSLocalizedString(@"分", nil)];
        }
        
    }else if(cid == NewCID_TVProgram){
        
        if ([dataModel.albumTypeKey isEqualToString:kVideoTypePositive]) {
            if (![NSString isBlankString:dataModel.nowEpisodes]) {
                episodesTitle = [episodesTitle stringByAppendingFormat:@"%@%@%@",NSLocalizedString(@"最新",nil),[NSString getDayNSString:dataModel.nowEpisodes],NSLocalizedString(@"期", nil)];
                
            }
        }
    }
    return [NSString safeString:episodesTitle];
}

- (BOOL) isAlreadyDownloaded
{
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    
    if (nil != downloadInfo) {
        return YES;
    }
    
    return NO;
}

@end


@implementation RecommendModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


- (NSInteger)indexOfItemWithVid:(NSString *)vid
{
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = 0; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if (    [item isValidSingleVideoRecommendItem]
            &&  [vid isEqualToString:item.vid]) {
            return i;
        }
    }
    
    return -1;
}

- (RecommendItem *)nextValidSingleVideoRecommendItemAfterItemWithVid:(NSString *)vid
{
    NSInteger indexOfCurrItem = [self indexOfItemWithVid:vid];
    NSInteger nextBeginIndex = 0;
    if (indexOfCurrItem >= 0) {
        nextBeginIndex = indexOfCurrItem + 1;
    }
    
    NSInteger countOfItems = self.recData.count;
    for (NSInteger i = nextBeginIndex; i < countOfItems; i++) {
        RecommendItem *item = self.recData[i];
        if ([item isValidSingleVideoRecommendItem]) {
            return item;
        }
    }
    return nil;
}

@end
