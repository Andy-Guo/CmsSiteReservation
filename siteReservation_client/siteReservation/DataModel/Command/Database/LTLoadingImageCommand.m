//
//  LTLoadingImageCommand.m
//  LeTVMobileDataModel
//
//  Created by LETV-Daemonson on 15/10/10.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTLoadingImageCommand.h"
#import "SqlDBHelper.h"

@implementation LTLoadingImageCommand
/* 根据vid、pid查询 */
+ (NSString *) searchLoadingImageByVid:(NSString *)vid pid:(NSString *)pid
{
    NSString *_vid = [NSString safeString:vid];
    NSString *_pid = [NSString safeString:pid];

    NSString *_imgPath = @"";
    
    if (![NSString empty:_pid] && ![NSString empty:_vid]) {
        _imgPath = [self getImagePath:_pid vid:vid];
    }
    
    if ([NSString empty:_imgPath]) {
        if (![NSString empty:_vid]) {
            _imgPath = [self getImagePath:@"" vid:vid];
        }
        
        if ([NSString empty:_imgPath]) {
            if (![NSString empty:_pid]) {
                _imgPath = [self getImagePath:_pid vid:@""];
            }
        }
    }
    
    return _imgPath;
}

+ (NSString *)getImagePath:(NSString *)pid vid:(NSString *)vid {
    
    NSString *pidTemp = [NSString safeString:pid];
    NSString *vidTemp = [NSString safeString:vid];
    
    NSString *sql = @"";
    
    if (![NSString empty:pidTemp] && ![NSString empty:vidTemp]) {
        sql = [NSString stringWithFormat:@"select imagePath from LTDemandLoadingImage where pid = '%@' and vid = '%@'", pidTemp, vidTemp];
    }
    else if (![NSString empty:pidTemp]) {
        sql = [NSString stringWithFormat:@"select imagePath from LTDemandLoadingImage where pid = '%@'", pidTemp];
    }
    else if (![NSString empty:vidTemp]) {
        sql = [NSString stringWithFormat:@"select imagePath from LTDemandLoadingImage where vid = '%@'", vidTemp];
    }
    else {
        return @"";
    }
    
    NSString *imgPath = @"";
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        if (![rs isNullForColumn:@"imagePath"]) {
            imgPath = [rs objectForColumn:@"imagePath"];
            break;
        }
    }
    
    [rs close];
    
    return imgPath;
}


+ (NSString *) searchLiveLoadingImageByLiveId:(NSString *)vid
{
    NSString *_vid = [NSString safeString:vid];
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    id<PLResultSet> rs;
    NSString *_imgPath = @"";
    NSString *inSql = [NSString stringWithFormat:@"select * from LTDemandLoadingImage where vid = '%@'", _vid];
    rs = [db executeQuery:inSql];
    while ([rs next])
    {
        if (![rs isNullForColumn:@"imagePath"]) {
            _imgPath = [rs objectForColumn:@"imagePath"];
            break;
        }
    }
    [rs close];
    
    return _imgPath;
}

/* 根据vid和pid存图片 */
+ (void)saveLoadingImageByVid:(NSString *)vid pid:(NSString *)pid imagePath:(NSString*)imgPath
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    
    NSString *oldImagePath = [self searchLoadingImageByVid:vid pid:pid];
    if (![NSString empty:oldImagePath] && ![imgPath isEqualToString:oldImagePath]) {
        BOOL bResult = [db executeUpdate:@"UPDATE LTDemandLoadingImage SET imagePath = '%@' WHERE pid = '%@' or vid = '%@'",
                        [NSString safeString:imgPath],
                        [NSString safeString:pid],
                        [NSString safeString:vid]];
        if (bResult) {
            
        }
        return;
    }

    BOOL bResult = [db executeUpdate:@"INSERT INTO LTDemandLoadingImage(pid,vid,imagePath) VALUES (?,?,?)",
                    [NSString safeString:pid],
                    [NSString safeString:vid],
                    [NSString safeString:imgPath]];
    
    NSLog(@"db error:%@, code:%d", [db lastErrorMessage], [db lastErrorCode]);
    
    if (bResult) {
        
    }
}
@end
