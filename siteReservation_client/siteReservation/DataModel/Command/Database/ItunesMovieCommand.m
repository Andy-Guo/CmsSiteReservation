//
//  ItunesMovieCommand.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-29.
//
//

#import "ItunesMovieCommand.h"
#import "SqlDBHelper.h"
//#import "NSString+HTTPExtensions.h"

@implementation ItunesMovieCommand

@synthesize
id = _id,
movietitle = _movietitle,
thumbnailtitle = _thumbnailtitle,
movieBitrate = _movieBitrate,
movieWidth = _movieWidth,
movieHeight = _movieHeight,
fileSize = _fileSize,
duration = _duration,
importTime = _importTime;



- (id) init{
    
    if (self = [super init]) {
        //
    }
    
    return self;
}

-(void)logDebug{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"ItunesMovieCommand logDebug------{{{\n id:%ld\n movietitle:%@\n thumbnailtitle:%@\n moviebitrate:%ld\n moviewidth:%ld\n movieheight:%ld\n filesize:%lld\n duration:%ld\n importtime:%@ }}}",
          (long)self.id,
          self.movietitle,
          self.thumbnailtitle,
          (long)self.movieBitrate,
          (long)self.movieWidth,
          (long)self.movieHeight,
          self.fileSize,
          (long)self.duration,
          [formatter stringFromDate:self.importTime]);
    
}

+(ItunesMovieCommand *)wrappResultSet:(id<PLResultSet>)rs{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

	ItunesMovieCommand *com = [[ItunesMovieCommand alloc] init];
    com.id = [[rs objectForColumn:@"ID"] intValue];
	com.movietitle = [rs objectForColumn:@"movietitle"];
    com.thumbnailtitle = [rs objectForColumn:@"thumbnailtitle"];
    com.movieBitrate = [[rs objectForColumn:@"moviebitrate"] intValue];
    com.movieWidth = [[rs objectForColumn:@"moviewidth"] intValue];
    com.movieHeight = [[rs objectForColumn:@"movieheight"] intValue];
    com.fileSize = [[rs objectForColumn:@"filesize"] longLongValue];
    com.duration = [[rs objectForColumn:@"duration"] intValue];
    com.importTime = [formatter dateFromString:[rs objectForColumn:@"importtime"]];
    
	return com;
}

+(BOOL) insertWithMovieTitle:(NSString *)movieTitle
           andThumbnailTitle:(NSString *)thumbnailTitle
             andMovieBitrate:(NSInteger)bitrate
               andMovieWidth:(NSInteger)width
              andMovieHeight:(NSInteger)height
                 andFileSize:(long long)fileSize
                 andDuration:(NSInteger)duration{
    
    if (    [NSString isBlankString:movieTitle]
        ||  [NSString isBlankString:thumbnailTitle]){
        return NO;
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *importTime = [formatter stringFromDate:[NSDate date]];

    NSString *strBitrate = [NSString stringWithFormat:@"%ld", (long)bitrate];
    NSString *strWidth = [NSString stringWithFormat:@"%ld", (long)width];
    NSString *strHeight = [NSString stringWithFormat:@"%ld", (long)height];
    NSString *strFileSize = [NSString stringWithFormat:@"%lld", fileSize];
    NSString *strDuration = [NSString stringWithFormat:@"%ld", (long)duration];
    
    BOOL bResult = NO;
    
    ItunesMovieCommand *iTunesMovieExistedInfo = [ItunesMovieCommand searchByMovieTitle:movieTitle];
    if (nil != iTunesMovieExistedInfo) {
        bResult = [db executeUpdate:@"UPDATE itunesmovie set thumbnailtitle=?,moviebitrate=?,moviewidth=?,movieheight=?,filesize=?,duration=?,importtime=? where movietitle=?",
                   thumbnailTitle,
                   strBitrate,
                   strWidth,
                   strHeight,
                   strFileSize,
                   strDuration,
                   importTime,
                   movieTitle];
    }
    else {
        bResult = [db executeUpdate:@"INSERT INTO itunesmovie(movietitle,thumbnailtitle,moviebitrate,moviewidth,movieheight,filesize, duration, importtime) VALUES (?,?,?,?,?,?,?,?)",
                   movieTitle,
                   thumbnailTitle,
                   strBitrate,
                   strWidth,
                   strHeight,
                   strFileSize,
                   strDuration,
                   importTime];
    }
    
	return bResult;
    
}

+ (BOOL)updateBitrate:(int)bitrate
        forMovieTitle:(NSString *)movieTitle{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate:@"update itunesmovie set moviebitrate=? where movietitle = ?",
                    [NSString stringWithFormat:@"%d", bitrate],
                    movieTitle];
	return bResult;
}

+(id) searchByMovieTitle:(NSString *)movieTitle{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select * from itunesmovie where movietitle = ? limit 1", movieTitle];
	
	ItunesMovieCommand *com = nil;
	if([rs next])
	{
		com = [ItunesMovieCommand wrappResultSet:rs];
	}
	[rs close];
    
	return com;
}

+(BOOL)deleteByMovieTitle:(NSString *)movieTitle{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
        
	BOOL bResult = [db executeUpdate: @"DELETE FROM itunesmovie WHERE movietitle=?", movieTitle];
    
    NSLog(@"deleteByMovieTitle, %@", movieTitle);
    
	return bResult;
}

+(NSArray*)searchAll{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM itunesmovie"];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	while ([rs next])
	{
        ItunesMovieCommand *imc = [self wrappResultSet:rs];
//        [imc logDebug]; // fixme
		[dbArray addObject:imc];
	}
    
	[rs close];
    
	return dbArray;
}


@end
