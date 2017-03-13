//
//  SqlDBHelper.h
//  BookManagement
//
//  Created by iBokanWisdom on 10-5-27.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileFoundation/LeTVMobileFoundation.h>
//#import "PlausibleDatabase.h"
#import <LetvMobileDataModel/LTDataBaseCommDef.h>

@class PLSqliteDatabase;

@interface SqlDBHelper : NSObject
{
    
}

+(void)updateDownloadHistoryFor38;
+(BOOL) isTableExist:(NSString*)tableName;
+(void) dropTable:(NSString*)tableName;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
+(BOOL) isTable:(NSString *)tableName existCloum:(NSString *)cloumName;
#endif

#ifdef LT_IPAD_CLIENT

+(PLSqliteDatabase*) setUp;
+(void) close;
+(void) dropDatabase;
+(void) updateFor23;
+(void) updateFor26;
+(void) updateFor261;
+(void) updateFor27;
+(void) updateFor29;
+(void) updateFor33;
+(void) initFor21;
+(void)updateHistoryFor35;
+(void)updateBootImgFor38;
+(void)updateLiveOrderFor53;
+(void)updatePlayHistoryForIpad602;
#ifdef LT_MERGE_FROM_IPAD_CLIENT
+ (void) updateDownloadHistoryFor55;
#endif

#else

+(PLSqliteDatabase*) setUp;
+(void) close;
+(void) dropDatabase;
+(void) initDatabase;
+(void)updateDatabaseFor21;
+(void) updateDatabaseFrom23To231;
+(void) updateDownloadHistoryFor24;
+(void) updateHistoryFor24;
+(void) updateDownloadHistoryFor26;
+ (void)updateDownloadHistoryFor242;
+(void) updateFor25;
+(void)updateHistoryFor25;
+(void)updateBootImgFor27;
+(void)updateHistoryFor28;
+(void)updateLiveOrderFor29;
+(void) updateFor33;
+(void)updateHistoryFor35;
+(void)updateSearchHistoryFor38;

#endif

+(void)updateHistoryFor38;
+(void)updateHistoryVidFor58;
+ (void) updateFor512;
+ (void) updateFor522;
+ (void)updatePlayHistoryFor55;

+ (void) updateDownloadHistoryFor56;

+(void)updateLivingHistoryFor57;

+(void)updateLivingHistoryFor581;

+(void)updatePlayHistoryFor582;

+(void)updateLivingHistoryForIpad561;

+(void)updateHistoryVidForIpad561;

+(void)updatePlayHistoryFor59;

+(void)updateHistoryFor60;

+(void)updatePadHistoryFor58;

+(void)updateDownLoadFor61;

+ (void)updateDownLoadFor661;

+ (void)updateDownLoadFor67;

+(void)updatePlayHistoryFor615;

/**
    函数功能：添加不存在的列
    参数说明：
        tableName:要填加列的表明，如果表不存在，则更新失败
        missingColumnName:要添加的列名

 */
+ (BOOL)addMissingColumn:(NSString *)tableName missingColumnName:(NSString *)missingColumnName;

@end

