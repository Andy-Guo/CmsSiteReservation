//
//  LTDanmakuModel.h
//  LeTVMobileDataModel
//
//  Created by wangduan on 15/5/22.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

static NSString *LT_DANMAKU_REDPACKAGE_TAG = @"redpaper";    // 红包弹幕
static NSString *LT_DANMAKU_COMMENTARY_TAG = @"commentary";    // 官方解说弹幕

@protocol LTDanmakuModelInterface <NSObject>

- (NSString *)textValue;
- (NSString *)nickname;
- (NSString *)uidValue;
- (NSString *)headUrl;
- (NSString *)typeValue;
- (NSString *)fontValue;
- (UIColor *)colorValue;
- (NSInteger)role;
- (NSInteger)positionValue;
- (BOOL)isVip;
- (BOOL)isSpecial; // 是否特殊消息（明星、主持人、红包、官方解说）
- (BOOL)isSpecialUser;
- (NSInteger)voteCount;

- (CGFloat)showTime;
- (CGFloat)bgOpacity;
- (UIColor *)bgColor;
- (NSString *)linkText;
- (NSString *)linkUrl;

@end

@interface LTExtendModel : JSONModel
@property (nonatomic, strong) NSString <Optional> *role;
@property (nonatomic, strong) NSString <Optional> *nickname;
@property (nonatomic, strong) NSString <Optional> *picture;

@end

@interface LTDanmakuModel : JSONModel<LTDanmakuModelInterface>

@property (nonatomic, strong) NSString <Optional>       *danmakuId;
@property (nonatomic, strong) NSString <Optional>       *uid;
@property (nonatomic, strong) NSString <Optional>       *start;
@property (nonatomic, strong) NSString <Optional>       *txt;
@property (nonatomic, strong) NSString <Optional>       *zanNum;    // 点赞数
@property (nonatomic, strong) NSString <Optional>       *color; //"FFFFFF"
@property (nonatomic, strong) NSString <Optional>       *font;  //字体大小［s(small):小号m(medium):中号 l(large):大号］默认值：m

@property (nonatomic, strong) NSString <Optional>       *x;
@property (nonatomic, strong) NSString <Optional>       *y;
@property (nonatomic, strong) NSString <Optional>       *position;//"4"位置，
@property (nonatomic, strong) NSString <Optional>       *addtime;
@property (nonatomic, strong) NSString <Optional>       *vip;
@property (nonatomic, strong) NSString <Optional>       *type;
@property (nonatomic, strong) LTExtendModel <Optional>  *extend;
@property (nonatomic, strong) NSString <Optional>       *isSynComment;


#ifdef LT_IPAD_CLIENT
+ (NSString *)getUidByModel:(LTDanmakuModel *)model;
+ (NSInteger)getVoteCountByModel:(LTDanmakuModel *)model;
+ (BOOL)getVipByModel:(LTDanmakuModel *)model;
#endif

@end

@protocol LTDanmakuModel;
@interface LTDanmakuData : JSONModel
@property (nonatomic, strong) NSMutableArray <LTDanmakuModel,Optional> * list;
@property (nonatomic, strong) NSMutableArray <LTDanmakuModel,Optional> * user;

@end
