//
//  LTPromotionModel.h
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 13-11-6.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTPromotionSubModel <NSObject>

@end

@interface LTPromotionModel : JSONModel

@property (nonatomic, strong) NSArray<LTPromotionSubModel, Optional> *promotionData; //产品推广列表
@property (nonatomic, strong) NSString<Optional> *spreadStatus; //开关状态(1-开启,2-关闭)

@end

@interface LTPromotionSubModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *locationId; //展示位置id(唯一标识)(1-搜索结果页,2-半屏播放页-分享底部,3-半屏播放页-相关底部,4-半屏播放页-简介底部,5-半屏播放页-选集底部,6-全屏播放器-1080p,7-全屏播放器-超级电视按钮,8-设置页)
@property (nonatomic, strong) NSString<Optional> *type; //数据类型(1-图文,2-文字)
@property (nonatomic, strong) NSString<Optional> *pic; //图片
@property (nonatomic, strong) NSString<Optional> *word; //文字
@property (nonatomic, strong) NSString<Optional> *url; //链接地址

@end
