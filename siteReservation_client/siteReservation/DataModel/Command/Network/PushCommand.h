//
//  PushCommand.h
//  LetvIphoneClient
//
//  Created by aaaaaaaa aaaaaaaa on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MovieInfo.h"

@interface PushCommand : NSObject{
    
}

+ (Boolean)addOpt:(NSString *)urlString;

+ (Boolean)addTVUpdatePush:(NSString *)movieid;
+ (Boolean)delTVUpdatePush:(NSString *)movieid;
+ (Boolean)cleanTVUpdatePush;

+ (Boolean)openTVUpdatePush;
+ (Boolean)closeTVUpdatePush;


@end
