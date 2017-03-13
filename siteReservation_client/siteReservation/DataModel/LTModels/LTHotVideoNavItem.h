//
//  LTHotVideoNavItem.h
//  LeTVMobileDataModel
//
//  Created by zhangyongtao on 15/9/7.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTHotVideoNavItem : NSObject

@property (nonatomic, copy) NSString * channel_name;
@property (nonatomic, assign)NSInteger page_id;
@property (nonatomic, assign)NSInteger sort;
@property (nonatomic, assign)NSInteger display;

+ (NSArray *)praseWithDict:(NSDictionary *)dict;


@end
