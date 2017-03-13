//
//  LiveOrderCommand.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 12-9-26.
//
//

#import "LiveOrderCommand.h"
//#import "GlobalInterface.h"
//#import "NSString+HTTPExtensions.h"
#import "LTRequestURLManager.h"

@implementation LiveOrderCommand
@synthesize id=_id,
orderName=_orderName,
playTime=_playTime,
channel_code=_channel_code,
orderDate=_orderDate,
channel_name=_channel_name;

-(void)logDebug{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"LiveOrderCommand logDebug------{{{\nid:%ld\nordername:%@\norderDate:%@\nplayTime:%@\nchannelCode:%@\n}}}",
          (long)self.id,
          self.orderName,
          [formatter stringFromDate:self.orderDate],
          self.playTime,
          self.channel_code);
    
}
+(LiveOrderCommand *)wrappResultSet:(id<PLResultSet>)rs{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
    
	LiveOrderCommand *com = [[LiveOrderCommand alloc] init];
    com.id = [[NSString safeString:[rs objectForColumn:@"ID"]] intValue];
	com.orderName = [NSString safeString:[rs objectForColumn:@"orderName"]];
    com.playTime=[NSString safeString:[rs objectForColumn:@"playTime"]];
    com.channel_code=[NSString safeString:[rs objectForColumn:@"channel_code"]];
    //    com.playTime = [formatter dateFromString:[NSString safeString:[rs objectForColumn:@"starttime"]]];
	com.orderDate = [formatter dateFromString:[NSString safeString:[rs objectForColumn:@"orderDate"]]];
    com.channel_name=[NSString safeString:[rs objectForColumn:@"channel_name"]];
    
	return com;
}
+(BOOL) insertWithorderName:(NSString *)name
                andplayTime:(NSString *)playtime
             andChannelCode:(NSString *)channelCode
               andOrderDate:(NSDate *)orderDate
             andChannelName:(NSString *)channelName{
    if (    [NSString isBlankString:name]
        ||  nil == orderDate
        ||   [NSString isBlankString:channelCode]
        ) {
        return NO;
    }
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
    
	NSString *st = [formatter stringFromDate:orderDate];
    
    
    BOOL bResult = NO;
    
//    LiveOrderCommand *bootimageExistedInfo = [LiveOrderCommand searchByName:name];
//    if (nil != bootimageExistedInfo) {
//        bResult = [db executeUpdate:@"UPDATE liveOrder set playTime=?,channel_code=?,orderDate=? where orderName = ?",
//                   playtime,
//                   channelCode,
//                   st,
//                   name];
//    }
//    else {
        bResult = [db executeUpdate:@"INSERT INTO liveOrder(orderName,playTime,channel_code,orderDate,channel_name) VALUES (?,?,?,?,?)",
                   name,
                   playtime,
                   channelCode,
                   st,
                   channelName];
//    }

	return bResult;
    
}

+(NSArray*)searchAll{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	id<PLResultSet> rs = [db executeQuery:@"SELECT * FROM liveOrder Order By playTime Asc"];
    
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	while ([rs next])
	{
        LiveOrderCommand *bic = [self wrappResultSet:rs];
//        [bic logDebug];
		[dbArray addObject:bic];
	}
    
	[rs close];
    
	return dbArray;
}
+(id)searchByName:(NSString *)ordername{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	NSString *sql = [NSString stringWithFormat:@"select * from liveOrder where orderName = '%@' limit 1", ordername];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:sql];
	
	LiveOrderCommand *com = nil;
	if([rs next])
	{
		com = [LiveOrderCommand wrappResultSet:rs];
	}
	[rs close];
    
	return com;
}

+(id)searchByBillDate:(NSString *)billDate billTime:(NSString *)billTime channelCode:(NSString *)channel_code{
    
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"SELECT * FROM liveOrder WHERE orderDate=? AND playTime=? AND channel_code=? ",billDate,billTime,channel_code];
	
	LiveOrderCommand *com = nil;
	if([rs next])
	{
		com = [LiveOrderCommand wrappResultSet:rs];
	}
	[rs close];
    
	return com;
}
+ (id)searchByBillDate:(NSString *)billDate billTime:(NSString *)billTime channelCode:(NSString *)channel_code orderName:(NSString *)orderName{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    rs = [db executeQuery:@"SELECT * FROM liveOrder WHERE orderDate=? AND playTime=? AND channel_code=? AND orderName=?",billDate,billTime,channel_code,orderName];
    LiveOrderCommand *com = nil;
    if ([rs next]) {
        com = [LiveOrderCommand wrappResultSet:rs];
    }
    [rs close];
    return com;
}

+(NSArray*)searchByOrderDate:(NSDate *)orderDate{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *st = [formatter stringFromDate:orderDate];
	
	id<PLResultSet> rs;
	rs = [db executeQuery:@"SELECT * FROM liveOrder WHERE orderDate=? Order By playTime Asc",st];

    NSMutableArray *dbArr = [[NSMutableArray alloc] init];
	
    while([rs next])
	{
		LiveOrderCommand *bic = [self wrappResultSet:rs];
        [dbArr addObject:bic];

	}
	[rs close];
    
	return dbArr;

}
+(BOOL)deleteByName:(NSString *)ordername{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM liveOrder WHERE orderName=?",ordername];
    
	return bResult;
    
}
+(BOOL)deleteByPlayTime:(NSString *)playTime channel_code:(NSString *)channelCode{
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM liveOrder WHERE playTime=? AND channel_code=?",playTime,channelCode];
    
	return bResult;
    
}

+(BOOL)deleteByDate:(NSString *)date playTime:(NSString *)playTime channel_code:(NSString *)channel_code orderName:(NSString *)orderName{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"DELETE FROM liveOrder WHERE orderDate=? AND playTime=? AND channel_code=? AND orderName=?",date,playTime,channel_code,orderName];
    return bResult;
}

+(BOOL) deleteByID:(NSInteger)ID{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM liveOrder WHERE id = %ld",(long)ID]];
    
    
   	return bResult;
}

+(BOOL) deleteByExpiredTime:(NSDate *)curdate{
    BOOL bResult =NO;
	PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSArray *dataArray=[LiveOrderCommand searchAll];
    for (int i=0; i<[dataArray count]; i++) {
        LiveOrderCommand *liveOrderInfo=(LiveOrderCommand *)[dataArray objectAtIndex:i];
        NSDate *orderDate=liveOrderInfo.orderDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *st = [formatter stringFromDate:orderDate];
        NSString *playTime=liveOrderInfo.playTime;
        NSString *detailTime=[NSString stringWithFormat:@"%@ %@",st,playTime];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [dateFormatter dateFromString:detailTime];
        
        if ([[curdate laterDate:date]isEqualToDate:curdate]) {
            bResult=[db executeUpdate:@"DELETE FROM liveOrder WHERE playTime=? AND orderDate=?",playTime,st];
        }
        
    }
    
    
   	return bResult;
}
+(BOOL)deleteAll{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
	BOOL bResult = [db executeUpdate: @"DELETE FROM liveOrder"];
    
	return bResult;
}

+(BOOL)openLiveOrder{
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_BookLive_Open
                                                       andDynamicValues:[NSArray arrayWithObjects:
                                                                         did_client,
                                                                         nil]];
    if (![NetworkReachability connectedToNetwork]) {
        return NO;
    }
    NSLog(@"liveCommand, url string = %@\n", urlString);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (nil == urlRequest) {
        return NO;
    }
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setTimeoutInterval:5];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSInteger statusCode = [httpResponse statusCode];
        if (statusCode == 200) {
            [SettingManager saveStringValueToUserDefaults:@"1"
                                       ForKey:kSetPushLiveOrder];
            
        }
    }];
    return YES;
//    return [self addOpt:urlString];
    
}

+(BOOL)closeLiveOrder{
    NSString *did_client = [DeviceManager getDeviceUUID];
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_BookLive_Close
                                                       andDynamicValues:[NSArray arrayWithObjects:
                                                                         did_client,
                                                                         nil]];
    if (![NetworkReachability connectedToNetwork]) {
        return NO;
    }
    NSLog(@"liveCommand, url string = %@\n", urlString);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (nil == urlRequest) {
        return NO;
    }
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setTimeoutInterval:5];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [httpResponse statusCode];
        if (statusCode == 200) {
            [SettingManager saveStringValueToUserDefaults:@"0" ForKey:kSetPushLiveOrder];
        }
    }];
    return YES;
//    return [self addOpt:urlString];

}

+ (BOOL)addOpt:(NSString *)urlString{
    
    if (![NetworkReachability connectedToNetwork]){
        return NO;
    }
    
    NSLog(@"liveCommand, url string = %@\n", urlString);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (nil == urlRequest) {
        return NO;
    }
    
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setTimeoutInterval:1];
    NSURLResponse *response;
	[NSURLConnection sendSynchronousRequest: urlRequest
                          returningResponse: &response
                                      error: nil];
    
    NSLog(@"liveCommand, response string = %ld\n",(long)[(NSHTTPURLResponse *)response statusCode]);
    
    if (200 == [(NSHTTPURLResponse *)response statusCode]) {
        return YES;
    }
    
    return NO;
}

@end
