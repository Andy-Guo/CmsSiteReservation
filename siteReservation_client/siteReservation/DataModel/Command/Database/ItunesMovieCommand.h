//
//  ItunesMovieCommand.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-29.
//
//

#import <Foundation/Foundation.h>


@interface ItunesMovieCommand : NSObject{
    NSInteger _id;
    NSString *_movietitle;
    NSString *_thumbnailtitle;
    NSInteger _movieBitrate;
    NSInteger _movieWidth;
    NSInteger _movieHeight;
    long long _fileSize;
    NSInteger _duration;
    NSDate *_importTime;
}

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *movietitle;
@property (nonatomic, copy) NSString *thumbnailtitle;

@property (nonatomic, assign) NSInteger movieBitrate;
@property (nonatomic, assign) NSInteger movieWidth;
@property (nonatomic, assign) NSInteger movieHeight;

@property (nonatomic, assign) long long fileSize;
@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, strong) NSDate *importTime;


+(id) searchByMovieTitle:(NSString *)movieTitle;
+(BOOL)deleteByMovieTitle:(NSString *)movieTitle;
+(NSArray*)searchAll;
+ (BOOL)updateBitrate:(int)bitrate
        forMovieTitle:(NSString *)movieTitle;

+(BOOL) insertWithMovieTitle:(NSString *)movieTitle
           andThumbnailTitle:(NSString *)thumbnailTitle
             andMovieBitrate:(NSInteger)bitrate
               andMovieWidth:(NSInteger)width
              andMovieHeight:(NSInteger)height
                 andFileSize:(long long)fileSize
                 andDuration:(NSInteger)duration;

@end
