//
//  ImageCacheManager.h
//  Letv
//
//  Created by iBokanWisdom on 10-6-23.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LeTVMobileFoundation/LeTVMobileFoundation.h>
#import <LetvMobileDataModel/ImageDownloader.h>
//#import "Global.h"

@interface ImageCacheManager : NSObject {

}

+(void) initCacheDirectory;
+(void) clearCache:(ImageType) type;

+(NSString *) getCacheDirectoryByType: (ImageType) type;

+(void) setImageView: (UIImageView *) imageView
       withUrlString: (NSString *) urlString
            withType: (ImageType) type;

+(void) setImageView: (UIImageView *) imageView 
       withUrlString: (NSString *) urlString 
   withDefaultString: (NSString *)defaultString
            withType: (ImageType) type;

+(void) setImageView: (UIImageView *) imageView
       withUrlString: (NSString *) urlString  
       withIndicator: (BOOL)indicator
      withFlagNotify: (BOOL)flagNotify
            withType: (ImageType) type;

+ (void)postImageDidLoadNotification:(NSString*)urlString 
                        andImageType:(ImageType)imgType
                       andLoadResult:(BOOL)bLoadResult;

+(BOOL) isExistFileFromUrlString: (NSString *) urlString
                        withType: (ImageType) type;
+(NSString *)getLocalFilePathFromUrlString: (NSString *) urlString
                                  withType: (ImageType) type;
+(BOOL) setImageData:(NSData *)imagedata 
        ForUrlString:(NSString *)urlString  
            withType:(ImageType)type;

+(NSString *) getImagePathFromUrlString: (NSString *) urlString
                               withType: (ImageType) type;

+(NSString *) getLatestImagePath: (ImageType) type;

+(void)addCacheImageViaWifiWithUrl: (NSString *) urlString  
                           andType: (ImageType) type;
+(void)addCacheImageWithUrl:(NSString *)urlString 
              andFlagNotify:(BOOL)flagNotify
                    andType:(ImageType)type; 
+(void)deleteCacheImageWithUrl:(NSString *)urlString  
                       andType:(ImageType)type;

//---------- fixme:为了兼容以前的调用 begin
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString;
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString  withDefaultString:(NSString *)defaultString;
+(void) setImageView: (UIImageView *) imageView withUrlString: (NSString *) urlString  withIndicator:(BOOL)indicator;
+(BOOL) isExistFileFromUrlString:(NSString *) urlString;
//---------- fixme:为了兼容以前的调用 end

+(void) cancleDownloaders;
+(void)removeDownloader:(ImageDownloader *)downloader;
@end
