//
//  LTJSRequestElem.h
//  LetvIphoneClient
//
//  Created by bob on 14-7-31.
//
//

#import <Foundation/Foundation.h>

@interface LTJSRequestElem : NSObject

@property (nonatomic, strong) NSString *func;
@property (nonatomic, strong) NSString *callbackID;
@property (nonatomic, strong) NSString *callbackFunc;
@property (nonatomic, strong) NSDictionary *argvDict;

@end
