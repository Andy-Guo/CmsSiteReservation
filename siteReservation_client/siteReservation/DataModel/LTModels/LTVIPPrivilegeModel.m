//
//  LTVIPPrivilegeModel.m
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 13-11-8.
//
//

#import "LTVIPPrivilegeModel.h"

@implementation LTVIPFocusInfo

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"Url":@"url"}];
}

@end

@implementation LTVIPSupperInfo
#ifdef LT_IPAD_CLIENT
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"content":@"contents"}];
}

#else


//+ (JSONKeyMapper *)keyMapper {
//    return [[JSONKeyMapper alloc] initWithDictionary:@{@"content":@"contents"}];
//}
#endif
@end

@implementation LTVIPPrivilegeModel

@end

@implementation LTprivilegeList 

@end


