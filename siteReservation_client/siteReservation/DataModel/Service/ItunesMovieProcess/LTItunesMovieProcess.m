//
//  LTItunesMovieProcess.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-29.
//
//

/*
 * TODO: 需要去除 Model:iTunesMovieCommand 依赖。
 */
#import "LTItunesMovieProcess.h"
#import "ItunesMovieCommand.h"
//#import "FileManager.h"
//#import "DeviceManager.h"
#import "NSString+MovieInfo.h"

static LTItunesMovieProcess *s_iTunesMovieProcess = nil;


@implementation LTItunesMovieProcess

+ (LTItunesMovieProcess*)sharedItunesMovieProcess{
    
    @synchronized(self){
        if (s_iTunesMovieProcess == nil) {
            s_iTunesMovieProcess = [[LTItunesMovieProcess alloc] init];
        }
    }
    
	return s_iTunesMovieProcess;
    
}

+ (void) destroySharedItunesMovieProcess{
    
    @synchronized(self){
        if (nil != s_iTunesMovieProcess) {
            s_iTunesMovieProcess = nil;
        }
    }
    
    return;
    
}

#pragma mark - life cycle

- (void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}

- (id) init{
    
    if (self = [super init]) {
        /*
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(mediaPlayerThumbnailImageRequestDidFinishNotification:)
                                                     name:LTMediaPlayerThumbnailImageRequestDidFinishNotification
                                                   object:nil];
         */
    }
    
    return self;
}

#pragma mark - notification
/*
- (void)mediaPlayerThumbnailImageRequestDidFinishNotification:(NSNotification*)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSLog(@"%@", userInfo);
    
    NSString *movieTitle = userInfo[@"MovieTitle"];
    if ([NSString isBlankString:movieTitle]) {
        NSLog(@"movie title empty");
        return;
    }
    
    NSString *moviePath = [[FileManager appDocumentPath] stringByAppendingPathComponent:movieTitle];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:moviePath]) {
        NSLog(@"file is not existed, %@", movieTitle);
        return;
    }
    
    [ItunesMovieCommand insertWithMovieTitle:movieTitle
                           andThumbnailTitle:userInfo[@"ThumbnailTitle"]
                             andMovieBitrate:[userInfo[@"MovieBitrate"] intValue]
                               andMovieWidth:[userInfo[@"MovieWidth"] intValue]
                              andMovieHeight:[userInfo[@"MovieHeight"] intValue]
                                 andFileSize:[FileManager getFileSizeWithPath:moviePath]
                                 andDuration:[userInfo[@"MovieDuration"] intValue]];
    
    return;
    
}
*/

#pragma mark -

- (BOOL)isSupportedByLetvLocalPlayer:(NSString *)moviePath{
    
    NSString *ext = moviePath.pathExtension.lowercaseString;
    
    if ([ext isEqualToString:@"mp3"] ||
        [ext isEqualToString:@"ogg"] ||
        [ext isEqualToString:@"wma"] ||
        [ext isEqualToString:@"m4a"] ||
        [ext isEqualToString:@"m4v"] ||
        [ext isEqualToString:@"mp4"] ||
        [ext isEqualToString:@"mov"] ||
        [ext isEqualToString:@"avi"] ||
        [ext isEqualToString:@"mkv"] ||
        [ext isEqualToString:@"mpeg"]||
        [ext isEqualToString:@"mpg"] ||
        [ext isEqualToString:@"rmvb"]||
        [ext isEqualToString:@"avi"] ||
        [ext isEqualToString:@"flv"] ||
        [ext isEqualToString:@"wmv"] ||
        [ext isEqualToString:@"rm"] ||
        [ext isEqualToString:@"vob"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isSupportedBySystemPlayer:(NSString *)moviePath{
    
    NSString *ext = moviePath.pathExtension.lowercaseString;
    
    if ([ext isEqualToString:@"mp4"] ||
        [ext isEqualToString:@"mov"] ||
        [ext isEqualToString:@"m4v"] ) {
        return YES;
    }
    
    return NO;
    
}

- (BOOL)isSupportedByCurrentDevice:(NSString *)moviePath{
    
    return YES;
    /*
    if (![self isSupportedByLetvLocalPlayer:moviePath]) {
        return NO;
    }
    
    NSString *movieTitle = [moviePath lastPathComponent];
    ItunesMovieCommand *iTunesMovieInfo = [ItunesMovieCommand searchByMovieTitle:movieTitle];
    if (nil == iTunesMovieInfo) {
        NSLog(@"movie info is not prepared");
        return YES;
    }

    UIDevicePlatform devicePlatform = [DeviceManager getDevicePlatform];
    NSLog(@"current device platform : %d", devicePlatform);
    
    int bitrate = [LTMediaPlayerController getBitrateOfMovie:moviePath];
    
    // to update db....
    if (bitrate > 0) {
        [ItunesMovieCommand updateBitrate:bitrate
                            forMovieTitle:moviePath];
    }
    else{
        bitrate = iTunesMovieInfo.movieBitrate;
    }
    
    NSLog(@"bitrate:%d height:%d", bitrate, iTunesMovieInfo.movieHeight);
    
    CGFloat bitRateForKBPS = bitrate / 1000.f;
    
    // fixme
    switch (devicePlatform) {
        case UIDevice1GiPhone:
        case UIDevice2GiPod:
        case UIDevice3GiPhone:
        case UIDevice3GSiPhone:
        case UIDevice3GiPod:
        {
            return NO;
        }
            break;
        case UIDevice4GiPod:
        {
            return (iTunesMovieInfo.movieHeight < 300) && (bitRateForKBPS < 300);
        }
            break;
        case UIDevice4iPhone:
        {
            return (iTunesMovieInfo.movieHeight < 300) && (bitRateForKBPS < 300);
        }
            break;
        case UIDevice4SiPhone:
        {
            return (iTunesMovieInfo.movieHeight <= 576) && (bitRateForKBPS <= 1024);
        }
            break;
        case UIDevice5iPhone:
        {
            return (iTunesMovieInfo.movieHeight <= 720) && (bitRateForKBPS < 1024 * 1.5);
        }
            break;
        case UIDevice1GiPad:
        {
            return (bitRateForKBPS <= 300) && (iTunesMovieInfo.movieHeight <= 300);
        }
            break;
        case UIDevice2GiPad:
        {
            return (bitRateForKBPS <= 1024);
        }
            break;
        case UIDevice3GiPad:
        {
            return (bitRateForKBPS <= 1024 * 1.3);
        }
            break;
        case UIDevice4GiPad:
        {
            return (bitRateForKBPS <= 1024 * 1.8);
        }
            break;
        case UIDeviceSimulatoriPad:
        {
            return YES;
        }
            break;
        default:
        {
            return (bitRateForKBPS <= 1024 * 1.1);
        }
            break;
    }
    
    return NO;
     */
    
}

- (BOOL)requestThumbnailImageOfMovie:(NSString *)moviePath
                   andThumbnailWidth:(CGFloat)thumbnailWidth{
    
    return NO;
    /*
    BOOL bNeedRequest = NO;
    
    NSString *thumbnailFilePath = [NSString getThumbnailPathOfItunesMovie:moviePath];
    
    NSString *movieTitle = [moviePath lastPathComponent];
    ItunesMovieCommand *iTunesMovieInfo = [ItunesMovieCommand searchByMovieTitle:movieTitle];
    
    if (nil == iTunesMovieInfo){
        bNeedRequest = YES;
    }
    
    if (!bNeedRequest) {
        return YES;
    }
    
    BOOL bResult = [LTMediaPlayerController requestThumbnailImageOfMovie:moviePath
                                                             andPosition:0.33f
                                                       andThumbnailWidth:thumbnailWidth
                                                          writePngToPath:thumbnailFilePath];
    
    return bResult;
     */
    
}

- (void)updateItunesList:(NSArray *)arrayItunesMovie{
    
    // 删掉文件已经不存在的记录
    NSArray *arrayItunesMovieOld = [ItunesMovieCommand searchAll];
    NSInteger countItunesMovieExisted = [arrayItunesMovieOld count];
    for (int i=0; i<countItunesMovieExisted; i++) {
        ItunesMovieCommand *iTunesMovieInfo = arrayItunesMovieOld[i];
        NSString *theTitle = iTunesMovieInfo.movietitle;
        BOOL bFileExisted = NO;
        for (NSString *fullpath in arrayItunesMovie) {
            if ([[fullpath lastPathComponent] isEqualToString:theTitle]) {
                bFileExisted = YES;
                break;
            }
        }
        if (!bFileExisted) {
            NSString *moviePath = [[FileManager appDocumentPath] stringByAppendingPathComponent:theTitle];
            [self removeItunesMovie:moviePath];
        }
    }
    
    /*
#ifdef LT_IPAD_CLIENT
    CGFloat thumbnailwidth = kWidthOfImgDefault;
#else
    CGFloat thumbnailwidth = 83.f;
#endif
    
    for (NSString *path in arrayItunesMovie) {
        [self requestThumbnailImageOfMovie:path
                         andThumbnailWidth:thumbnailwidth * 2];
    }
     */
}

- (void)removeItunesMovie:(NSString *)moviePath{
    
    NSString *pngPath = [NSString getThumbnailPathOfItunesMovie:moviePath];
    
    [FileManager deleteFileWithPath:moviePath];
    [FileManager deleteFileWithPath:pngPath];
    
    NSString *theTitle = [moviePath lastPathComponent];
    [ItunesMovieCommand deleteByMovieTitle:theTitle];
    
}

@end
