//
//  LTSubtitleAudioTrackCommand.m
//  LeTVMobileDataModel
//
//  Created by 彦芳 张 on 16/2/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LTSubtitleAudioTrackCommand.h"
#import "LTDataBaseCommDef.h"
@implementation LTSubtitleAudioTrackCommand

-(LTSubtitleAudioTrackCommand *)initWithPid:(NSString *)pid subtitleKey:(NSString *)subKey audioKey:(NSString *)audioKey{
    
    self = [super init];
    if(self){
        self.videoPid = [NSString safeString:pid];
        self.subtitleKeyStr = [NSString safeString:subKey];
        self.audioKeyStr = [NSString safeString:audioKey];
    }
    return self;
}

+(void)creatSubtitleTable{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if (![db tableExists:@"LTSubtitleAudioTrack"]) {
        [db executeUpdate:LT_DB_CREATE_SUBTITLEAUDIOTRACK];
    }
}
+(LTSubtitleAudioTrackCommand*)searchSubtitleAudioKeyByPid:(NSString*)pid{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from LTSubtitleAudioTrack where pid= '%@' Order By  ID desc",pid];
    
    rs  = [db executeQuery:sqlStr];
    
    LTSubtitleAudioTrackCommand *com = nil;
    if([rs next])
    {
        com = [LTSubtitleAudioTrackCommand wrappResultSet:rs];
    }
    [rs close];
    return com;

}
+(LTSubtitleAudioTrackCommand *)wrappResultSet:(id<PLResultSet>)rs{
    int _ID = 0;
    if (![rs isNullForColumn:@"ID"]) {
        _ID = [[rs objectForColumn:@"ID"] intValue];
    }
    NSString *pidStr = [rs objectForColumn:@"pid"];
    NSString *subtitleKey = [rs objectForColumn:@"subtitlekey"];
    NSString *audioKeyStr = [rs objectForColumn:@"audioKey"];
    LTSubtitleAudioTrackCommand *subtitleCommand = [[LTSubtitleAudioTrackCommand alloc] initWithPid:pidStr subtitleKey:subtitleKey audioKey:audioKeyStr];
    return subtitleCommand;
}
+(NSArray*)searchAll{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"LTSubtitleAudioTrack"]) {
        id<PLResultSet> rs;
        
        rs  = [db executeQuery:@"select * from LTSubtitleAudioTrack Order By ID"];
        
        while ([rs next])
        {
            [dbArray addObject:[LTSubtitleAudioTrackCommand wrappResultSet:rs]];
        }
        [rs close];
    }
    
    return dbArray;
}
+(void)deleteOldSubtitleAndAudioKey{
    
    NSArray *dbArray = [LTSubtitleAudioTrackCommand searchAll];
    NSMutableArray *needDeleteArray = [[NSMutableArray alloc] init];
    if(dbArray&& [dbArray isKindOfClass:[NSArray class]] && [dbArray count] > 50){
        for(int i = 0;i < [dbArray count] - 50;i++){
            [needDeleteArray addObject:[dbArray objectAtIndex:i]];
        }
        [needDeleteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LTSubtitleAudioTrackCommand *subCommand = (LTSubtitleAudioTrackCommand *)obj;
            PLSqliteDatabase *db = [SqlDBHelper setUp];
            [db executeUpdate: @"DELETE FROM LTSubtitleAudioTrack WHERE pid= ?",subCommand.videoPid];
        }];
    }
    
}
+(void)insertSubtitle:(NSString *)subtitleKey audioKey:(NSString *)audioKey pid:(NSString *)pid{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSMutableArray *dbArray = [[NSMutableArray alloc] init];
    if ([db tableExists:@"LTSubtitleAudioTrack"]) {
        id<PLResultSet> rs;
        rs  = [db executeQuery:@"select * from LTSubtitleAudioTrack where pid = ?",pid];
        while ([rs next])
        {
            [dbArray addObject:[LTSubtitleAudioTrackCommand wrappResultSet:rs]];
        }
        [rs close];
        if([dbArray count] > 0){
            LTSubtitleAudioTrackCommand *comm = [dbArray objectAtIndex:0];
            if(![NSString isBlankString:comm.videoPid]){
                [self updateSubtitle:subtitleKey audioKey:audioKey pid:pid withCurCom:comm];
            }
        }else{
            [db executeUpdate:@"INSERT INTO LTSubtitleAudioTrack(subtitlekey,audiokey,pid) VALUES(?,?,?)",subtitleKey,audioKey,pid];
        }
    }else{
        [self creatSubtitleTable];
        [db executeUpdate:@"INSERT INTO LTSubtitleAudioTrack(subtitlekey,audiokey,pid) VALUES(?,?,?)",subtitleKey,audioKey,pid];
    }
    
    
}
+(void)updateSubtitle:(NSString*)subtitleKey audioKey:(NSString *)audioKey pid:(NSString *)pid withCurCom:(LTSubtitleAudioTrackCommand *)comm
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    if(![NSString isBlankString:subtitleKey] && ![NSString isBlankString:audioKey]){
         [db executeUpdate:@"update LTSubtitleAudioTrack set subtitlekey=?, audioKey=? where pid = ?",subtitleKey,audioKey,comm.videoPid];
        
    }else if (![NSString isBlankString:subtitleKey]&& [NSString isBlankString:audioKey]){
        [db executeUpdate:@"update LTSubtitleAudioTrack set subtitlekey=? where pid = ?",subtitleKey,comm.videoPid];
    }else if([NSString isBlankString:subtitleKey]&& ![NSString isBlankString:audioKey]){
        [db executeUpdate:@"update LTSubtitleAudioTrack set audiokey=? where pid = ?",audioKey,comm.videoPid];
    }
    
}
+(BOOL)hasSubtitleTable{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    return [db tableExists:@"LTSubtitleAudioTrack"];
}

@end
