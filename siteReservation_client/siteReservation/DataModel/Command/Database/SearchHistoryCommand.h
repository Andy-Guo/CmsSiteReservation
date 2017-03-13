//
//  SearchHistoryCommand.h
//  LetvIpadClient
//
//  Created by hao chen on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/SqlDBHelper.h>


@interface SearchHistoryCommand : NSObject{
	NSInteger _ID ;
	NSString *_searchWord;
}

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *searchWord;

+(NSArray*) searchAll;
+(BOOL) insertWithSearchWord:(NSString*)_searchWord;
+(BOOL) deleteAll;
+(BOOL) deleteSearchWord:(NSString *)_searchWord;
+(SearchHistoryCommand *)wrappResultSets:(id<PLResultSet>)rs;
+(NSInteger) countForSearchWord:(NSString*)searchWord;
-(id)initWithID:(int)_id SearchWord:(NSString*)searchWord;
@end
