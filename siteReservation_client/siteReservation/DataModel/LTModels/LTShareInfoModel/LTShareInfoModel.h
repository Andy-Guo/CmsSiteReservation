//
//  LTShareInfoModel.h
//  LeTVMobileDataModel
//
//  Created by fanpian on 16/5/31.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LetvMobileOpenSource/JSONModel.h>

@interface LTShareInfoModel : JSONModel
//纯文本类消息
@property(strong,nonatomic)NSString <Optional> * text;
//card 形式的需要用到的
@property(strong,nonatomic)NSString <Optional> * title;
@property(strong,nonatomic)NSString <Optional> * desc;
@property(strong,nonatomic)NSString <Optional> * url;
@property(strong,nonatomic)NSString <Optional> * thumbImageUrl;
@property(strong,nonatomic)NSData <Optional>  * thumbImageData;
@property(strong,nonatomic)NSData <Optional>  * imageData;
@property(strong,nonatomic)NSString <Optional> * imageUlr;
//sina微博
@property(strong,nonatomic)NSString <Optional> * weiboText;
//webview
@property(strong,nonatomic)NSString <Optional> * webUrl;
@property(strong,nonatomic)NSString <Optional> * typeStr;
// facebook分享使用
//直播
@property(strong,nonatomic)NSString <Optional> * channelID;
@property(strong,nonatomic)NSString <Optional> * channelType;
// 点播
@property(strong,nonatomic)NSString <Optional> * actionType;
@property(strong,nonatomic)NSString <Optional> * vid;
@property(strong,nonatomic)NSString <Optional> * pid;
@property(strong,nonatomic)NSString <Optional> * cid;
@property(strong,nonatomic)NSString <Optional> * isPanorama;
//截图分享
@property(strong,nonatomic)UIImage <Optional> * captureImage;
@end
