//
//  BootImageCommand.m
//  LetvIpadClient
//
//  Created by 春艳 赵 on 12-5-24.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import "BootImageCommand.h"
//#import "NSString+HTTPExtensions.h"

@implementation BootImageCommand

@synthesize id = _id;
@synthesize name = _name;
@synthesize starttime = _starttime;
@synthesize endtime = _endtime;
@synthesize priority = _priority;
@synthesize type=_type;
@synthesize movieID=_movieID;


-(void)logDebug{
    
    /*
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"BootImageCommand logDebug------{{{\nid:%d\nname:%@\nstarttime:%@\nendtime:%@\npriority:%d\n}}}",
          self.id,
          self.name, 
          [formatter stringFromDate:self.starttime], 
          [formatter stringFromDate:self.endtime],
          self.priority);
    */
}

+(BootImageCommand *)wrappResultSet:(id<PLResultSet>)rs{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
	BootImageCommand *com = [[BootImageCommand alloc] init];
    com.id = [[NSString safeString:[rs objectForColumn:@"ID"]] intValue];
	com.name = [NSString safeString:[rs objectForColumn:@"pushpic"]];
    com.starttime = [formatter dateFromString:[NSString safeString:[rs objectForColumn:@"starttime"]]];
	com.endtime = [formatter dateFromString:[NSString safeString:[rs objectForColumn:@"endtime"]]];
	com.priority = [[NSString safeString:[rs objectForColumn:@"priority"]] intValue];
    com.type= [NSString safeString:[rs objectForColumn:@"type"]];
    com.movieID= [NSString safeString:[rs objectForColumn:@"movieID"]];
    
	return com;
}

+(BOOL) insertWithName:(NSString *)name
          andStartTime:(NSDate *)starttime
            andEndTime:(NSDate *)endtime
           andPriority:(LTBootImagePriority)priority
               andType:(NSString *)type
                 andID:(NSString *)movieID{
    
    //方舟广告启动图没有startTime和endTime;
    if (    [NSString isBlankString:name]
        || ( (nil == starttime
        ||  nil == endtime) && (priority !=BootImagePriorityAdvertise))
       ) {
        return NO;
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
	NSString *st = [formatter stringFromDate:starttime];
    NSString *et = [formatter stringFromDate:endtime];
    NSString *po = [NSString stringWithFormat:@"%d", priority];
        
    BOOL bResult = NO;

    BootImageCommand *bootimageExistedInfo = [BootImageCommand searchByName:name];
    if (nil != bootimageExistedInfo) {
        bResult = [db executeUpdate:@"UPDATE bootimage set starttime=?,endtime=?,priority=?,type=?,movieID=? where pushpic = ?",
                   st,
                   et,
                   po,
                   type,
                   movieID,
                   name];
    }
    else {
        bResult = [db executeUpdate:@"INSERT INTO bootimage(pushpic,starttime,endtime,priority,type,movieID) VALUES (?,?,?,?,?,?)",
                   name,
                   st,
                   et,
                   po,
                   type,
                   movieID];
    }
    
	return bResult;
    
}

+(NSArray*)searchAll{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM bootimage"];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];	
	while ([rs next]) 
	{
        BootImageCommand *bic = [self wrappResultSet:rs];
        [bic logDebug];
		[dbArray addObject:bic];
	}	
    
	[rs close];
        
	return dbArray;	
}

+(NSArray*) searchNotOutOfDateExceptPriority:(LTBootImagePriority)priority{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	
	id<PLResultSet> rs = [db executeQuery:@"select * from bootimage where priority != ?",
                          [NSString stringWithFormat:@"%d", priority]];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    
	while([rs next])
	{
        BootImageCommand *bic = [self wrappResultSet:rs];
        NSDate *currDate=[NSDate date];
        if ([[currDate earlierDate:bic.starttime] isEqualToDate:currDate]) {
            continue;
        }
        if ([[currDate laterDate:bic.endtime] isEqualToDate:currDate]) {
            continue;
        }
		[dbArray addObject:bic];
	}
	[rs close];
    
	return dbArray;
}

+(NSArray*) searchNotOutOfDateByPriority:(LTBootImagePriority)priority{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	
	id<PLResultSet> rs = [db executeQuery:@"select * from bootimage where priority = ?",
                          [NSString stringWithFormat:@"%d", priority]];

    NSMutableArray *dbArray = [[NSMutableArray alloc] init];	

	while([rs next])
	{
        BootImageCommand *bic = [self wrappResultSet:rs];
        NSDate *currDate=[NSDate date];
        if (priority!=BootImagePriorityAdvertise) {
            //方舟广告系统暂时不支持startTime和endTime
            if ([[currDate earlierDate:bic.starttime] isEqualToDate:currDate]) {
                continue;
            }
            if ([[currDate laterDate:bic.endtime] isEqualToDate:currDate]) {
                continue;
            }
        }
       
		[dbArray addObject:bic];
	}
	[rs close];
    
	return dbArray;
}

+(id) searchByName:(NSString *)picname{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	NSString *sql = [NSString stringWithFormat:@"select * from bootimage where pushpic = '%@' limit 1", picname];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:sql];
	
	BootImageCommand *com = nil;
	if([rs next])
	{
		com = [BootImageCommand wrappResultSet:rs];
	}
	[rs close];
    
	return com;
}

+(BOOL)deleteByName:(NSString *)picname{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM bootimage WHERE pushpic=?",picname];
    
	return bResult;
    
}

+(BOOL)deleteByPriority:(LTBootImagePriority)priority {
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM bootimage WHERE priority=?", [NSString stringWithFormat:@"%d", priority]];
    
	return bResult;
    
}


@end
