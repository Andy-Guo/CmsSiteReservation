//
//  BootImageCommand.h
//  LetvIpadClient
//
//  Created by 春艳 赵 on 12-5-24.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlDBHelper.h"

@interface BootImageCommand : NSObject
{
	NSInteger _id;
    NSString *_name;
    NSDate *_starttime;
    NSDate *_endtime;
    LTBootImagePriority _priority;
    NSString *_type;
    NSString *_movieID;
}

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDate *starttime;
@property (nonatomic, strong) NSDate *endtime;
@property (nonatomic, assign) LTBootImagePriority priority;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *movieID;


+(BOOL) insertWithName:(NSString *)name
          andStartTime:(NSDate *)starttime
            andEndTime:(NSDate *)endtime
           andPriority:(LTBootImagePriority)priority
               andType:(NSString *)type
                 andID:(NSString *)movieID;
+(NSArray*)searchAll;
+(NSArray*)searchNotOutOfDateByPriority:(LTBootImagePriority)priority;
+(NSArray*) searchNotOutOfDateExceptPriority:(LTBootImagePriority)priority;
+(id)searchByName:(NSString *)picname;
+(BOOL)deleteByName:(NSString *)picname;
-(void)logDebug;
+(BOOL)deleteByPriority:(LTBootImagePriority)priority;

@end


