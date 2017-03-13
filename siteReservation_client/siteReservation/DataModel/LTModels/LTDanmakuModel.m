//
//  LTDanmakuModel.m
//  LeTVMobileDataModel
//
//  Created by wangduan on 15/5/22.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTDanmakuModel.h"
@implementation LTExtendModel

@end

@implementation LTDanmakuModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"_id"  : @"danmakuId",
                                                       }];
}

- (NSString *)color {
    if ([_color isEqualToString:@"000000"]) {
        return @"FFFFFF";
    }
    return _color;
}

// 假数据
//- (NSString *)zanNum {
//    int rand = arc4random() % 10;
//    if (rand == 0) {
//        return _zanNum;
//    }
//    
//    rand = arc4random() % 1000;
//    return [NSString stringWithFormat:@"%d", rand];
//}

#pragma mark - LTDanmakuModelInterface

- (NSString *)textValue {
    return self.txt;
}

- (NSString *)nickname {
    return self.extend.nickname;
}

- (NSString *)uidValue {
    return self.uid;
}

- (NSString *)headUrl {
    return self.extend.picture;
}

- (NSString *)typeValue {
    return self.type;
}

- (NSString *)fontValue {
    return self.font;
}

- (UIColor *)colorValue {
    
    if ([NSString isBlankString:self.color]) {
        return kColorWhite;
    }
    if (self.color.length != 6 && self.color.length != 8) {
        return kColorWhite;
    }
    
    return [UIColor colorWithHexString:self.color defaultColor:kColorWhite];
}

- (NSInteger)role {
    return self.extend.role.integerValue;
}

- (NSInteger)positionValue {
    if (self.position) {
        return self.position.integerValue;
    }
    return 0;
}

- (NSInteger)voteCount {
    if (self.zanNum) {
        return self.zanNum.integerValue;
    }
    return 0;
}

- (BOOL)isVip {
    return self.vip.boolValue;
}

- (BOOL)isSpecial {
    return [self.type isEqualToString:LT_DANMAKU_REDPACKAGE_TAG] || self.role != 0;
}

- (BOOL)isSpecialUser {
    return NO;
}

- (CGFloat)showTime {
    return 4.f;
}

- (CGFloat)bgOpacity {
    return 1.f;
}

- (UIColor *)bgColor {
    return [UIColor clearColor];
}

- (NSString *)linkText {
    return @"";
}

- (NSString *)linkUrl {
    return @"";
}

#ifdef LT_IPAD_CLIENT
+ (NSString *)getUidByModel:(LTDanmakuModel *)model {
    return model ? model.uid : nil;
}

+ (NSInteger)getVoteCountByModel:(LTDanmakuModel *)model {
    
    if (model && model.zanNum) {
        return model.zanNum.integerValue;
    }
    
    return 0;
}

+ (BOOL)getVipByModel:(LTDanmakuModel *)model {
    return model ? model.vip.boolValue : NO;
}
#endif

@end

@implementation LTDanmakuData

@end

