//
//  UserInfo.m
//  LetvIphoneClient
//
//  Created by 鹏飞 季 on 12-8-28.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import "UserInfo.h"


@implementation  VipUserInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"canceltime" : @"__canceltime",
            @"seniorcanceltime" : @"__seniorcanceltime",
            }];
}

- (NSString *)canceltime
{
    return [self dateWithTime:self.__canceltime];
}

- (BOOL)isSeniorVip {
    BOOL isSeniorVip = [self.vipType integerValue] == 2;
    
    return isSeniorVip;
}

- (NSString *)seniorcanceltime
{
    return [self dateWithTime:self.__seniorcanceltime];
}

- (NSString *)dateWithTime:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval seconds = [time doubleValue] / 1000;
    return (seconds > 0) ? [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]] : @"";
}


// 会员过期时间
- (NSDate*) expireDate {
    NSString *cancelTime = self.__canceltime;
    if ([self isSeniorVip]) {
        cancelTime = self.__seniorcanceltime;
    }
    NSTimeInterval cantime=[cancelTime doubleValue]/1000;
    NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:cantime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    expireDate = [formatter stringFromDate:expireDate];
    return expireDate;
}

// 会员剩余天数
- (float)vipLastTime {
    float suplusday;
    NSString *cancelTime = self.__canceltime;
    if ([self isSeniorVip]) {
        cancelTime = self.__seniorcanceltime;
    }
    NSTimeInterval cantime=[cancelTime doubleValue]/1000;
    
    // 会员时长
    NSString *lastTimeStr = self.lastdays;
    NSTimeInterval lastTime=[lastTimeStr doubleValue];
    // 过期时间
    NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:cantime];
    NSInteger toExpireSecondsToday = expireDate.hour*3600 + expireDate.minute*60 + expireDate.seconds;
    NSInteger FromExpireSecondsToday = 3600*24 - toExpireSecondsToday;
    
    suplusday=(lastTime+FromExpireSecondsToday)/(3600*24);
    return suplusday;
}


@end


@implementation UserInfo

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
            @"isvip" : @"__isvip",
            @"level" : @"level_id",
            }];
}

//- (void)setPictureWithNSString:(NSString *)picture
//{
//    NSArray *picturlArray = [picture componentsSeparatedByString:@","];
//    if ([picturlArray count] > 0) {
//        _picture = picturlArray[0];
//    }
//}

- (void)setVipinfoWithNSArray:(NSArray *)vipinfo
{
    if (![NSObject empty:vipinfo]&& [vipinfo count]>0) {
        _vipinfo = [[VipUserInfo alloc] initWithDictionary:vipinfo[0] error:nil];

    }
}

- (BOOL)isvip
{
    return ([self.__isvip integerValue] == 1) ? TRUE : FALSE;
    
}

- (NSString*) getVIPLevelImageName{
    
    NSString *imageName = @"";
    if ([SettingManager isHK]) {
        if ([SettingManager isVipUser]) {
            imageName = @"viphk_valid";
        }else if ([self isExpire]) {
            imageName = @"viphk_expired";
        }
        return imageName;
    }
    
    NSUInteger levelInteger = [_level_id integerValue];
    if (levelInteger >= 0 && levelInteger <= 10) {
        if ([self isExpire]) {
            imageName = [NSString stringWithFormat:@"vip_expired_level_%d", levelInteger];
        }
        else {
            imageName = [NSString stringWithFormat:@"vip_valid_level_%d", levelInteger];
        }
        
        return imageName;
    }
    else {
        return nil;
    }
}
- (BOOL) isExpire {
    BOOL isExpire = NO;
    if (![self isvip]) {
        if ([self.vipinfo vipLastTime] < 0) {
            isExpire = YES;
        }
    }
    return isExpire;
}

@end


@implementation UserInfoWrapper

@end

