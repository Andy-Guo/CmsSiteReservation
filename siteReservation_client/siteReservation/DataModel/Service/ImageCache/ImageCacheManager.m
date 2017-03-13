//
//  ImageCacheManager.m
//  Letv
//
//  Created by iBokanWisdom on 10-6-23.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//

#import "ImageCacheManager.h"
//#import "NetworkReachability.h"
//#import "FileManager.h"
//#import "ExtensionNSString.h"

@implementation ImageCacheManager

// 2.5及之前版本，图片缓存到cache目录下
static NSString *g_cacheDirectory = @"";
// 2.6及之后版本，图片缓存到cache/cacheNormalPic目录下
static NSString *g_cacheNormalPicDirectory = @"";
// 2.6及之后版本，增加开机图片，开机图片缓存到cache/cacheAdvertisePic目录下
static NSString *g_cacheAdvertisePicDirectory = @"";
//3.4版本及以后版本，下载收藏和追剧的图片缓存到cache/cacheLocalPic目录下
static NSString *g_cacheLocalPicDirectory = @"";
//6.1版本添加启动图logo缓存到cache/cacheLaunchLogo，只会保存一张图片
static NSString *g_cacheLanuchLogoPicDirectory = @"";

static NSMutableArray *downloaders = nil;

#pragma mark -
#pragma mark init & clear cache
+(void) initCacheDirectory
{
	downloaders = [[NSMutableArray array] retain];
    
	g_cacheDirectory = [FileManager appCachePath];	
    [g_cacheDirectory retain];
    
    g_cacheNormalPicDirectory = [NSString stringWithFormat:@"%@//%@", [FileManager appCachePath], CACHE_DIRECTORY_PIC_NORMAL];	
    [FileManager createDirectory:g_cacheNormalPicDirectory];
	[g_cacheNormalPicDirectory retain];
  
    g_cacheAdvertisePicDirectory = [NSString stringWithFormat:@"%@//%@", [FileManager appCachePath], CACHE_DIRECTORY_PIC_ADVERTISE];	
    [FileManager createDirectory:g_cacheAdvertisePicDirectory];
	[g_cacheAdvertisePicDirectory retain];
    
    g_cacheLocalPicDirectory=[NSString stringWithFormat:@"%@//%@", [FileManager appCachePath], CACHE_DIRECTORY_PIC_LOCAL];
    [FileManager createDirectory:g_cacheLocalPicDirectory];
	[g_cacheLocalPicDirectory retain];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        [self clearCache:ImageTypeOld];
        [self clearCache:ImageTypeNormal];
        [self clearCache:ImageTypeAdvertise];
        [self clearCache:ImageTypeLocal];
    });
}

-(void) dealloc
{
	[g_cacheDirectory release];
    [g_cacheNormalPicDirectory release];
    [g_cacheAdvertisePicDirectory release];
    [g_cacheLocalPicDirectory release];
    
	[super dealloc];
}

+(NSString *) getCacheDirectoryByType:(ImageType) type{
    switch (type) {
        case ImageTypeOld:
            return g_cacheDirectory;
        case ImageTypeNormal:
            return g_cacheNormalPicDirectory;
        case ImageTypeAdvertise:
            return g_cacheAdvertisePicDirectory;
        case ImageTypeLocal:
            return g_cacheLocalPicDirectory;
        default:
            return g_cacheDirectory;
    }
}

+(void) clearCache:(ImageType) type
{
	NSFileManager* fm = [NSFileManager defaultManager];
	NSError* err = nil;
	BOOL res;
	NSArray *array = [fm contentsOfDirectoryAtPath:[ImageCacheManager getCacheDirectoryByType:type] error:nil];
	for(NSString *path in array){
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSDictionary *fileAttrs = [fm attributesOfItemAtPath:[[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent:path] error:nil];	
        BOOL shouldRemovePath = NO;
        switch (type) {
            case ImageTypeOld:
            {
                BOOL isDir;
                NSString *fullPath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent:path]; 	
                shouldRemovePath = (    [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir] 
                                    &&  (!isDir || [path isEqualToString:@"CCWSSAdvertise"] || [path isEqualToString:@"cacheChannelType"]));
            }
                break;
            case ImageTypeNormal:
            
            {
                NSDate *fileCreationDate = (NSDate *)[fileAttrs valueForKey:@"NSFileCreationDate"];
                NSDate *currentDate = [NSDate date];
                NSTimeInterval timeDistance = [fileCreationDate timeIntervalSinceDate:currentDate];
                //缓存 IMAGE_CAHCE_DAY天 的图片
                shouldRemovePath = (    timeDistance < 60*60*24*(-IMAGE_CAHCE_DAY) 
                                    ||  timeDistance > 60*60*24*IMAGE_CAHCE_DAY);
            }
                break;
            case ImageTypeAdvertise:
            {
                // fixme：
            }
                break;
            case ImageTypeLocal:
            {
                // fixme：
            }
            default:
                break;
        }
        
        if (shouldRemovePath) {
            res = [fm removeItemAtPath:[[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent:path] error:&err];
            if (!res && err) 
            {
                NSLog(@"clear cache, image type: %d oops: %@", type, err);
            }
        }
        
		[pool release];
	}	
}

+ (NSString *)formatImageName:(NSString *)urlString withType:(ImageType)type
{
    NSString *name = [urlString stringByReplacingOccurrencesOfRegex:@"\\W" withString:@"_"];
    return name;
}

#pragma mark -
#pragma mark image downloader
//20101217 gushuo add for 将加载完的图片写入缓存.
+(BOOL) setImageData:(NSData *)imagedata ForUrlString:(NSString *) urlString withType:(ImageType) type
{
	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath];
    
	return [imagedata writeToFile:imageCachePath 
                       atomically:YES];
}

//20101217 gushuo add for 取消没加载完成的数据加载
+(void) cancleDownloaders
{
	for (ImageDownloader *downloader in downloaders) {
		[downloader cancelDownload];
	}
	[downloaders removeAllObjects];	
}

+(void)removeDownloader:(ImageDownloader *)downloader
{
	[downloaders removeObject:downloader];
}

#pragma mark -
#pragma mark setImageView
+(void) setImageView:(NSDictionary *)parameterDict withType:(ImageType) type
{	
	NSString *urlString = [parameterDict valueForKey:@"urlString"];
	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath]; 	
	if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])	{
		UIImageView *imageView = [parameterDict valueForKey:@"imageView"];
		imageView.image = [UIImage imageWithContentsOfFile: imageCachePath];
        if (![NSObject empty:[parameterDict valueForKey:@"flagNotify"]]) {
            [ImageCacheManager postImageDidLoadNotification:urlString
                                               andImageType:type
                                              andLoadResult:YES];
        }
	}
	else 
	{
		if ([NetworkReachability connectedToNetwork]) {
			//异步获取
			ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
			imageDownloader.indicator = ![NSObject empty:[parameterDict valueForKey:@"indicator"]];
            imageDownloader.flagNotify = ![NSObject empty:[parameterDict valueForKey:@"flagNotify"]];
			imageDownloader.imageView = [parameterDict valueForKey:@"imageView"];
			imageDownloader.imageURLString = urlString;
            imageDownloader.imgType = type;
			[downloaders addObject:imageDownloader];
			[imageDownloader startDownload];            
			[imageDownloader release];
		}
	}
}

+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString withType:(ImageType) type
{
    NSDictionary *parameterDict;
    if (nil == imageView) {
        parameterDict = [NSDictionary dictionaryWithObjects:@[urlString] 
                                                    forKeys:@[@"urlString"]];
    }
    else {
        parameterDict = [NSDictionary dictionaryWithObjects:@[imageView,urlString] 
                                                    forKeys:@[@"imageView",@"urlString"]];
    }
    
	[self setImageView:parameterDict withType:type];
}

+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString  withDefaultString:(NSString *)defaultString withType:(ImageType) type
{
	imageView.image = [UIImage imageNamed:defaultString];	
	if ([NSString isBlankString:urlString]) {
		return;
	}
	if ([NSString isBlankString:[urlString stringByMatching:REGEX_HTTP]]) {
		return;
	}
	NSDictionary *parameterDict = [NSDictionary dictionaryWithObjects:@[imageView,urlString] 
															  forKeys:@[@"imageView",@"urlString"]];
	[self setImageView:parameterDict withType:type];	
}

+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString withIndicator:(BOOL)indicator withFlagNotify:(BOOL)flagNotify withType:(ImageType) type{
    
    NSMutableDictionary *parameterDict;
    if (nil == imageView) {
        parameterDict = [NSMutableDictionary dictionaryWithObjects:@[urlString] 
                                                           forKeys:@[@"urlString"]];
    }
    else {
        parameterDict = [NSMutableDictionary dictionaryWithObjects:@[imageView,urlString] 
                                                           forKeys:@[@"imageView",@"urlString"]];
    }

	if (indicator) {
		parameterDict[@"indicator"] = @"YES";
	}	
    if (flagNotify) {
        parameterDict[@"flagNotify"] = @"YES";
    }
    
	[self setImageView:parameterDict withType:type];
	
}

+ (void)postImageDidLoadNotification:(NSString*)urlString 
                        andImageType:(ImageType)imgType
                       andLoadResult:(BOOL)bLoadResult{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@", urlString]
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d", imgType], [NSString stringWithFormat:@"%d", bLoadResult]] 
                                                                                           forKeys:@[@"imgType", @"result"]]];
//    NSLog(@"ImageCacheManager notify: %@ %d %d", urlString, imgType, bLoadResult);
    
}

#pragma mark -
#pragma mark get functions
+(BOOL) isExistFileFromUrlString:(NSString *) urlString withType:(ImageType) type{
	if ([NSObject empty:urlString]) {
		return NO;
	}
	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath];     
	if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])
	{
		return YES;
	}
	else 
	{
		return NO;
	}    
    
}

+(NSString *)getLocalFilePathFromUrlString: (NSString *) urlString
                                  withType: (ImageType) type{
    
    if ([NSObject empty:urlString]) {
		return @"";
	}
	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath];     
	if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])
	{
		return imageCachePath;
	}
	else 
	{
		return @"";
	}   
}

+(NSString *) getImagePathFromUrlString:(NSString *) urlString withType:(ImageType) type{
	
    if ([NSObject empty:urlString]) {
		return nil;
	}
    
	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath];     
	if([[NSFileManager defaultManager] fileExistsAtPath: imageCachePath])
	{
		return imageCachePath;
	}
    
	return nil;
}

+(NSString *) getLatestImagePath:(ImageType) type{

    NSFileManager* fm = [NSFileManager defaultManager];
	NSArray *array = [fm contentsOfDirectoryAtPath:[ImageCacheManager getCacheDirectoryByType:type] error:nil];
    NSDate *dateNewly = nil;
    NSString *respath = nil;
	for(NSString *path in array){
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSDictionary *fileAttrs = [fm attributesOfItemAtPath:[[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent:path] error:nil];		
		NSDate *fileCreationDate = (NSDate *)[fileAttrs valueForKey:@"NSFileCreationDate"];
        if ([NSObject empty:dateNewly] || [[dateNewly earlierDate:fileCreationDate] isEqualToDate:dateNewly]) {
            dateNewly = fileCreationDate;
            respath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent:path];
        }
		[pool release];
	}	
    
    return respath;
}

+(void)addCacheImageViaWifiWithUrl:(NSString *)urlString  
                           andType:(ImageType)type{
//V5.1.2版本去掉这个3G相关的逻辑
//    if (![[NetworkReachability currentNetType] isEqualToString:@"wifi"]) {
//        return;
//    }
    if (![NetworkReachability connectedToNetwork]) {
        return;
    }
    
    [self addCacheImageWithUrl:urlString
                 andFlagNotify:NO
                       andType:type];
    
    return;
}

+(void)addCacheImageWithUrl:(NSString *)urlString 
              andFlagNotify:(BOOL)flagNotify
                    andType:(ImageType)type{
    
    [ImageCacheManager setImageView:nil
                      withUrlString:urlString
                      withIndicator:NO
                     withFlagNotify:flagNotify
                           withType:type];
    
    return;
    
}

+(void)deleteCacheImageWithUrl:(NSString *)urlString  
                       andType:(ImageType)type{
    
    if ([NSString isBlankString:urlString]) {
		return;
	}
    
    NSFileManager* fm = [NSFileManager defaultManager];
	NSError* err = nil;

	NSString *imageCachePath = [ImageCacheManager formatImageName:urlString withType:type];
	imageCachePath = [[ImageCacheManager getCacheDirectoryByType:type] stringByAppendingPathComponent: imageCachePath];     
	if([fm fileExistsAtPath: imageCachePath])
	{
        [fm removeItemAtPath:imageCachePath error:&err];
	}
    
    return;
    
}

#pragma mark -
#pragma mark compatibility 无ImageType参数，默认为ImageTypeNormal
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString{
    [ImageCacheManager setImageView:imageView withUrlString:urlString withType:ImageTypeNormal];
}
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString  withDefaultString:(NSString *)defaultString{
    [ImageCacheManager setImageView:imageView withUrlString:urlString withDefaultString:defaultString withType:ImageTypeNormal];
}
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString  withIndicator:(BOOL)indicator{
    [ImageCacheManager setImageView:imageView withUrlString:urlString withIndicator:indicator withFlagNotify:NO withType:ImageTypeNormal];
}
+(BOOL) isExistFileFromUrlString:(NSString *) urlString{
    return [ImageCacheManager isExistFileFromUrlString:urlString withType:ImageTypeNormal];
}
@end
