
//  LTPlayHistoryCommand.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-15.
//
//

#import "LTPlayHistoryCommand.h"

#import "MovieDetailModel.h"
#import "VideoModel.h"
#import "SqlDBHelper.h"
#import "LTCloudRecordModel.h"
//#import "NSString+HTTPExtensions.h"
//#import "NSObject+ObjectEmpty.h"
#import "LTDataModelEngine.h"
#import "LTRequestURLManager.h"
#import "LTDataCenter.h"

@implementation LTPlayHistoryCommand

- (BOOL)updateDB
{
    if ([NSString isBlankString:self.movie_id]) {
        return NO;
    }
    
//#ifdef LT_IPAD_CLIENT
//     LTPlayHistoryCommand *playHistory = [LTPlayHistoryCommand searchByMovieID:self.movie_id];
//#else
    LTPlayHistoryCommand *playHistory = [LTPlayHistoryCommand searchByMovieID:self.movie_id videoType:self.videoKey];
//#endif
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    
    if (nil == playHistory) {
      
#ifdef LT_IPAD_CLIENT
        // insert
        BOOL bResult = [db executeUpdate:
                        @"INSERT INTO ltPlayHistory ( \
                        movie_ID,nameCn, subTitle, icon, score, cid, type, at, releaseDate, directory, starring, \
                        desc, area, subCategory, playTv, school, pid, \
                        vid, vnameCn, vmid, vepisode, vporder, vicon, vtype, \
                        pay, \
                        duration, offset, updateTime, deviceFrom, videoKey \
                        ,nvid,pic) \
                        VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        self.movie_id,
                        [NSString safeString:self.nameCn],
                        [NSString safeString:self.subTitle],
                        [NSString safeString:self.icon],
                        [NSString safeString:self.score],
                        [NSString safeString:self.cid],
                        [NSString stringWithFormat:@"%d", self.type],
                        [NSString stringWithFormat:@"%d", self.at],
                        [NSString safeString:self.releaseDate],
                        [NSString safeString:self.directory],
                        [NSString safeString:self.starring],
                        [NSString safeString:self.desc],
                        [NSString safeString:self.area],
                        [NSString safeString:self.subCategory],
                        [NSString safeString:self.playTv],
                        [NSString safeString:self.school],
                        [NSString safeString:self.pid],
                        [NSString safeString:self.vid],
                        [NSString safeString:self.vnameCn],
                        [NSString safeString:self.vmid],
                        [NSString stringWithFormat:@"%ld", (long)self.vepisode],
                        [NSString stringWithFormat:@"%ld", (long)self.vporder],
                        [NSString safeString:self.vicon],
                        [NSString safeString:self.vtype],
                        self.pay ? @"1" : @"0",
                        [NSString stringWithFormat:@"%ld", (long)self.duration],
                        [NSString stringWithFormat:@"%ld", (long)self.offset],
                        [formatter stringFromDate:self.updateTime],
                        [NSString safeString:self.deviceFrom],
                        [NSString safeString:self.videoKey],
                        [NSString safeString:self.nvid],
                        [NSString safeString:self.pic]
                        ];

        
#else
        // insert
        BOOL bResult = [db executeUpdate:
                        @"INSERT INTO ltPlayHistory ( \
                        movie_ID,nameCn, subTitle, icon, score, cid, type, at, releaseDate, directory, starring, \
                        desc, area, subCategory, playTv, school, pid, \
                        vid, vnameCn, vmid, vepisode, vporder, vicon, vtype, \
                        pay, \
                        duration, offset, updateTime, deviceFrom, videoKey \
                        ,nvid,shortFlag) \
                        VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                        self.movie_id,
                        [NSString safeString:self.nameCn],
                        [NSString safeString:self.subTitle],
                        [NSString safeString:self.icon],
                        [NSString safeString:self.score],
                        [NSString safeString:self.cid],
                        [NSString stringWithFormat:@"%d", self.type],
                        [NSString stringWithFormat:@"%d", self.at],
                        [NSString safeString:self.releaseDate],
                        [NSString safeString:self.directory],
                        [NSString safeString:self.starring],
                        [NSString safeString:self.desc],
                        [NSString safeString:self.area],
                        [NSString safeString:self.subCategory],
                        [NSString safeString:self.playTv],
                        [NSString safeString:self.school],
                        [NSString safeString:self.pid],
                        [NSString safeString:self.vid],
                        [NSString safeString:self.vnameCn],
                        [NSString safeString:self.vmid],
                        [NSString stringWithFormat:@"%ld", (long)self.vepisode],
                        [NSString stringWithFormat:@"%ld", (long)self.vporder],
                        [NSString safeString:self.vicon],
                        [NSString safeString:self.vtype],
                        self.pay ? @"1" : @"0",
                        [NSString stringWithFormat:@"%ld", (long)self.duration],
                        [NSString stringWithFormat:@"%ld", (long)self.offset],
                        [formatter stringFromDate:self.updateTime],
                        [NSString safeString:self.deviceFrom],
                        [NSString safeString:self.videoKey],
                        [NSString safeString:self.nvid],
                        [NSString safeString:self.shortFlag]
                        ];
#endif
        
        NSLog(@"DB ERRORR %@",[db lastErrorMessage]);
        return bResult;
    }
    else{
#ifdef LT_IPAD_CLIENT
        // update
        BOOL bResult = [db executeUpdate:
                        @"UPDATE ltPlayHistory set \
                        nameCn = ?, subTitle = ?, icon = ?, score = ?, cid = ?, type = ?, at = ?, releaseDate = ?, directory = ?, starring = ?, \
                        desc = ?, area = ?, subCategory = ?, playTv = ?, school = ?, pid = ?, \
                        vid = ?, vnameCn = ?, vmid = ?, vepisode = ?, vporder = ?, vicon = ?, vtype = ?, \
                        pay = ?, \
                        duration = ?, offset = ?, updateTime = ? ,deviceFrom = ?, videoKey = ?\
                        ,nvid = ?\,pic = ?\
                        where movie_ID = ? and videoKey = ?",
                        [NSString safeString:self.nameCn],
                        [NSString safeString:self.subTitle],
                        [NSString safeString:self.icon],
                        [NSString safeString:self.score],
                        [NSString safeString:self.cid],
                        [NSString stringWithFormat:@"%d", self.type],
                        [NSString stringWithFormat:@"%d", self.at],
                        [NSString safeString:self.releaseDate],
                        [NSString safeString:self.directory],
                        [NSString safeString:self.starring],
                        [NSString safeString:self.desc],
                        [NSString safeString:self.area],
                        [NSString safeString:self.subCategory],
                        [NSString safeString:self.playTv],
                        [NSString safeString:self.school],
                        [NSString safeString:self.pid],
                        [NSString safeString:self.vid],
                        [NSString safeString:self.vnameCn],
                        [NSString safeString:self.vmid],
                        [NSString stringWithFormat:@"%ld", (long)self.vepisode],
                        [NSString stringWithFormat:@"%ld", (long)self.vporder],
                        [NSString safeString:self.vicon],
                        [NSString safeString:self.vtype],
                        self.pay ? @"1" : @"0",
                        [NSString stringWithFormat:@"%ld", (long)self.duration],
                        [NSString stringWithFormat:@"%ld", (long)self.offset],
                        [formatter stringFromDate:self.updateTime],
                        [NSString safeString:self.deviceFrom],
                        [NSString safeString:self.videoKey],
                        [NSString safeString:self.nvid],
                        [NSString safeString:self.pic],
                        [NSString safeString:self.movie_id],
                        [NSString safeString:self.videoKey]];
        
        LTPlayHistoryCommand *historyCommand = [LTPlayHistoryCommand searchByMovieVid:self.vid];
        if (!historyCommand) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int vidCount = [self count];
                if (vidCount>10000) {
                    [self deleteCount];
                }
            });
            
            [db executeUpdate:
             @"INSERT INTO ltPlayHistoryVid ( \
             movie_ID,nameCn, subTitle, icon, score, cid, type, at, releaseDate, directory, starring, \
             desc, area, subCategory, playTv, school, pid, \
             vid, vnameCn, vmid, vepisode, vporder, vicon, vtype, \
             pay, \
             duration, offset, updateTime, deviceFrom, videoKey,nvid,pic\
             ) \
             VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
             self.movie_id,
             self.nameCn,
             self.subTitle,
             self.icon,
             self.score,
             self.cid,
             [NSString stringWithFormat:@"%d", self.type],
             [NSString stringWithFormat:@"%d", self.at],
             self.releaseDate,
             self.directory,
             self.starring,
             self.desc,
             self.area,
             self.subCategory,
             self.playTv,
             self.school,
             self.pid,
             self.vid,
             self.vnameCn,
             self.vmid,
             [NSString stringWithFormat:@"%ld", (long)self.vepisode],
             [NSString stringWithFormat:@"%ld", (long)self.vporder],
             self.vicon,
             self.vtype,
             self.pay ? @"1" : @"0",
             [NSString stringWithFormat:@"%ld", (long)self.duration],
             [NSString stringWithFormat:@"%ld", (long)self.offset],
             [formatter stringFromDate:self.updateTime],
             self.deviceFrom,
             [NSString safeString:self.videoKey],
             [NSString safeString:self.nvid],
             [NSString safeString:self.pic]
             ];
            
        }
        
#else
        // update
        BOOL bResult = [db executeUpdate:
                        @"UPDATE ltPlayHistory set \
                        nameCn = ?, subTitle = ?, icon = ?, score = ?, cid = ?, type = ?, at = ?, releaseDate = ?, directory = ?, starring = ?, \
                        desc = ?, area = ?, subCategory = ?, playTv = ?, school = ?, pid = ?, \
                        vid = ?, vnameCn = ?, vmid = ?, vepisode = ?, vporder = ?, vicon = ?, vtype = ?, \
                        pay = ?, \
                        duration = ?, offset = ?, updateTime = ? ,deviceFrom = ?, videoKey = ?\
                        ,nvid = ?,shortFlag = ?\
                        where movie_ID = ? and videoKey = ?",
                        [NSString safeString:self.nameCn],
                        [NSString safeString:self.subTitle],
                        [NSString safeString:self.icon],
                        [NSString safeString:self.score],
                        [NSString safeString:self.cid],
                        [NSString stringWithFormat:@"%d", self.type],
                        [NSString stringWithFormat:@"%d", self.at],
                        [NSString safeString:self.releaseDate],
                        [NSString safeString:self.directory],
                        [NSString safeString:self.starring],
                        [NSString safeString:self.desc],
                        [NSString safeString:self.area],
                        [NSString safeString:self.subCategory],
                        [NSString safeString:self.playTv],
                        [NSString safeString:self.school],
                        [NSString safeString:self.pid],
                        [NSString safeString:self.vid],
                        [NSString safeString:self.vnameCn],
                        [NSString safeString:self.vmid],
                        [NSString stringWithFormat:@"%ld", (long)self.vepisode],
                        [NSString stringWithFormat:@"%ld", (long)self.vporder],
                        [NSString safeString:self.vicon],
                        [NSString safeString:self.vtype],
                        self.pay ? @"1" : @"0",
                        [NSString stringWithFormat:@"%ld", (long)self.duration],
                        [NSString stringWithFormat:@"%ld", (long)self.offset],
                        [formatter stringFromDate:self.updateTime],
                        [NSString safeString:self.deviceFrom],
                        [NSString safeString:self.videoKey],
                        [NSString safeString:self.nvid],
                        [NSString safeString:self.shortFlag],
                        [NSString safeString:self.movie_id],
                        [NSString safeString:self.videoKey]
                        ];
        
        LTPlayHistoryCommand *historyCommand = [LTPlayHistoryCommand searchByMovieVid:self.vid videoType:self.videoKey];
        if (!historyCommand) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                int vidCount = [self count];
                if (vidCount>10000) {
                    [self deleteCount];
                }
            });

            [db executeUpdate:
             @"INSERT INTO ltPlayHistoryVid ( \
             movie_ID,nameCn, subTitle, icon, score, cid, type, at, releaseDate, directory, starring, \
             desc, area, subCategory, playTv, school, pid, \
             vid, vnameCn, vmid, vepisode, vporder, vicon, vtype, \
             pay, \
             duration, offset, updateTime, deviceFrom, videoKey ,nvid,\
             shortFlag) \
             VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
             self.movie_id,
             self.nameCn,
             self.subTitle,
             self.icon,
             self.score,
             self.cid,
             [NSString stringWithFormat:@"%d", self.type],
             [NSString stringWithFormat:@"%d", self.at],
             self.releaseDate,
             self.directory,
             self.starring,
             self.desc,
             self.area,
             self.subCategory,
             self.playTv,
             self.school,
             self.pid,
             self.vid,
             self.vnameCn,
             self.vmid,
             [NSString stringWithFormat:@"%ld", (long)self.vepisode],
             [NSString stringWithFormat:@"%ld", (long)self.vporder],
             self.vicon,
             self.vtype,
             self.pay ? @"1" : @"0",
             [NSString stringWithFormat:@"%ld", (long)self.duration],
             [NSString stringWithFormat:@"%ld", (long)self.offset],
             [formatter stringFromDate:self.updateTime],
             self.deviceFrom,
             [NSString safeString:self.videoKey],
             [NSString safeString:self.nvid],
             [NSString safeString:self.shortFlag]
             ];
        }
#endif

        return bResult;
    }
}
- (void)updateWithVideo:(VideoModel *)video
            andDuration:(NSInteger)duration
              andOffset:(NSInteger)offset
          andUpdateTime:(NSDate *)updateTime
         isAbleSkipTail:(BOOL)isAbleSkipTail
{
    self.vid = video.vid;
    self.vnameCn = video.nameCn;
    self.vmid = video.mid;
    self.isAbleSkipTail = isAbleSkipTail;
    self.vepisode = [video.episode/*JEASONepisode no del!!!!*/ integerValue];
    self.vporder = [video.porder/*JEASONporder no del!!!!*/ integerValue];
    self.vicon = video.icon;
    self.vtype = video.videoType;
    self.pay = video.pay;
    self.duration = duration;
    self.offset = [self getPlayStatusByCurrentTime:video offsetTime:offset duration:duration];
    self.updateTime = updateTime;
    self.videoKey = video.videoTypeKey;
    self.nvid = video.nvid;
    self.shortFlag = (video.upgc && [video.upgc isEqualToString:@"1"]) ? @"1" : @"0";
    DeviceFromType deviceType;
    #ifdef LT_IPAD_CLIENT
    deviceType=DEVICE_FROM_PAD;
    #else
    deviceType=DEVICE_FROM_PHONE;
    #endif
    self.deviceFrom = [NSString stringWithFormat:@"%d", deviceType];
    
    if (![NSString empty:video.pid] && ![video.pid isEqualToString:@"0"]) {
        self.pid = video.pid;
        self.movie_id = video.pid;
        self.videoKey = video.videoTypeKey;
    }
    
    [self updateDB];
}

- (void)updateWithVideo:(VideoModel *)video
            andDuration:(NSInteger)duration
              andOffset:(NSInteger)offset
          andUpdateTime:(NSDate *)updateTime
{
    self.vid = video.vid;
    self.vnameCn = video.nameCn;
    self.vmid = video.mid;
    self.vepisode = [video.episode/*JEASONepisode no del!!!!*/ integerValue];
    self.vporder = [video.porder/*JEASONporder no del!!!!*/ integerValue];
    self.vicon = video.icon;
    self.vtype = video.videoType;
    self.pay = video.pay;
    self.duration = duration;
    self.offset = offset;
    self.updateTime = updateTime;
    self.videoKey = video.videoTypeKey;
    self.nvid = video.nvid;
    self.shortFlag = (video.upgc && [video.upgc isEqualToString:@"1"]) ? @"1" : @"0";
    [self updateDB];
}

- (NSInteger)getPlayStatusByCurrentTime:(VideoModel *)video offsetTime:(NSInteger)offsetTime duration:(NSInteger)duration
{
    NSInteger offset = offsetTime;
    NSInteger endTime = 0;
    if (self.isAbleSkipTail) {
            endTime = [video.etime/*JEASONetime no del!!!!*/ integerValue];
    }
    else
    {
        endTime = [video.duration/*JEASONduration(non del!!)*/ integerValue];
    }
    if (endTime == 0 && duration != 0) {
        endTime = duration;
    }
    if (offset > (endTime - 10)) {
        return -1;
    }else{
        return offset;
    }
    
}

#pragma mark -

+ (LTPlayHistoryCommand *)localPlayHistoryFromOldHistoryModel:(MovieInfo *)oldHistoryModel
{
    LTPlayHistoryCommand *localPlayHistory = [[LTPlayHistoryCommand alloc] init];
    
    // fixme, 兼容3.7及之前版本
    
    return localPlayHistory;
}

+ (LTPlayHistoryCommand *)localPlayHistoryFromDownloadInfo:(LTDownloadCommand *)downloadInfo
{
    if (nil == downloadInfo) {
        return nil;
    }
    return [LTPlayHistoryCommand localPlayHistoryFromMovieDetailModel:downloadInfo.movieDetailModel andVideoModel:downloadInfo.videoModel isFromDownload:YES downloadInfo:downloadInfo
            ];
}

+ (LTPlayHistoryCommand *)localPlayHistoryFromVideoModel:(VideoModel *)video
{
    if (nil == video) {
        return nil;
    }
    
    LTPlayHistoryCommand *localPlayHistory = [[LTPlayHistoryCommand alloc] init];
    NSString *movieId = video.pid;
    //对pid做为空判断和为0判断，后台接口不规范，可能会传递过来0
    if ([NSString isBlankString:movieId] ||
        [video.pid isEqualToString:@"0"]) {
        movieId = video.pid;
    }
    
    if ([NSString isBlankString:movieId] ||
        [video.pid isEqualToString:@"0"]) {
        movieId = video.vid;
    }
    
    localPlayHistory.movie_id = movieId;
    localPlayHistory.nameCn = video.nameCn;
//    localPlayHistory.subTitle = movieDetail.subTitle;
//    localPlayHistory.icon = movieDetail.icon;
//    localPlayHistory.score = movieDetail.score;
    localPlayHistory.cid = video.cid;
//    localPlayHistory.type = movieDetail.type;
//    localPlayHistory.at = movieDetail.at;
//    localPlayHistory.releaseDate = movieDetail.releaseDate;
//    
//    localPlayHistory.directory = movieDetail.directory;
//    localPlayHistory.starring = movieDetail.starring ;
//    localPlayHistory.desc = movieDetail.desc;
//    localPlayHistory.area = movieDetail.area ;
//    localPlayHistory.subCategory = movieDetail.subCategory ;
//    localPlayHistory.playTv = movieDetail.playTv;
//    localPlayHistory.school = movieDetail.school;
    localPlayHistory.pid = video.pid;
    
    localPlayHistory.vid = video.vid;
    localPlayHistory.vnameCn = video.nameCn;
    localPlayHistory.vmid = video.mid;
    localPlayHistory.vepisode = [video.episode/*JEASONepisode no del!!!!*/ integerValue];
    localPlayHistory.vporder = [video.porder/*JEASONporder no del!!!!*/ integerValue];
    localPlayHistory.vicon = video.icon;
    localPlayHistory.icon = video.icon;
    localPlayHistory.vtype = video.videoType;
    localPlayHistory.pay = video.pay;
    
    localPlayHistory.videoKey = video.videoTypeKey;
    
    
    // ID
    // duration
    // offset
    // updateTime
    
    return localPlayHistory;
}

+ (LTPlayHistoryCommand *)localPlayHistoryFromMovieDetailModel:(MovieDetailModel *)movieDetail
                                                 andVideoModel:(VideoModel *)video
{
    return [self localPlayHistoryFromMovieDetailModel:movieDetail andVideoModel:video isFromDownload:NO downloadInfo:nil];
}
+ (LTPlayHistoryCommand *)localPlayHistoryFromMovieDetailModel:(MovieDetailModel *)movieDetail andVideoModel:(VideoModel *)video isFromDownload:(BOOL)isFromDownload downloadInfo:(LTDownloadCommand *)downloadInfo
{
    if (    nil == movieDetail
        ||  nil == video) {
        return nil;
    }
    
    LTPlayHistoryCommand *localPlayHistory = [[LTPlayHistoryCommand alloc] init];
    NSString *movieId = movieDetail.pid;
    //对pid做为空判断和为0判断，后台接口不规范，可能会传递过来0
    if ([NSString isBlankString:movieId] ||
        [video.pid isEqualToString:@"0"]) {
        movieId = video.pid;
    }
    
    if ([NSString isBlankString:movieId] ||
        [video.pid isEqualToString:@"0"]) {
        movieId = video.vid;
    }
    
    localPlayHistory.movie_id = movieId;
    localPlayHistory.nameCn = movieDetail.nameCn;
    localPlayHistory.subTitle = movieDetail.subTitle;
    
    // 615增加-播放缓存视频记录播放记录时取不到图片
    if(isFromDownload) {
        localPlayHistory.icon = downloadInfo.subIcon;
    } else {
        if ([movieDetail respondsToSelector:@selector(getDownloadIcon)]) {
            localPlayHistory.icon = [movieDetail getDownloadIcon];
        } else {
            localPlayHistory.icon = @"";
        }
    }

    
    localPlayHistory.score = movieDetail.score;
    localPlayHistory.cid = movieDetail.cid;
    localPlayHistory.type = movieDetail.type;
    localPlayHistory.at = movieDetail.at;
    localPlayHistory.releaseDate = movieDetail.releaseDate;
    
    localPlayHistory.directory = movieDetail.directory;
    localPlayHistory.starring = movieDetail.starring ;
    localPlayHistory.desc = movieDetail.desc;
    localPlayHistory.area = movieDetail.area ;
    localPlayHistory.subCategory = movieDetail.subCategory ;
    localPlayHistory.playTv = movieDetail.playTv;
    localPlayHistory.school = movieDetail.school;
    localPlayHistory.pid = movieDetail.pid;
    
    localPlayHistory.vid = video.vid;
    localPlayHistory.vnameCn = video.nameCn;
    localPlayHistory.vmid = video.mid;
    localPlayHistory.vepisode = [video.episode/*JEASONepisode no del!!!!*/ integerValue];
    localPlayHistory.vporder = [video.porder/*JEASONporder no del!!!!*/ integerValue];
    localPlayHistory.vicon = video.icon;
    localPlayHistory.vtype = video.videoType;
    localPlayHistory.pay = video.pay;
    
    localPlayHistory.videoKey = video.videoTypeKey;
    localPlayHistory.shortFlag = (video.upgc && [video.upgc isEqualToString:@"1"]) ? @"1" : @"0";
    
    
    // ID
    // duration
    // offset
    // updateTime
    
    return localPlayHistory;
}

+ (LTPlayHistoryCommand *)localPlayHistoryFromCloudRecordItem:(LTCloudRecordItemModel *)cloudRecordItem
{
    LTPlayHistoryCommand *localPlayHistory = [[LTPlayHistoryCommand alloc] init];

    localPlayHistory.movie_id = cloudRecordItem.pid;
    localPlayHistory.nameCn = cloudRecordItem.title;
    localPlayHistory.subTitle = @"";

    //优先选择400*250
    if (![NSString empty:cloudRecordItem.picAll.img_400_250]) {
        localPlayHistory.icon = cloudRecordItem.picAll.img_400_250;
    }else {
        localPlayHistory.icon = cloudRecordItem.img;
    }
    
    localPlayHistory.score = @"";
    localPlayHistory.cid = cloudRecordItem.cid;
    localPlayHistory.type = ([cloudRecordItem.pid isEqualToString:cloudRecordItem.vid] ? ALBUM_FROM_VRS : VIDEO_FROM_VRS);
    localPlayHistory.at = LT_VIDEO_AT_PLAY;
    localPlayHistory.releaseDate = @"";
    localPlayHistory.directory = @"";
    localPlayHistory.starring = @"";
    localPlayHistory.desc = @"";
    localPlayHistory.area = @"";
    localPlayHistory.subCategory = @"";
    localPlayHistory.playTv = @"";
    localPlayHistory.school = @"";
    localPlayHistory.pid = cloudRecordItem.pid;
    
    localPlayHistory.vid = cloudRecordItem.vid;
    localPlayHistory.vnameCn = cloudRecordItem.title;
    localPlayHistory.vmid = @"";
    localPlayHistory.vepisode = [cloudRecordItem.nc integerValue];
    localPlayHistory.vporder = [cloudRecordItem.nc integerValue];
    localPlayHistory.vicon = cloudRecordItem.img;
    localPlayHistory.vtype = @"";
    localPlayHistory.pic = cloudRecordItem.picAll.img_400_225;
    
    localPlayHistory.pay = NO;
    
    localPlayHistory.duration = [cloudRecordItem.vtime integerValue];
    localPlayHistory.offset = [cloudRecordItem.htime integerValue];
    localPlayHistory.updateTime = [NSDate dateWithTimeIntervalSince1970:[cloudRecordItem.utime integerValue]];
    
    //5.5 增加播放记录设备
    localPlayHistory.deviceFrom  =  cloudRecordItem.from;
    
    // ZhangQigang: 5.8.2 增加视频类型: 正片, 非正片
    localPlayHistory.videoKey = cloudRecordItem.videoType;
    
    // wangtonglong 5.9  添加下一集视频vid
    localPlayHistory.nvid = cloudRecordItem.nvid;
    // JiangHongguang 6.15增加是否为短视频标记
    NSString *shortFlag = (cloudRecordItem.upgc && [cloudRecordItem.upgc isEqualToString:@"1"]) ? @"1" : @"0";
    localPlayHistory.shortFlag = shortFlag;
    return localPlayHistory;
}

+ (LTPlayHistoryCommand *)searchFirstRecord {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
    rs  = [db executeQuery:@"SELECT * FROM ltPlayHistory Order By updateTime Desc limit 0,1"];
    
	LTPlayHistoryCommand *history = nil;
	while ([rs next])
	{
        history = [self wrappResultSet:rs];
	}
	[rs close];
    
    return history;
}

+ (NSArray *)searchSpecialNumberRecord:(NSInteger)number {
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
    
    if (number <= 0) {
        return nil;
    }
	
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ltPlayHistory Order By updateTime Desc limit 0, %ld", (long)number];
    
    rs  = [db executeQuery:sql];
    
    NSMutableArray *historyArray = [NSMutableArray arrayWithCapacity:10];
	LTPlayHistoryCommand *history = nil;
	while ([rs next])
	{
        history = [self wrappResultSet:rs];
        
        if (history != nil) {
            [historyArray addObject:history];
        }
	}
    
	[rs close];
    
    return historyArray;
}

//国际公寓 邮政速递  甜水园北里12号

+ (NSArray *)searchFrom:(NSInteger)from count:(NSInteger)count
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ltPlayHistory Order By updateTime Desc limit %ld, %ld", (long)from,(long)count];
    rs  = [db executeQuery:sql];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    
    return dbArray;
}

+ (NSArray *)searchAll
{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
    rs  = [db executeQuery:@"SELECT * FROM ltPlayHistory Order By updateTime Desc"];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		[dbArray addObject:[self wrappResultSet:rs]];
	}
	[rs close];
    
	return dbArray;
}
+ (NSArray *)searchAllShortVideoRecord
{
    return [self searchAllRecordWithShortFlag:@"1"];
}
+ (NSArray *)searchAllNormalVideoRecord
{
    return [self searchAllRecordWithShortFlag:@"0"];
}
+ (NSArray *)searchAllRecordWithShortFlag:(NSString *)shortFlag
{
   	PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs  = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE ShortFlag = ?  Order By updateTime Desc",shortFlag];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    while ([rs next])
    {
        [dbArray addObject:[self wrappResultSet:rs]];
    }
    [rs close];
    
    return dbArray; 
}

+ (NSInteger)countOfHistory
{
    NSInteger count = 0;
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
    rs  = [db executeQuery:@"SELECT COUNT(*) AS count FROM ltPlayHistory"];
    
	if([rs next])
	{
		count = [[rs objectForColumn:@"count"] intValue];
	}
	[rs close];
    
	return count;
}

+ (NSArray *)searchByRecentCount:(NSInteger)count
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
    rs  = [db executeQuery:
           @"SELECT * FROM ltPlayHistory Order By updateTime Desc limit ?",
           [NSString stringWithFormat:@"%ld", (long)count]];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		[dbArray addObject:[self wrappResultSet:rs]];
	}
	[rs close];
    
	return dbArray;
}

+ (LTPlayHistoryCommand *)searchByID:(NSString *)ID
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE ID = ? limit 1", ID];
    
    LTPlayHistoryCommand *playHistory = nil;
	while ([rs next]) {
		playHistory = [self wrappResultSet:rs];
	}
	[rs close];
    
	return playHistory;
}

+ (LTPlayHistoryCommand *)searchByID:(NSString *)ID videoType:(NSString *)videoType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE ID = ? and videoKey = ? limit 1", ID,videoType];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
    }
    [rs close];
    
    return playHistory;
}

+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID videoType:(NSString *)videoType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE movie_ID = ? and videoKey = ?  limit 1", movieID, [NSString safeString:videoType]];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
    }
    [rs close];
    
    return playHistory;
}


+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE movie_ID = ? limit 1", movieID];
    
    LTPlayHistoryCommand *playHistory = nil;
	while ([rs next]) {
		playHistory = [self wrappResultSet:rs];
	}
	[rs close];
    
	return playHistory;
}

+ (NSArray *)searchAllPlayHistoryByMovieID:(NSString *)movieID {
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE movie_ID = ?", movieID];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
        
        if (playHistory != nil) {
            [dataArray addObject:playHistory];
        }
    }
    [rs close];
    
    return dataArray;
}

+ (LTPlayHistoryCommand *)searchAllPlayHistoryByVID:(NSString *)vID {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE vid = ?", vID];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
    }
    [rs close];
    
    return playHistory;
}

+ (LTPlayHistoryCommand *)searchByMovieVid:(NSString *)vid videoType:(NSString *)videoType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistoryVid WHERE vid = ? and videoKey = ? limit 1", vid,[NSString safeString:videoType]];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
    }
    [rs close];
    
    return playHistory;
}

+ (LTPlayHistoryCommand *)searchByMovieVid:(NSString *)vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistoryVid WHERE vid = ? limit 1", vid];
    
    LTPlayHistoryCommand *playHistory = nil;
    while ([rs next]) {
        playHistory = [self wrappResultSet:rs];
    }
    [rs close];
    
    return playHistory;
}

+ (LTPlayHistoryCommand *)searchByMovieID:(NSString *)movieID andVid:(NSString *)vid
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM ltPlayHistory WHERE movie_ID = ? And vid = ? limit 1", movieID,vid];
    
    LTPlayHistoryCommand *playHistory = nil;
	while ([rs next]) {
		playHistory = [self wrappResultSet:rs];
	}
	[rs close];
    
	return playHistory;
}


- (int) count{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    int count = 0;
    
    id<PLResultSet> rs;
    rs = [db executeQuery:@"select count(*) as count from ltPlayHistoryVid"];
    
    if([rs next])
    {
        count = [[rs objectForColumn:@"count"] intValue];
    }
    
    [rs close];
    return count;
}

+ (BOOL)deleteByMovieID:(NSString *)movieID
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate:@"DELETE FROM ltPlayHistory WHERE movie_ID = ?", movieID];
    return bResult;
}

- (BOOL)deleteCount
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"delete from ltPlayHistoryVid where ID in (select id from ltPlayHistoryVid order by id limit 100)"];
    return bResult;
}

+ (BOOL)deleteByID:(NSInteger)ID
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    @try {
        NSString *string = [NSString stringWithFormat:@"%ld",(long)ID];
        LTPlayHistoryCommand *playHistoryCommand = [LTPlayHistoryCommand searchByID:string];
        [db executeUpdate:@"DELETE FROM ltPlayHistoryVid WHERE movie_id = ?",playHistoryCommand.movie_id];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
   
	BOOL bResult = [db executeUpdate:
                    @"DELETE FROM ltPlayHistory WHERE ID = ?",
                    [NSString stringWithFormat:@"%ld", (long)ID]];
    

    return bResult;
}

+ (BOOL)deleteByID:(NSInteger)ID videoType:(NSString *)videoType
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    @try {
        NSString *string = [NSString stringWithFormat:@"%ld",(long)ID];
        LTPlayHistoryCommand *playHistoryCommand = [LTPlayHistoryCommand searchByID:string videoType:videoType];
        [db executeUpdate:@"DELETE FROM ltPlayHistoryVid WHERE movie_id = ?and videoKey = ? ",playHistoryCommand.movie_id,playHistoryCommand.videoKey];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    BOOL bResult = [db executeUpdate:
                    @"DELETE FROM ltPlayHistory WHERE ID = ?",
                    [NSString stringWithFormat:@"%ld", (long)ID]];
    
    
    return bResult;
}

+ (BOOL)clean
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"DELETE FROM ltPlayHistory"];
    if (bResult) {
        [db executeUpdate:@"DELETE FROM ltPlayHistoryVid"];
    }

    return bResult;
}
// 清空本地所有普通视频的播放记录
+ (BOOL)cleanAllNormal
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"DELETE FROM ltPlayHistory WHERE shortFlag != '1'"];
    if (bResult) {
        [db executeUpdate:@"DELETE FROM ltPlayHistoryVid WHERE shortFlag != '1'"];
    }
    return bResult;
}
// 清空本地所有短视频播放记录
+ (BOOL)cleanAllShort
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"DELETE FROM ltPlayHistory WHERE shortFlag = '1' "];
    if (bResult) {
        [db executeUpdate:@"DELETE FROM ltPlayHistoryVid WHERE shortFlag = '1' "];
    }
    
    return bResult;
}
+ (BOOL)deleteFromDB:(NSMutableArray *)arrays
{
    if (arrays == nil || [arrays count] <= 0) {
        return NO;
    }
    for (int i = 0; i < [arrays count]; i++) {
        
    }
    return YES;
}
#pragma mark - cloud
+ (void)submitToCloudWithMovieID:(NSString *)movieID
                  WithDeleteFlag:(BOOL)isNeedDeleteLocal
{
    
    if (    ![NetworkReachability connectedToNetwork]
        ||  [NSString isBlankString:movieID]
        ||  ![SettingManager isUserLogin]) {
        return;
    }

    NSString *longitude = [SettingManager getLocaionLongitude];
    NSString *latitude = [SettingManager getLocationLatitude];
    
    LTPlayHistoryCommand *playHistory = [LTPlayHistoryCommand searchByMovieID:movieID];
    if (nil == playHistory) {
        return;
    }
    
    DeviceFromType deviceType;
#ifdef LT_IPAD_CLIENT
    deviceType=DEVICE_FROM_PAD;
#else
    deviceType=DEVICE_FROM_PHONE;
#endif
    NSArray *arrayParamValues = [NSArray arrayWithObjects:
                                 playHistory.cid,
                                 playHistory.movie_id,
                                 playHistory.vid,
                                 [NSString safeString:playHistory.nvid],
                                 [SettingManager alreadyLoginUserID],
                                 [NSString stringWithFormat:@"%d", deviceType],
                                 [NSString stringWithFormat:@"%ld", (long)playHistory.offset],
                                 [SettingManager userCenterTVToken],
                                 longitude,
                                 latitude,
                                 [NSString safeString:playHistory.shortFlag],
                                 nil];
    [LTDataModelEngine cancelAllHttpOperationWithUrlModule:LTURLModule_Cloud_SubmitSingle];
    //TODO: ZhangQigang 增加 videoType 字段 -- 服务器知道 video 的类型, 不需要上传.
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_SubmitSingle
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  
                                  if (isNeedDeleteLocal) {
                                      [LTPlayHistoryCommand deleteByMovieID:movieID];
                                  }
                                  //  提交的短视频则发刷新短视频通知否则发刷普通视频的通知
                                  NSString *notiName = [playHistory.shortFlag isEqualToString:@"1"] ? LTRefreshCloudShortRecordNotification :
                                  LTRefreshCloudRecordNotification;
                                  [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
                                  
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                      }
                                  }
                                  if ([status integerValue] ==DataStatusTokenExpired) {
//                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showToast"
//                                                                                          object:NSLocalizedString(@"请重新登录", @"请重新登录")];
                                      
                                      LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                      statisInfo.acode = LTDCActionCodeShow;
                                      statisInfo.st =  @"0";
                                      statisInfo.pageID = LTDCPageIDUnKnown;
                                      statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                      [LTDataCenter addStatistic:statisInfo];
                                      [SettingManager resetUserInfo];
                                      
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_SubmitSingle
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_SubmitSingle,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }else{
                                      playHistory.deviceFrom = [NSString stringWithFormat:@"%d",deviceType];
                                      [playHistory updateDB];
                                  }
                                  
                              } errorHandler:^(NSError *error) {
                                  //
                              }];
    
    return;
}

+ (void)submitToCloudWithMovieID:(NSString *)movieID
                       videoType:(NSString *)videoType
                  WithDeleteFlag:(BOOL)isNeedDeleteLocal
{
    if (    ![NetworkReachability connectedToNetwork]
        ||  [NSString isBlankString:movieID]
        ||  ![SettingManager isUserLogin]) {
        return;
    }

    NSString *longitude = [SettingManager getLocaionLongitude];
    NSString *latitude = [SettingManager getLocationLatitude];
    
    LTPlayHistoryCommand *playHistory = [LTPlayHistoryCommand searchByMovieID:movieID videoType:videoType];
    if (nil == playHistory) {
        return;
    }
    
    DeviceFromType deviceType;
#ifdef LT_IPAD_CLIENT
    deviceType=DEVICE_FROM_PAD;
#else
    deviceType=DEVICE_FROM_PHONE;
#endif
    
    NSArray *arrayParamValues = [NSArray arrayWithObjects:
                                 playHistory.cid,
                                 playHistory.movie_id,
                                 playHistory.vid,
                                 [NSString safeString:playHistory.nvid],
                                 [SettingManager alreadyLoginUserID],
                                 [NSString stringWithFormat:@"%d", deviceType],
                                 [NSString stringWithFormat:@"%ld", (long)playHistory.offset],
                                 [SettingManager userCenterTVToken],
                                 longitude,
                                 latitude,
                                 [NSString safeString:playHistory.shortFlag],
                                 nil];
    [LTDataModelEngine cancelAllHttpOperationWithUrlModule:LTURLModule_Cloud_SubmitSingle];
    //TODO: ZhangQigang 增加 videoType 字段 -- 服务器知道 video 的类型, 不需要上传.
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_SubmitSingle
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  
                                  if (isNeedDeleteLocal) {
                                      [LTPlayHistoryCommand deleteByMovieID:movieID];
                                  }
                                  
                                  NSString *notiName = [playHistory.shortFlag isEqualToString:@"1"] ? LTRefreshCloudShortRecordNotification :
                                  LTRefreshCloudRecordNotification;
                                  [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
                                  
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                      }
                                  }
                                  if ([status integerValue] ==DataStatusTokenExpired) {
                                      //                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showToast"
                                      //                                                                                          object:NSLocalizedString(@"请重新登录", @"请重新登录")];
                                      
                                      LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                      statisInfo.acode = LTDCActionCodeShow;
                                      statisInfo.st =  @"0";
                                      statisInfo.pageID = LTDCPageIDUnKnown;
                                      statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                      [LTDataCenter addStatistic:statisInfo];
                                      [SettingManager resetUserInfo];
                                      
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_SubmitSingle
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_SubmitSingle,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }else{
                                      playHistory.deviceFrom = [NSString stringWithFormat:@"%d",deviceType];
                                      [playHistory updateDB];
                                  }
                                  
                              } errorHandler:^(NSError *error) {
                                  //
                              }];
    
    return;
}


+ (void)submitToCloudByRecentWithFinishBlock:(void (^)())finishBlock
{
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    
    NSMutableArray *dataArray=[NSMutableArray arrayWithCapacity:LT_SUBMITTOCLOUD_BATCHNUM];
    
    NSMutableArray *historyArray = (NSMutableArray *)[LTPlayHistoryCommand searchByRecentCount:LT_SUBMITTOCLOUD_BATCHNUM];
    if (!historyArray ||
        historyArray.count <= 0) {
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    
    for(LTPlayHistoryCommand *playHistory in historyArray){
        
        NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithCapacity:100];
        //TODO: ZhangQigang 增加 videoType 字段的上传 -- 服务器知道 video 的类型, 不需要上传.
        [jsonDict setObject:[SettingManager alreadyLoginUserID] forKey:@"uid"];
        [jsonDict setObject:[NSString safeString:playHistory.vid] forKey:@"vid"];
        [jsonDict setObject:[NSString safeString:playHistory.cid] forKey:@"cid"];
        [jsonDict setObject:[NSString safeString:playHistory.movie_id] forKey:@"pid"];
        [jsonDict setObject:[NSString safeString:playHistory.nvid] forKey:@"nvid"];
        [jsonDict setObject:[NSString safeString:playHistory.vtype] forKey:@"vtype"];
        [jsonDict setObject:[NSString stringWithFormat:@"%ld",(long)playHistory.offset] forKey:@"htime"];
#ifdef LT_IPAD_CLIENT
        [jsonDict setObject:[NSString stringWithFormat:@"%d",DEVICE_FROM_PAD] forKey:@"from"];
#else
        [jsonDict setObject:playHistory.deviceFrom forKey:@"from"];
#endif
        // 6.15增加短视频标记字段
        [jsonDict setObject:[NSString safeString:playHistory.shortFlag] forKey:@"upgc"];
        
        if (nil != playHistory.updateTime) {
            NSTimeInterval timeInterval = [playHistory.updateTime timeIntervalSince1970];
            [jsonDict setObject:[NSString stringWithFormat:@"%.f",timeInterval] forKey:@"utime"];
        } else {
            [jsonDict setObject:@"" forKey:@"utime"];
        }
        [dataArray addObject:jsonDict];
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataArray options:kNilOptions error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    [params setObject:[SettingManager alreadyLoginUserID] forKey:@"uid"];
    [params setObject:[SettingManager userCenterTVToken] forKey:@"sso_tk"];
    [params setObject:jsonString forKey:@"data"];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_SubmitMore
                               andDynamicValues:nil
                                  andHttpMethod:@"POST"
                                  andParameters:params
                              completionHandler:^(NSDictionary *responseDic) {
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=[responseDic valueForKey:@"header"];
                                      if (![NSObject empty:header]) {
                                          NSString *status= [header valueForKey:@"status"];
                                          if ([status isEqualToString:@"1"]) {
                                              // 批量上传播放记录成功后，立即删除本地播放记录
                                              
                                              // 批量操作放到一个事务中
                                              PLSqliteDatabase *db = [SqlDBHelper setUp];
                                              [db beginTransaction];

                                              for(LTPlayHistoryCommand *playHistory in historyArray){
                                                  [LTPlayHistoryCommand deleteByMovieID:playHistory.movie_id];
                                              }
                                              
                                              [db commitTransaction];
                                              
                                              // 接着上传
                                              NSInteger countOfHistory = [LTPlayHistoryCommand countOfHistory];
                                              if (countOfHistory > 0) {
                                                  [LTPlayHistoryCommand submitToCloudByRecentWithFinishBlock:finishBlock];
                                              } else {
                                                  if (finishBlock) {
                                                      finishBlock();
                                                  }
                                              }
                                          }else  if ([status integerValue] == DataStatusTokenExpired) {
                                              //token 过期处理
//                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"showToast"
//                                                                                                  object:NSLocalizedString(@"请重新登录", @"请重新登录")];
                                             
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                              [SettingManager resetUserInfo];
                                              if (finishBlock) {
                                                  finishBlock();
                                              }
                                          }
                                          
                                          if ([status integerValue] != DataStatusNormal) {
                                              NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_SubmitMore
                                                                                           andDynamicValues:nil];
                                              
                                              NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_SubmitMore,url,[responseDic description]];
                                              [LTDataCenter writeToErrorLogFile:errlog];
                                              
                                          }

                                      }
                                      
                                  }
                                  
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              }];
    return;
}

+ (void)deleteFromCloud:(NSMutableArray *)delArray{
    
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        return;
    }
    NSString *pid = @"";
    NSString *vid = @"";
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *flush = @"0";
    NSMutableString *idStr=[NSMutableString stringWithCapacity:300];
    for(int i = 0; i < [delArray count]; i++){
        
        LTCloudRecordItemModel *playHistory = nil;
        LTPlayHistoryCommand *localPlayHistory = nil;
        id cloundLocalItem = delArray[i];
        if ([cloundLocalItem isKindOfClass:[LTCloudRecordItemModel class]]){
            playHistory = (LTCloudRecordItemModel *)cloundLocalItem;
        }
        else if ([cloundLocalItem isKindOfClass:[LTPlayHistoryCommand class]]){
            localPlayHistory = (LTPlayHistoryCommand *)cloundLocalItem;
            playHistory = [LTCloudRecordItemModel createFromLocalPlayHistory:localPlayHistory];
        }
        NSString *vid = [NSString stringWithFormat:@"vid:%@", playHistory.vid];
        NSString *pid = [NSString stringWithFormat:@"pid:%@", playHistory.pid];
        if (i == [delArray count]-1) {
            [idStr appendFormat:@"%@,%@",vid,pid];
            
        }else{
            [idStr appendFormat:@"%@,%@,",vid,pid];
            
        }
    }
    
    NSString *myIdStr=[NSString stringWithFormat:@"(%@)",idStr];
    NSString *backdata=[NSString stringWithFormat:@"%lu",(unsigned long)[delArray count]];
    
    NSArray *arrayParamValues = @[pid,
                                  vid,
                                  uid,
                                  flush,
                                  myIdStr,
                                  backdata,
                                  [SettingManager userCenterTVToken]];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_Delete
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                      }
                                  }
                                  
                                  if ([status integerValue] ==DataStatusTokenExpired) {
//                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"showToast"
                                      //                                                                                          object:NSLocalizedString(@"请重新登录", @"请重新登录")];
                                      
                                      LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                      statisInfo.acode = LTDCActionCodeShow;
                                      statisInfo.st =  @"0";
                                      statisInfo.pageID = LTDCPageIDUnKnown;
                                      statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                      [LTDataCenter addStatistic:statisInfo];
                                      [SettingManager resetUserInfo];
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_Delete
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_Delete,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }

#ifdef LT_IPAD_CLIENT
                                  if ([status integerValue] == DataStatusNormal) {
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTDelCloudRecordNotification object:@"1"];
                                  }
#else
                                  [[NSNotificationCenter defaultCenter] postNotificationName:LTDelCloudRecordNotification object:status];
#endif
                                  
                              } errorHandler:^(NSError *error) {
                              }];
    
}

+ (void)deleteFromCloud:(NSMutableArray *)delArray
           isShortVideo:(BOOL)isShortVideo
                  block:(void (^)(BOOL isSuccess))finishBlock fail:(void (^)())failBlock;
{
    
    if (![NetworkReachability connectedToNetwork] ||
        ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock(YES);
        }
        return;
    }
    NSString *vid = @"";
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *flush = @"0";
    NSMutableString *idStr = [NSMutableString stringWithCapacity:300];
    // “,“连接所有的id
    for(int i = 0; i < [delArray count]; i++) {
        LTCloudRecordItemModel *playHistory = nil;
        LTPlayHistoryCommand *localPlayHistory = nil;
        id cloundLocalItem = delArray[i];
        if ([cloundLocalItem isKindOfClass:[LTCloudRecordItemModel class]]){
            playHistory = (LTCloudRecordItemModel *)cloundLocalItem;
        } else if ([cloundLocalItem isKindOfClass:[LTPlayHistoryCommand class]]){
            localPlayHistory = (LTPlayHistoryCommand *)cloundLocalItem;
            playHistory = [LTCloudRecordItemModel createFromLocalPlayHistory:localPlayHistory];
        }
        NSString *vid = [NSString stringWithFormat:@"vid:%@", playHistory.vid];
        if (i == [delArray count] - 1) {
            [idStr appendFormat:@"%@",vid];
        } else {
            [idStr appendFormat:@"%@,",vid];
            
        }
    }
    
    NSString *myIdStr=[NSString stringWithFormat:@"(%@)",idStr];
    NSString *backdata=[NSString stringWithFormat:@"%lu",(unsigned long)[delArray count]];
    NSString *isShort= isShortVideo ? @"1" : @"0";// 是否为短视频
    NSArray *arrayParamValues = @[
                                  vid,
                                  uid,
                                  flush,
                                  myIdStr,
                                  backdata,
                                  [SettingManager userCenterTVToken],
                                  isShort
                                  ];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_Delete
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                      }
                                  }
                                  
                                  if ([status integerValue] ==DataStatusTokenExpired) {
                                      LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                      statisInfo.acode = LTDCActionCodeShow;
                                      statisInfo.st =  @"0";
                                      statisInfo.pageID = LTDCPageIDUnKnown;
                                      statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                      [LTDataCenter addStatistic:statisInfo];
                                      [SettingManager resetUserInfo];
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_Delete
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_Delete,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }
                                  BOOL isSuccess = [status isEqualToString:@"1"];
                                  if (finishBlock) {
                                      finishBlock(isSuccess);
                                  }
                                  NSString *notifiName = isShortVideo ? LTDelCloudShortRecordNotification:LTDelCloudRecordNotification;

#ifdef LT_IPAD_CLIENT
                                  if ([status integerValue] == DataStatusNormal) {
                                      [[NSNotificationCenter defaultCenter] postNotificationName:notifiName object:@"1"];
                                     
                                  }
                                #else
                                  [[NSNotificationCenter defaultCenter] postNotificationName:notifiName object:status];
#endif
                              } errorHandler:^(NSError *error) {
                                  if (failBlock) {
                                      failBlock();
                                  }
                              }];
    
    
}

+ (void)deleteFromCloudWithPid:(NSString *)pid andVid:(NSString *)vid
{
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]
       ||   ([NSString isBlankString:pid] && [NSString isBlankString:vid])){
        return;
    }
    
    if ([NSString isBlankString:pid]) {
        pid = @"";
    }
    if ([NSString isBlankString:vid]) {
        vid = @"";
    }
#ifdef LT_IPAD_CLIENT
    NSArray *arrayParamValues = @[
#else
    NSArray *arrayParamValues = @[pid,
#endif
                                  vid,
                                  [SettingManager alreadyLoginUserID],
                                  @"0",
                                  @"",
                                  @"1",
                                  [SettingManager userCenterTVToken]];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_Delete
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                      }
                                  }
                                  
                                  if ([status integerValue] ==DataStatusTokenExpired) {
                                      [SettingManager resetUserInfo];
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_Delete
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_Delete,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];
                                      
                                  }
#ifdef LT_IPAD_CLIENT
                                  if ([status integerValue] == DataStatusNormal) {
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTDelCloudRecordNotification object:@"1"];
                                  }
                                #else
                                  [[NSNotificationCenter defaultCenter] postNotificationName:LTDelCloudRecordNotification object:status];
#endif
                              } errorHandler:^(NSError *error) {
                                  
                              }];
}

+ (void)deleteFromCloudWithModel:(LTCloudRecordItemModel *)recordModel
{
    if(!recordModel){
        return;
    }
    
    [LTPlayHistoryCommand deleteFromCloudWithPid:recordModel.pid andVid:recordModel.vid];
}



+ (void)cleanFromCloud:(BOOL)isShortVideo
    finishBlock:(void (^)(BOOL isSuccess))finishBlock
    failBlock:(void (^)())failBlock
{
    
    if (![NetworkReachability connectedToNetwork] || ![SettingManager isUserLogin]){
        return;
    }
    
    NSString *flush=@"1";
    NSString *isShort = isShortVideo ? @"1" : @"0";
    NSArray *arrayParamValues = @[@"",
                                  [SettingManager alreadyLoginUserID],
                                  flush,
                                  @"",
                                  @"",
                                  [SettingManager userCenterTVToken],
                                  isShort];
    
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_Delete
                               andDynamicValues:arrayParamValues
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *responseDic) {
                                  NSString *status=@"";
                                  if (![NSObject empty:responseDic]) {
                                      NSDictionary *header=responseDic[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                          
                                      }
                                  }
                                  
                                  if ([status integerValue] ==DataStatusTokenExpired) {
                                      LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                      statisInfo.acode = LTDCActionCodeShow;
                                      statisInfo.st =  @"0";
                                      statisInfo.pageID = LTDCPageIDUnKnown;
                                      statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                      [LTDataCenter addStatistic:statisInfo];
                                      [SettingManager resetUserInfo];
                                     
                                  }
                                  if ([status integerValue] != DataStatusNormal) {
                                      NSString *url = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Cloud_Delete
                                                                                   andDynamicValues:arrayParamValues];
                                      
                                      NSString *errlog =[NSString stringWithFormat:@"urlModule:%d url:%@ errorDict:%@",LTURLModule_Cloud_Delete,url,[responseDic description]];
                                      [LTDataCenter writeToErrorLogFile:errlog];

                                  }
                                 
#ifdef LT_IPAD_CLIENT
                                  if ([status integerValue] == DataStatusNormal) {
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTDelCloudRecordNotification object:@"2"];
                                  }
#else
                                  [[NSNotificationCenter defaultCenter] postNotificationName:LTCleanCloudRecordNotification object:status];
#endif
                                  BOOL isSuccess = [status isEqualToString:@"1"];
                                  if (finishBlock) {
                                      finishBlock(isSuccess);
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (failBlock) {
                                      failBlock();
                                  }
                              }];
    return;
}
    
// 老接口获取云端数据(新接口返回数据结构有变带回了短视频数据)
+ (void)updateDBWithCloudUseOldInterfaceWithFinishBlock:(void (^)())finishBlock
{
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *token = [SettingManager userCenterTVToken];
    if (    [NSString isBlankString:uid]
        ||  [NSString isBlankString:token]) {
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_GetAll
                               andDynamicValues:@[uid,@"",token]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  LTCloudRecordModel *cloudRecordData = [[LTCloudRecordModel alloc] initWithDictionary:bodyDict error:nil];
                                  
                                  NSString  *status = @"";
                                  if (![NSObject empty:bodyDict]) {
                                      NSDictionary *header=bodyDict[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                          if ([status integerValue] ==DataStatusTokenExpired) {
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                          }
                                      }
                                  }
                                  
                                  
                                  
                                  if (nil != cloudRecordData) {
                                      
                                      // 批量操作放到同一个事务中
                                      PLSqliteDatabase *db = [SqlDBHelper setUp];
                                      [db beginTransaction];
                                      
                                      for (LTCloudRecordItemModel *cloudItem in cloudRecordData.items) {
                                          LTPlayHistoryCommand *localPlayHistory = [LTPlayHistoryCommand localPlayHistoryFromCloudRecordItem:cloudItem];
                                          [localPlayHistory updateDB];
                                      }
                                      [db commitTransaction];
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshLocalRecordNotification object:nil];
                                  }
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } nochangeHandler:^{
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } emptyHandler:^{
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } tokenExpiredHander:^{
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              }];
    return;
}
+ (void)updateDBWithCloudWithFinishBlock:(void (^)())finishBlock
{
#ifdef LT_IPAD_CLIENT
    // iPad端使用老接口没有短视频业务
    [self updateDBWithCloudUseOldInterfaceWithFinishBlock:finishBlock];
#else
    // 同步云端记录到本地(新接口包含了短视频)
    [self getFromCloundWithPage:1 recordType:LePlayRecordAll isDeleteOld:NO finishBlock:^(BOOL isSuccess, NSInteger total) {
        if (finishBlock) {
            finishBlock();
        }
    }];
#endif

}
#pragma - mark - 分页加载iphone
// 分页加载播放记录
+ (void)getFromCloundWithPage:(NSInteger)page recordType:(LePlayRecordType)dataType
        finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock
{
    [self getFromCloundWithPage:page recordType:dataType isDeleteOld:YES finishBlock:finishBlock];
}
    
#pragma - mark - 获取指定条数播放记录
// 获取指定条数播放记录--第一页
+ (void)getFromCloundWithItemCount:(NSInteger)pageCount recordType:(LePlayRecordType)dataType finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock
{
     [self getFromCloundWithPage:1 pageSize:pageCount pagerecordType:dataType isDeleteOld:NO finishBlock:finishBlock];
}
// 从云端分页获取播放记录-每页20条 -
// isDeleteOld 为YES 删除老的 为NO 不删除老的
+ (void)getFromCloundWithPage:(NSInteger)page recordType:(LePlayRecordType)dataType
    isDeleteOld:(BOOL)isDeleteOld finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock
{
    [self getFromCloundWithPage:page pageSize:20 pagerecordType:dataType isDeleteOld:isDeleteOld finishBlock:finishBlock];
}
// 新接口根方法-有其他需求在此增加参数
+ (void)getFromCloundWithPage:(NSInteger)page pageSize:(NSInteger)pageSize pagerecordType:(LePlayRecordType)dataType isDeleteOld:(BOOL)isDeleteOld
    finishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock
{
    if( ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock(NO, 0);
        }
        return;
    }
    
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *token = [SettingManager userCenterTVToken];
    if (    [NSString isBlankString:uid]
        ||  [NSString isBlankString:token]) {
        if (finishBlock) {
            finishBlock(NO, nil);
        }
        return;
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *upgc = @"0";
    switch (dataType) {
        case LePlayRecordShort:
            upgc = @"1";
            break;
        case LePlayRecordAll:
            upgc = @"2";
            break;
        default:
            break;
    }__weak typeof(self) weakSelf = self;
    NSInteger count = (pageSize <= 0 || pageSize > 20) ? pageSize = 20 : pageSize;
    NSString *countStr = [NSString stringWithFormat:@"%ld",(long)count];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_GetAllNew
                               andDynamicValues:@[uid,pageStr,countStr,token,upgc]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  NSString  *status = @"";
                                  if (![NSObject empty:bodyDict]) {
                                      NSDictionary *header=bodyDict[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                          if ([status integerValue] ==DataStatusTokenExpired) {
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                          }
                                      }
                                  }
                                  
                                  NSInteger totalRecords = [weakSelf parseRecordDataWith:bodyDict recordType:dataType page:page isDeleteOld:isDeleteOld];
                                  if (finishBlock) {
                                      finishBlock(YES, totalRecords);
                                  }
                              } nochangeHandler:^{
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } emptyHandler:^{
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } tokenExpiredHander:^{
                                  [SettingManager resetUserInfo];
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              }];
    return;
}
+ (NSInteger)parseRecordDataWith:(NSDictionary *)bodyDict
    recordType:(LePlayRecordType)dataType
    page:(NSInteger)page
    isDeleteOld:(BOOL)isDelOld
{

    // 区分请求数据类型解析数据
    LTCloudRecordModel *cloudRecordData = nil;
    switch (dataType) {
        case LePlayRecordShort://解析短视频数据
        {
            cloudRecordData = [self parseRecordData:bodyDict key:@"hot"];
            if (isDelOld && page == 1 && cloudRecordData.items.count > 0){
                 [LTPlayHistoryCommand cleanAllShort];
            }
        }
            break;
        case LePlayRecordAll:// 解析普通和短视频数据
        {
            cloudRecordData = [self parseRecordData:bodyDict key:@"hot"];
            if (isDelOld && page == 1 && cloudRecordData.items.count > 0){
                [LTPlayHistoryCommand cleanAllShort];
            }
            [self writeCloudDataToLocal:cloudRecordData];
            cloudRecordData = [self parseRecordData:bodyDict key:@"normal"];
            if (isDelOld && page == 1 && cloudRecordData.items.count > 0){
                [LTPlayHistoryCommand cleanAllNormal];
            }
        }
            break;
        default://解析普通数据
        {
            cloudRecordData = [self parseRecordData:bodyDict key:@"normal"];
            if (isDelOld && page == 1 && cloudRecordData.items.count > 0){
                [LTPlayHistoryCommand cleanAllNormal];
            }
        }
            break;
    }
    [self writeCloudDataToLocal:cloudRecordData];
    // 当请求所有数据时只返回云端普通记录的条数
    NSInteger cloudTotal = [cloudRecordData.total integerValue];
    return cloudTotal;
}
+ (LTCloudRecordModel *)parseRecordData:(NSDictionary *)bodyDict key:(NSString *)key
{
    LTCloudRecordModel *cloudRecordData = nil;
    NSDictionary *dataDic = bodyDict[key];
    if (![NSObject empty:dataDic]){
        cloudRecordData = [[LTCloudRecordModel alloc] initWithDictionary:dataDic error:nil];
    }
    return cloudRecordData;
}
+ (void)playRecordLoadWithPage:(NSInteger)page andFinishBlock:(void (^)(BOOL isSuccess, NSInteger total))finishBlock
{
    if( ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin]){
        if (finishBlock) {
            finishBlock(NO, 0);
        }
        return;
    }
    
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *token = [SettingManager userCenterTVToken];
    if (    [NSString isBlankString:uid]
        ||  [NSString isBlankString:token]) {
        if (finishBlock) {
            finishBlock(NO, nil);
        }
        return;
    }
    NSString * pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_GetAll
                               andDynamicValues:@[uid, pageStr,token]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  LTCloudRecordModel *cloudRecordData = [[LTCloudRecordModel alloc] initWithDictionary:bodyDict error:nil];
                                  
                                  NSString  *status = @"";
                                  if (![NSObject empty:bodyDict]) {
                                      NSDictionary *header=bodyDict[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                          if ([status integerValue] ==DataStatusTokenExpired) {
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                          }
                                      }
                                  }
                                  
                                  if (page == 1 && nil != cloudRecordData && [cloudRecordData.items count] > 0) {
                                      [LTPlayHistoryCommand clean];
                                  }
                                  
                                  if (nil != cloudRecordData) {
                                      
                                      // 批量操作放到同一个事务中
                                      PLSqliteDatabase *db = [SqlDBHelper setUp];
                                      [db beginTransaction];
                                      
                                      for (LTCloudRecordItemModel *cloudItem in cloudRecordData.items) {
                                          LTPlayHistoryCommand *localPlayHistory = [LTPlayHistoryCommand localPlayHistoryFromCloudRecordItem:cloudItem];
                                          [localPlayHistory updateDB];
                                      }
                                      [db commitTransaction];
                                      
                                      [[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshLocalRecordNotification object:nil];
                                  }
                                  if (finishBlock) {
                                      NSInteger totalRecords = [cloudRecordData.total integerValue];
                                      finishBlock(YES, totalRecords);
                                  }
                              } nochangeHandler:^{
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } emptyHandler:^{
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } tokenExpiredHander:^{
                                  [SettingManager resetUserInfo];
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock(NO, 0);
                                  }
                              }];
    return;
}
+ (void)writeCloudDataToLocal:(LTCloudRecordModel *)cloudRecordData
{
    if (nil != cloudRecordData) {
        // 批量操作放到同一个事务中
        PLSqliteDatabase *db = [SqlDBHelper setUp];
        [db beginTransaction];
        for (LTCloudRecordItemModel *cloudItem in cloudRecordData.items) {
            LTPlayHistoryCommand *localPlayHistory = [LTPlayHistoryCommand localPlayHistoryFromCloudRecordItem:cloudItem];
            [localPlayHistory updateDB];
        }
        [db commitTransaction];
    }
}

#pragma mark - wrap
+ (LTPlayHistoryCommand *)wrappResultSet:(id<PLResultSet>)rs{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:LT_TIME_FORMAT_YMDHMS];
    
	LTPlayHistoryCommand *playHisotry = [[LTPlayHistoryCommand alloc] init];
    
    playHisotry.ID = [rs isNullForColumn:@"ID"] ? 0 : [[rs objectForColumn:@"ID"] intValue];
    playHisotry.movie_id = [rs isNullForColumn:@"movie_id"] ? @"" : [rs objectForColumn:@"movie_id"];
    playHisotry.nameCn = [rs isNullForColumn:@"nameCn"] ? @"" : [rs objectForColumn:@"nameCn"];
    playHisotry.subTitle = [rs isNullForColumn:@"subTitle"] ? @"" : [rs objectForColumn:@"subTitle"];
    
    playHisotry.icon = [rs isNullForColumn:@"icon"] ? @"" : [rs objectForColumn:@"icon"];
    playHisotry.score = [rs isNullForColumn:@"score"] ? @"" : [rs objectForColumn:@"score"];
    playHisotry.cid = [rs isNullForColumn:@"cid"] ? @"" : [rs objectForColumn:@"cid"];
    playHisotry.type = [rs isNullForColumn:@"type"] ? 0 : [[rs objectForColumn:@"type"] intValue];
    playHisotry.subTitle = [rs isNullForColumn:@"subTitle"] ? @"" : [rs objectForColumn:@"subTitle"];
    playHisotry.at = [rs isNullForColumn:@"at"] ? 0 : [rs intForColumn:@"at"];
    playHisotry.releaseDate = [rs isNullForColumn:@"releaseDate"] ? @"" : [rs objectForColumn:@"releaseDate"];
    playHisotry.directory = [rs isNullForColumn:@"directory"] ? @"" : [rs objectForColumn:@"directory"];
    playHisotry.starring = [rs isNullForColumn:@"starring"] ? @"" : [rs objectForColumn:@"starring"];
    playHisotry.desc = [rs isNullForColumn:@"desc"] ? @"" : [rs objectForColumn:@"desc"];
    playHisotry.area = [rs isNullForColumn:@"area"] ? @"" : [rs objectForColumn:@"area"];
    playHisotry.subCategory = [rs isNullForColumn:@"subCategory"] ? @"" : [rs objectForColumn:@"subCategory"];
    playHisotry.playTv = [rs isNullForColumn:@"playTv"] ? @"" : [rs objectForColumn:@"playTv"];
    playHisotry.school = [rs isNullForColumn:@"school"] ? @"" : [rs objectForColumn:@"school"];
    playHisotry.pid = [rs isNullForColumn:@"pid"] ? @"" : [rs objectForColumn:@"pid"];
    
    playHisotry.vid = [rs isNullForColumn:@"vid"] ? @"" : [rs objectForColumn:@"vid"];
    playHisotry.vnameCn = [rs isNullForColumn:@"vnameCn"] ? @"" : [rs objectForColumn:@"vnameCn"];
    playHisotry.vmid = [rs isNullForColumn:@"vmid"] ? @"" : [rs objectForColumn:@"vmid"];
    playHisotry.vepisode = [rs isNullForColumn:@"vepisode"] ? 0 : [rs intForColumn:@"vepisode"];
    playHisotry.vporder = [rs isNullForColumn:@"vporder"] ? 0 : [rs intForColumn:@"vporder"];
    playHisotry.vicon = [rs isNullForColumn:@"vicon"] ? @"" : [rs objectForColumn:@"vicon"];
    playHisotry.vtype = [rs isNullForColumn:@"vtype"] ? @"" : [rs objectForColumn:@"vtype"];
    
    playHisotry.pay = [rs isNullForColumn:@"pay"] ? NO : [[rs objectForColumn:@"pay"] integerValue];
    
    playHisotry.duration = [rs isNullForColumn:@"duration"] ? 0 : [rs intForColumn:@"duration"];
    playHisotry.offset = [rs isNullForColumn:@"offset"] ? 0 : [rs intForColumn:@"offset"];
    
    NSString *updateTime = [rs isNullForColumn:@"updateTime"] ? @"" : [rs objectForColumn:@"updateTime"];
    playHisotry.updateTime = [formatter dateFromString:updateTime];
    
    //5.5 增加播放记录设备
    playHisotry.deviceFrom = [rs isNullForColumn:@"deviceFrom"] ? @"":[rs objectForColumn:@"deviceFrom"];
    
    // 5.8.2 增加 videoType 字段
    playHisotry.videoKey = [rs isNullForColumn:@"videoKey"] ? @"" : [rs objectForColumn:@"videoKey"];
    
    // 5.9 增加 nvid 字段
    playHisotry.nvid = [rs isNullForColumn:@"nvid"] ? @"" : [rs objectForColumn:@"nvid"];
#ifdef LT_IPAD_CLIENT
    playHisotry.pic = [rs isNullForColumn:@"pic"] ? @"" : [rs objectForColumn:@"pic"];
#else

#endif
    // 6.15 增加 shortFlag 字段
    playHisotry.shortFlag = [rs isNullForColumn:@"shortFlag"] ? @"0" : [rs objectForColumn:@"shortFlag"];
    return playHisotry;
}

+ (void)getFromCloundWithFinishBlock:(void (^)())finishBlock
                            pageIndex:(NSInteger)pageIndex
                           pageCount:(NSInteger)pageCount
                          isReqLocal:(BOOL)isReqLocal
{
    if(     ![NetworkReachability connectedToNetwork]
       ||   ![SettingManager isUserLogin] || isReqLocal){
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    
    NSString *uid = [SettingManager alreadyLoginUserID];
    NSString *token = [SettingManager userCenterTVToken];
    if (    [NSString isBlankString:uid]
        ||  [NSString isBlankString:token]) {
        if (finishBlock) {
            finishBlock();
        }
        return;
    }
    NSString *page = [NSString stringWithFormat:@"%ld",(long)pageIndex];
    NSString *count = [NSString stringWithFormat:@"%ld",(long)pageCount];
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Cloud_GetByPage
                               andDynamicValues:@[uid,page,count, token]
                                    isNeedCache:NO
                                  andHttpMethod:@"GET"
                                  andParameters:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  LTCloudRecordModel *cloudRecordData = [[LTCloudRecordModel alloc] initWithDictionary:bodyDict error:nil];
                                  
                                  NSString  *status = @"";
                                  if (![NSObject empty:bodyDict]) {
                                      NSDictionary *header=bodyDict[@"header"];
                                      if (![NSObject empty:header]) {
                                          status= header[@"status"];
                                          if ([status integerValue] ==DataStatusTokenExpired) {
                                              LTStatisticInfo  *statisInfo = [[LTStatisticInfo alloc]init];
                                              statisInfo.acode = LTDCActionCodeShow;
                                              statisInfo.st =  @"0";
                                              statisInfo.pageID = LTDCPageIDUnKnown;
                                              statisInfo.apc = LTDCActionPropertyCategoryLoginFailed;
                                              [LTDataCenter addStatistic:statisInfo];
                                          }
                                      }
                                  }
#ifdef LT_IPAD_CLIENT
                                  
                                  if (pageIndex == 1 && nil != cloudRecordData && [cloudRecordData.items count] > 0) {
                                      [LTPlayHistoryCommand clean];
                                  }
#else

#endif               
                                  if (nil != cloudRecordData) {
                                      
                                      // 批量操作放到同一个事务中
                                      PLSqliteDatabase *db = [SqlDBHelper setUp];
                                      [db beginTransaction];
                                      
                                      for (LTCloudRecordItemModel *cloudItem in cloudRecordData.items) {
                                          LTPlayHistoryCommand *localPlayHistory = [LTPlayHistoryCommand localPlayHistoryFromCloudRecordItem:cloudItem];
                                          [localPlayHistory updateDB];
                                      }
                                      [db commitTransaction];
                                      
                                      //[[NSNotificationCenter defaultCenter] postNotificationName:LTRefreshLocalRecordNotification object:nil];
                                  }
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } nochangeHandler:^{
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } emptyHandler:^{
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } tokenExpiredHander:^{
                                  [SettingManager resetUserInfo];
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              } errorHandler:^(NSError *error) {
                                  if (finishBlock) {
                                      finishBlock();
                                  }
                              }];
    return;
}


@end
