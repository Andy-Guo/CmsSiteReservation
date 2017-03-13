//
//  LTSubjectDetailModel.m
//  LetvIphoneClient
//
//  Created by zhaocy on 14-3-26.
//
//

#import "LTSubjectDetailModel.h"
#import "LTDownloadCommand.h"
#import "VarityShowInfoModel.h"
#import "RecommendModel.h"

@implementation LTSubjectInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"nameCn"  : @"name",
                                                       }];
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = LTSubjectTypeAlbum;
            break;
        case 3:
            _type = LTSubjectTypeVideo;
            break;
        default:
            _type = LTSubjectTypeUnknown;
            break;
    }
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end



@implementation LTSubjectAlbum

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"pic320*200"  : @"pic320_200",
                                                       @"picHT"       : @"pic400_300",
                                                       @"picST"       : @"pic150_200",
                                                       }];
}
-(MovieDetailModel*)subjectWithAlbum:(LTSubjectAlbum*)album
{
    MovieDetailModel * movie = [[MovieDetailModel alloc]init];
    movie.pid = album.pid;
    movie.nameCn = album.title;
    movie.nowEpisodes = album.nowEpisodes;
    movie.download = album.download;
    movie.episode = album.episode;
    movie.isEnd = album.isEnd;
    movie.varietyShow = album.varietyShow;
    movie.play = [album.play integerValue];
    movie.subTitle = album.subname;
    movie.type = album.type;
    movie.cid = album.cid;
    movie.platformVideoInfo = album.platformVideoInfo;
    PicCollectionModel * picModel = [[PicCollectionModel alloc]init];
    picModel.pic150_200 = album.pic150_200;
    picModel.pic400_300 = album.pic400_300;
    picModel.pic320_200 = album.pic320_200;
    movie.picCollections = picModel;
    return movie;
}

- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = ALBUM_FROM_VRS;
            break;
        case 3:
            _type = VIDEO_FROM_VRS;
            break;
        default:
            _type = ALBUM_FROM_VRS;
            break;
    }
}

- (BOOL)isPlaySupported
{
    return ([self.play integerValue] > 0);
}

- (BOOL)isDownloadSupported
{
    return ([self.download integerValue] > 0);
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end



@implementation LTSubjectVideo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"picAll"       : @"picCollections",
                                                       }];
}


+ (LTSubjectVideo *)subjectVideoWithVideoModel:(VideoModel *)videoModel
{
    if (!videoModel) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[videoModel toDictionary]];
    LTSubjectVideo *subjectVideo = [[LTSubjectVideo alloc] initWithDictionary:dict error:nil];
    return subjectVideo;
}

-(NSString*)getMinSizeImage
{
    if (![NSString isBlankString:self.pic320_200]) {
        return self.pic320_200;
    }else{
        return self.pic400_300;
    }
}

- (BOOL)isPlaySupported
{
    return ([self.play integerValue] > 0);
}

- (BOOL)isDownloadSupported
{
    return ([self.download integerValue] > 0);
}

- (BOOL)isAlreadyDownloadComplete{
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusComplete == status);
    }
    
    return NO;
}


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end


@implementation LTSubjectDetailModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"tabVideoList"       : @"videoListModel",
                                                       @"tabAlbumList"       : @"albumList",
                                                       }];
}

-(void)setTabVideoList:(NSDictionary *)tabVideoList
{
    _tabVideoList = tabVideoList;
    
    MovieShowStyle  style = (MovieShowStyle)[[tabVideoList objectForKey:@"style"] integerValue];
    
    _style = style;
    
    if (![NSObject empty:[tabVideoList objectForKey:@"recData"]]) {
        _recommendModel = [[RecommendModel alloc]initWithDictionary:tabVideoList error:nil];
        _isRecommendData = YES;
    }else{
        if (style == MovieShowWithDate) {
            
            _albumVarityShowVideoList = [VarityShowInfoModel varityShowInfoModelWithDict:tabVideoList];
            
        }else if((style == MovieShowWithTable) || (style == MovieShowWithMatrix)){
            
            _subjectVideoList = [[VideoListModel alloc]initWithDictionary:tabVideoList error:nil];
        }

    }
}

- (NSInteger)indexOfSubjectAlbumWithAid:(NSString*)aid
{
    if ([NSString isBlankString:aid]) {
        return -1;
    }
    
    for (int i = 0; i < self.albumList.count; i++) {
        MovieDetailModel *subjectAlbum = self.albumList[i];
        if ([subjectAlbum.pid isEqualToString:aid]) {
            return i;
        }
    }
    
    return -1;
}

- (MovieDetailModel *)subjectAlbumWithAid:(NSString *)aid
{
    NSInteger idx = [self indexOfSubjectAlbumWithAid:aid];
    if (idx < 0) {
        return nil;
    }
    
    return self.albumList[idx];
}

- (MovieDetailModel *)firstValidSubjectAlbumWithAid:(NSString *)aid
{
    MovieDetailModel *currSubjectAlbum = [self subjectAlbumWithAid:aid];
    if (    nil == currSubjectAlbum
        &&  self.albumList.count > 0) {
        currSubjectAlbum = self.albumList.firstObject;
    }
    if (!currSubjectAlbum) {
        return nil;
    }
    
    if ([currSubjectAlbum play]) {
        return currSubjectAlbum;
    }
    
    return [self nextValidSubjectAlbumWithAid:currSubjectAlbum.pid];
}

- (MovieDetailModel *)nextValidSubjectAlbumWithAid:(NSString *)aid
{
    NSInteger idx = [self indexOfSubjectAlbumWithAid:aid];
    if (idx < 0) {
        return [self firstValidSubjectAlbumWithAid:nil];
    }
    
    NSInteger countAlbums = self.albumList.count;
    for (NSInteger i = idx+1; i < countAlbums; i++) {
        MovieDetailModel *subjectAlbum = self.albumList[i];
        if (    subjectAlbum
            &&  [subjectAlbum play]) {
            return subjectAlbum;
        }
    }
    
    return nil;
}

- (NSInteger)indexOfSubjectVideoWithVid:(NSString*)vid
{
    if ([NSString isBlankString:vid]) {
        return -1;
    }
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.albumVarityShowVideoList.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.subjectVideoList.videoInfo;
    }
    if (![NSObject empty:videoes]) {
        for (int i = 0; i < videoes.count; i++) {
            VideoModel *subjectAlbum = videoes[i];
            if ([subjectAlbum.vid isEqualToString:vid]) {
                return i;
            }
        }
    }
    
    return -1;
}

- (VideoModel *)subjectVideoWithVid:(NSString *)vid
{
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return nil;
    }
    VideoModel * video = nil;
    if (self.style == MovieShowWithDate) {
        video = self.albumVarityShowVideoList.videoListModel.videoInfo[idx];
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        video = self.subjectVideoList.videoInfo[idx];
    }

    return video;
}

- (VideoModel *)nextValidSubjectVideoWithVid:(NSString *)vid
{
    //如果是专辑专题包，proces中连播、后推荐反查时不查这个list
    if (self.subject.type == LTSubjectTypeAlbum) {
        return nil;
    }
    NSInteger idx = [self indexOfSubjectVideoWithVid:vid];
    if (idx < 0) {
        return [self firstValidSubjectVideoWithVid:nil];
    }
    
    NSArray * videoes = nil;
    if (self.style == MovieShowWithDate) {
        videoes = self.albumVarityShowVideoList.videoListModel.videoInfo;
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        videoes = self.subjectVideoList.videoInfo;
    }

        NSInteger countVideos = videoes.count;
        for (NSInteger i = idx+1; i < countVideos; i++) {
            VideoModel *subjectVideo = videoes[i];
            if (    subjectVideo
                &&  [subjectVideo isPlaySupported]) {
                return subjectVideo;
            }
        }
    
    return nil;
}

- (VideoModel *)firstValidSubjectVideoWithVid:(NSString *)vid
{
    VideoModel *currSubjectVideo = [self subjectVideoWithVid:vid];
    
    if (self.style == MovieShowWithDate) {
        if (    nil == currSubjectVideo
            &&  self.albumVarityShowVideoList.videoListModel.videoInfo.count > 0) {
            currSubjectVideo = self.albumVarityShowVideoList.videoListModel.videoInfo.firstObject;
        }
    }else if((self.style == MovieShowWithMatrix) || (self.style == MovieShowWithTable)){
        if (    nil == currSubjectVideo
            &&  self.subjectVideoList.videoInfo.count > 0) {
            currSubjectVideo = self.subjectVideoList.videoInfo.firstObject;
        }
    }

    if (!currSubjectVideo) {
        return nil;
    }
    
    if ([currSubjectVideo isPlaySupported]) {
        return currSubjectVideo;
    }
    
    return [self nextValidSubjectVideoWithVid:currSubjectVideo.vid];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
