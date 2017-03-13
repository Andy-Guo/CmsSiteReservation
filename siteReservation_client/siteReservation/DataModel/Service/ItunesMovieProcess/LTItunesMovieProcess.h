//
//  LTItunesMovieProcess.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-29.
//
//

#import <Foundation/Foundation.h>

@interface LTItunesMovieProcess : NSObject{
    
}

+ (LTItunesMovieProcess*)sharedItunesMovieProcess;
+ (void) destroySharedItunesMovieProcess;

- (BOOL)isSupportedByLetvLocalPlayer:(NSString *)moviePath;
- (BOOL)isSupportedBySystemPlayer:(NSString *)moviePath;
- (BOOL)isSupportedByCurrentDevice:(NSString *)moviePath;
- (BOOL)requestThumbnailImageOfMovie:(NSString *)moviePath
                   andThumbnailWidth:(CGFloat)thumbnailWidth;
- (void)updateItunesList:(NSArray *)arrayItunesMovie;
- (void)removeItunesMovie:(NSString *)moviePath;

@end
