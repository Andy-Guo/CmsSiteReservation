//
//  LTChatMessageModel.m
//  LeTVMobileDataModel
//
//  Created by wangduan on 15/2/28.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTChatMessageModel.h"

@implementation LTChatRoomInfoModel

@end

@implementation LTChatMessageUserModel

@end

@implementation LTChatMessageModel

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithFormat:@"message: %@, nickname: %@, type: %@, position: %@", self.textValue, self.nickname, self.type, @(self.positionValue)];
    if (self.role != 0) {
        [desc appendFormat:@", role: %@", @(self.role)];
    }
    if (self.linkUrl.length > 0) {
        [desc appendFormat:@", linkUrl: %@", self.linkUrl];
    }
    return desc;
}

- (NSString *)color {
    if ([_color isEqualToString:@"000000"]) {
        return @"FFFFFF";
    }
    return _color;
}

#pragma mark - LTDanmakuModelInterface

- (NSString *)textValue {
    return self.message;
}

- (NSString *)nickname {
    return self.user.nickname;
}

- (NSString *)uidValue {
    return self.user.uid;
}

- (NSString *)headUrl {
    return self.user.icon;
}

- (NSString *)typeValue {
    // 链接和红包目前不同时支持，出现链接的时候，不视为红包类型
    if ([self.type isEqualToString:@"3"] && self.linkText.length == 0) {
        return LT_DANMAKU_REDPACKAGE_TAG;
    }
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
    return self.user.role.integerValue;
}

- (NSInteger)positionValue {
    if (self.position) {
        return self.position.integerValue;
    }
    return 0;
}

- (NSInteger)voteCount {
    return 0;
}

- (BOOL)isVip {
    return self.user.vip.boolValue;
}

- (BOOL)isSpecial {
    BOOL isCommentary = self.positionValue == LTDanmuShowType_Commentary_Top || self.positionValue == LTDanmuShowType_Commentary_Bottom;
    BOOL special = self.role == 1 || self.role == 2 || [self.typeValue isEqualToString:LT_DANMAKU_REDPACKAGE_TAG] || isCommentary;
    return special;
}

- (BOOL)isSpecialUser {
    return self.role == 1 || self.role == 2  || self.isVip;
}

- (CGFloat)showTime {
    return self.showtime.integerValue;
}

- (CGFloat)bgOpacity {
    CGFloat opacity = self.bgopacity.doubleValue;
    if (opacity > 100) {
        opacity = 100.f;
    } else if (opacity < 0) {
        opacity = 0.f;
    }
    return opacity / 100.f;
}

- (UIColor *)bgColor {
    UIColor *defaultColor = [UIColor blackColor];
    return ![NSString isBlankString:self.bgcolor] ? [UIColor colorWithHexString:self.bgcolor defaultColor:defaultColor] : defaultColor;
}

- (NSString *)linkText {
    return self.link_txt;
}

- (NSString *)linkUrl {
    return self.link_url;
}

@end

@implementation LTChatRoomPostModel

@end

@implementation LTChatServerModel

@end

@implementation LTChatHistoryModel

@end
@implementation LTChatMessageModelPBOCModule

@end