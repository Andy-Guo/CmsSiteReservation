//
//  VideoListModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import "VideoListModel.h"
#import "MovieDetailModel.h"
//#import "NSString+HTTPExtensions.h"
#import "LTSubjectDetailModel.h"
#import "SettingManager+VideoCode.h"

@implementation VideoListModel


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"pagenum"          : @"__pagenum",
            @"videoPosition"    : @"__videoPosition",
            }];
}

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+ (VideoListModel *)videoListModelWithSubjectVideoArray:(NSArray *)subjectVideoArray
{
    VideoListModel *videoList = [[VideoListModel alloc] init];
    for (id item in subjectVideoArray) {
        if (![item isKindOfClass:[LTSubjectVideo class]]) {
            continue;
        }
        LTSubjectVideo *subjectVideo = (LTSubjectVideo *)item;
        if (!subjectVideo) {
            continue;
        }
        [videoList appendWithVideo:[VideoModel videoModelWithSubjectVideoModel:subjectVideo]];
    }
    
    return videoList;
}

+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray
                                              atYear:(NSString *)year
                                            andMonth:(NSString *)month
{
    if (    [NSString isBlankString:year]
        ||  [NSString isBlankString:month]) {
        return nil;
    }
    
    VideoListModel *videoList = [[VideoListModel alloc] init];
    videoList.year = year;
    videoList.month = month;
    for (NSDictionary *videoDict in videoJsonArray) {
        VideoModel *videomodel = [[VideoModel alloc] initWithDictionary:videoDict error:nil];
        videomodel.createYear = year;
        videomodel.createMonth = month;
        [videoList appendWithVideo:videomodel];
    }
    
    return videoList;
}

+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray
                                              atYear:(NSString *)year
{
    if ([NSString isBlankString:year]) {
        return nil;
    }
    
    VideoListModel *videoList = [[VideoListModel alloc] init];
    videoList.year = year;
    for (NSDictionary *videoDict in videoJsonArray) {
        VideoModel *videomodel = [[VideoModel alloc] initWithDictionary:videoDict error:nil];
        videomodel.createYear = year;
        [videoList appendWithVideo:videomodel];
    }
    
    return videoList;
}


+ (VideoListModel *)videoListModelWithVideoJsonArray:(NSArray *)videoJsonArray
{
    if ([NSObject empty:videoJsonArray]) {
        return nil;
    }
    
    VideoListModel *videoList = [[VideoListModel alloc] init];
    for (NSDictionary *videoDict in videoJsonArray) {
        VideoModel *videomodel = [[VideoModel alloc] initWithDictionary:videoDict error:nil];
        [videoList appendWithVideo:videomodel];
    }
    
    return videoList;
}

+ (VideoListModel *)videoListModelWithFragmentsData:(NSDictionary *)fragmentDic
{
    if ([NSObject empty:fragmentDic]) {
        return nil;
    }
    VideoListModel *videoList = [self videoListModelWithVideoJsonArray:fragmentDic[@"data"]];
    videoList.title = fragmentDic[@"title"];
    videoList.rows = fragmentDic[@"rows"];
    videoList.nStyle = fragmentDic[@"nStyle"];
    return videoList;
}

- (BOOL)isVarietyList
{
    return (    ![NSString isBlankString:self.year]
            &&  ![NSString isBlankString:self.month]);
}

- (NSInteger)pagenum
{
    if ([NSString isBlankString:self.__pagenum]) {
        return -1;
    }
    
    NSInteger tPageNum = [self.__pagenum integerValue];
    if (tPageNum <= 0) {
        return -1;
    }
    
    return (tPageNum - 1);
}

- (NSInteger)videoPosition
{
    if ([NSString isBlankString:self.__videoPosition]) {
        return -1;
    }
    
    NSInteger tVideoPosition = [self.__videoPosition integerValue];
    if (tVideoPosition <= 0) {
        return -1;
    }
    
    return (tVideoPosition - 1);
}

- (NSInteger)indexOfVideoWithVid:(NSString*)vid
{
    if ([NSString isBlankString:vid]) {
        return -1;
    }
    
    for (int i = 0; i < self.videoInfo.count; i++) {
        VideoModel *video = self.videoInfo[i];
        if ([video.vid isEqualToString:vid]) {
            return i;
        }
    }
    
    return -1;
}

- (VideoModel *)videoWithVid:(NSString *)vid
{
    NSInteger idx = [self indexOfVideoWithVid:vid];
    if (idx < 0) {
        return nil;
    }
    
    return self.videoInfo[idx];
}

- (void)insertAtFrontWithVideoList:(VideoListModel *)other
{
    if (    nil == other
        ||  !other.videoInfo
        ||  other.videoInfo.count <= 0) {
        return;
    }
    if (nil == self.videoInfo) {
        self.videoInfo = (NSMutableArray<VideoModel, ConvertOnDemand> *)[NSMutableArray array];
    }
    NSInteger otherCount = other.videoInfo.count;
    for (int i = otherCount - 1; i >= 0; i--) {
        VideoModel *videoModel = other.videoInfo[i];
        if (nil != videoModel) {
            [self.videoInfo insertObject:videoModel atIndex:0];
        }
    }
}

- (void)appendWithVideoList:(VideoListModel *)other
{
    if (    nil == other
        ||  !other.videoInfo
        ||  other.videoInfo.count <= 0) {
        return;
    }
    if (nil == self.videoInfo) {
        self.videoInfo = (NSMutableArray<VideoModel, ConvertOnDemand> *)[NSMutableArray array];
    }
    [self.videoInfo addObjectsFromArray:other.videoInfo];
}

- (void)appendWithVideo:(VideoModel *)video
{
    if (nil == video) {
        return;
    }
    if (nil == self.videoInfo) {
        self.videoInfo = (NSMutableArray<VideoModel, ConvertOnDemand> *)[NSMutableArray array];
    }
    [self.videoInfo addObject:video];
}

- (BOOL)isSupportedCodeType:(VideoCodeType)vct
{
    for (VideoModel *video in self.videoInfo) {
        if ([[video getInnerBrList]/*JEASONbrList no del!!!!*/ containsObject:[NSNumber numberWithInt:vct]]) {
            return YES;
        }
    }
    return NO;
}
#ifdef LT_IPAD_CLIENT
- (VideoCodeType)getSupportedCodeType{
    VideoCodeType type;
    BOOL bHDSupported = [self isSupportedCodeType:VIDEO_CODE_HD];
    BOOL bSDSupported = [self isSupportedCodeType:VIDEO_CODE_SD];
    BOOL bLDSupported = [self isSupportedCodeType:VIDEO_CODE_LD];
    BOOL bULDSupported = [self isSupportedCodeType:VIDEO_CODE_ULD];
//    BOOL b1080Supported = [self isSupportedCodeType:VIDEO_CODE_1080P];

    type = [SettingManager getDefaultBitrateOfDownload];
    if (    (type == VIDEO_CODE_HD && !bHDSupported)
        ||  (type == VIDEO_CODE_SD && !bSDSupported)
        ||  (type == VIDEO_CODE_LD && !bLDSupported)
        ||  (type == VIDEO_CODE_ULD && !bULDSupported)){
//        ||  (type == VIDEO_CODE_1080P && !b1080Supported)) {
        if (bHDSupported) {
            type = VIDEO_CODE_HD;
        }
        else if (bSDSupported){
            type = VIDEO_CODE_SD;
        }
        else if (bLDSupported){
            type = VIDEO_CODE_LD;
        }
        else if (bULDSupported){
            type = VIDEO_CODE_ULD;
        }
//        else if (b1080Supported){
//            type = VIDEO_CODE_1080P;
//        }
    }
    return type;

}
#else


- (VideoCodeType)getSupportedCodeType{
    VideoCodeType type;
    BOOL bHDSupported = [self isSupportedCodeType:VIDEO_CODE_HD];
    BOOL bSDSupported = [self isSupportedCodeType:VIDEO_CODE_SD];
    BOOL bLDSupported = [self isSupportedCodeType:VIDEO_CODE_LD];
    BOOL bULDSupported = [self isSupportedCodeType:VIDEO_CODE_ULD];
    BOOL b1080Supported = [self isSupportedCodeType:VIDEO_CODE_1080P];

    type = [SettingManager getDefaultBitrateOfDownload];
    if (    (type == VIDEO_CODE_HD && !bHDSupported)
        ||  (type == VIDEO_CODE_SD && !bSDSupported)
        ||  (type == VIDEO_CODE_LD && !bLDSupported)
        ||  (type == VIDEO_CODE_ULD && !bULDSupported)
        ||  (type == VIDEO_CODE_1080P && !b1080Supported)) {
        if (bHDSupported) {
            type = VIDEO_CODE_HD;
        }
        else if (bSDSupported){
            type = VIDEO_CODE_SD;
        }
        else if (bLDSupported){
            type = VIDEO_CODE_LD;
        }
        else if (bULDSupported){
            type = VIDEO_CODE_ULD;
        }
        else if (b1080Supported){
            type = VIDEO_CODE_1080P;
        }
    }
    return type;

}
#endif

- (NSString *)getIDs {
    __block NSMutableString *ids = nil;
    
    [self.videoInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        VideoModel *item = (VideoModel *)obj;
        
        if (![NSString empty:item.vid]) {
            if (ids == nil) {
                ids = [NSMutableString stringWithString:item.vid];
            }
            else {
                ids = [NSMutableString stringWithFormat:@"%@,%@", ids, item.vid];
            }
        }
    }];
    
    if (ids == nil) {
        return @"";
    }
    
    return ids;

}

-(void)setStyleWithNSString:(NSString*)style
{
    _style = (MovieShowStyle)[style integerValue];
}


-(void)updateVideoListSelectedStateWithSelectedVideo:(VideoModel *)video
{
  [self.videoInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      VideoModel * v = obj;
      if ([v.vid isEqualToString:video.vid]) {
          v.isSelected = @"1";
      }else{
          v.isSelected = @"0";
      }
  }];
}

@end
