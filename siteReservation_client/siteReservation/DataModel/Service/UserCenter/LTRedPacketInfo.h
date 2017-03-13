//
//  LTRedPacketInfo.h
//  LeTVMobileDataModel
//
//  Created by Qinxl on 15/11/9.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@interface LTRedPacketInfo : JSONModel

@end



@interface StaringUpRedPacketInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *mobilePic;    //  红包弹窗图片
@property (nonatomic, strong) NSString<Optional> *title;     //	红包弹窗文案标题
@property (nonatomic, strong) NSString<Optional> *shorDesc;     //	红包弹窗文案内容
@property (nonatomic, strong) NSString<Optional> *url;          //  红包分享地址
@property (nonatomic, strong) NSString<Optional> *skipUrl;      //  分享成功后的查看url
@property (nonatomic, strong) NSString<Optional> *activeID;     //红包活动id
@property (nonatomic, strong) NSString<Optional> *isVip;
@property (nonatomic, strong) NSString<Optional> *limitNum;     //显示次数
@property (nonatomic, strong) NSString<Optional> *leftButton;   //弹窗左按钮文案
@property (nonatomic, strong) NSString<Optional> *rightButton;  //弹窗右按钮文案
@property (nonatomic, strong) NSString<Optional> *shareTitle;   //分享标题
@property (nonatomic, strong) NSString<Optional> *shareDesc;    //分享描述
@property (nonatomic, strong) NSString<Optional> *sharePic;     //分享图片

- (BOOL) isNeedShowSkipWebPage;

@end


@interface StaringUpRedPacketModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *code;    //  是否有红包:1-有红包，0-无红包
@property (nonatomic, strong) StaringUpRedPacketInfo<Optional> *package;    //  红包弹窗图片


- (BOOL)isNeedShowRedPacketTip;
@end

@interface PaySuccessRedPacketInfo : JSONModel
@property (nonatomic, strong) NSString<Optional> *content;      //  内容
@property (nonatomic, strong) NSString<Optional> *imgUrl;       //	图片
@property (nonatomic, strong) NSString<Optional> *shareUrl;     //	分享地址
@property (nonatomic, strong) NSString<Optional> *title;        //  标题
@property (nonatomic, strong) NSString<Optional> *channelId;    //  渠道id

@end
 
/* 支付成功红包的模型 */

@interface PaySuccessRedPacket : JSONModel
@property (nonatomic, strong) NSString<Optional> *code;    //  是否有红包:1-有红包，0-无红包
@property (nonatomic, strong) PaySuccessRedPacketInfo<Optional> *package;    //  红包内容


- (BOOL)isNeedShowRedPacketTip;
@end


