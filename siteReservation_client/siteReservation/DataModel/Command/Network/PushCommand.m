//
//  PushCommand.m
//  LetvIphoneClient
//
//  Created by aaaaaaaa aaaaaaaa on 11-12-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PushCommand.h"
//#import "LTRequestURLManager.h"

//#import "NetworkReachability.h"
//#import "SettingManager.h"
//#import "DeviceManager.h"
#import "LTRequestURLManager.h"

@implementation PushCommand

+ (Boolean)addOpt:(NSString *)urlString{
    
    if (![NetworkReachability connectedToNetwork]){
        return NO;
    }
    
    NSString *sUrl = urlString;
    
//    NSLog(@"push url: %@", sUrl);

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:sUrl]];
    if (nil == urlRequest) {
        return NO;
    }
    
    [urlRequest setHTTPMethod:@"GET"];
    NSURLResponse *response;
	[NSURLConnection sendSynchronousRequest: urlRequest
                          returningResponse: &response
                                      error: nil];
    
    NSLog(@"PushCommand, response string = %ld\n",(long)[(NSHTTPURLResponse *)response statusCode]);
    
    if (200 == [(NSHTTPURLResponse *)response statusCode]) {
        return YES;
    }
    
    return NO;
    
}

+ (Boolean)addTVUpdatePush:(NSString *)movieid{
    
    NSArray *arrayParamValues = @[[DeviceManager getDeviceUUID],
                                 movieid];
    
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Push_Add
                                                       andDynamicValues:arrayParamValues];
    return [self addOpt:urlString];
}


+ (Boolean)delTVUpdatePush:(NSString *)movieid{
    
    NSArray *arrayParamValues = @[[DeviceManager getDeviceUUID],
                                 movieid];
    
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Push_Del
                                                       andDynamicValues:arrayParamValues];
    
    return [self addOpt:urlString];
    
}

+ (Boolean)cleanTVUpdatePush{
    
    NSArray *arrayParamValues = @[[DeviceManager getDeviceUUID]];
    
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Push_Clean
                                                       andDynamicValues:arrayParamValues];
    
    return [self addOpt:urlString];
    
}

+ (Boolean)openTVUpdatePush{
    
    NSArray *arrayParamValues = @[[DeviceManager getDeviceUUID]];
    
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Push_Open
                                                       andDynamicValues:arrayParamValues];
    
    return [self addOpt:urlString];
    
}

+ (Boolean)closeTVUpdatePush{
    
    NSArray *arrayParamValues = @[[DeviceManager getDeviceUUID]];
    
    NSString *urlString = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Push_Close
                                                       andDynamicValues:arrayParamValues];
    
    return [self addOpt:urlString];
    
}

@end
