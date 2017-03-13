//
//  SearchHistoryCommand.m
//  LetvIpadClient
//
//  Created by hao chen on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchHistoryCommand.h"

@implementation SearchHistoryCommand

@synthesize ID = _ID;
@synthesize searchWord = _searchWord;

+(NSArray*)searchAll{
	PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	
	rs  = [db executeQuery:@"select * from searchHistory Order By  ID Desc"];
	
	NSMutableArray *dbArray = [[NSMutableArray alloc] init];
	
	while ([rs next])
	{
		[dbArray addObject:[SearchHistoryCommand wrappResultSets:rs]];
	}
	[rs close];
	return dbArray;
}

+(BOOL) insertWithSearchWord:(NSString*)_searchWord
{
    if([SearchHistoryCommand countForSearchWord:_searchWord] > 0)
	{
		[SearchHistoryCommand deleteSearchWord:_searchWord];
	}
    
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    NSArray *arrayAll = [SearchHistoryCommand searchAll];
    NSInteger nCount = [arrayAll count];
    for (int i=9; i<nCount; i++) {
        SearchHistoryCommand *resultInfo = arrayAll[i];
        [SearchHistoryCommand deleteSearchWord:resultInfo.searchWord];
    }
	BOOL bResult = [db executeUpdate:@"INSERT INTO searchHistory(searchWord) VALUES (?)",_searchWord];
	return bResult;
}

+(BOOL) deleteAll
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
    BOOL bResult = [db executeUpdate:@"DELETE FROM searchHistory"];
    return bResult;
}

+(BOOL) deleteSearchWord:(NSString *)_searchWord
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	BOOL bResult = [db executeUpdate: @"DELETE FROM searchHistory WHERE searchWord=?",_searchWord];
	return bResult;
}

+(SearchHistoryCommand *)wrappResultSets:(id<PLResultSet>)rs
{
    int _ID = [[rs objectForColumn:@"ID"] intValue];
	NSString *_searchWord = [NSString safeString:[rs objectForColumn:@"searchWord"]];
	SearchHistoryCommand *com = [[SearchHistoryCommand alloc] initWithID:_ID SearchWord:_searchWord];
	return com;
}

+(NSInteger) countForSearchWord:(NSString*)searchWord
{
    PLSqliteDatabase *db = [SqlDBHelper setUp];
	id<PLResultSet> rs;
	rs = [db executeQuery:@"select count(*) as count from searchHistory where searchWord = ? ",searchWord];
	if([rs next])
	{
		NSString *_count = [rs objectForColumn:@"count"];
		return [_count intValue];
	}
	return 0;
}

-(id)initWithID:(int)_id SearchWord:(NSString*)searchWord
{
    if(self = [super init])
	{
		self.ID = _id;
		self.searchWord = searchWord;
	}
	return self;
}


@end
