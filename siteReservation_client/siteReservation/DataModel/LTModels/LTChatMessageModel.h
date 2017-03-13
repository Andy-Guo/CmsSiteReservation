//
//  LTChatMessageModel.h
//  LeTVMobileDataModel
//
//  Created by wangduan on 15/2/28.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
#import <LetvMobileDataModel/LTDanmakuModel.h>

typedef NS_ENUM(NSInteger, DanmakuShowType) {
    LTDanmuShowType_Static_Top          = 1,        //顶部静止类型
    LTDanmuShowType_Dynamic             = 2,        //运动类型
    LTDanmuShowType_Static_Bottom       = 3,        //底部静止类型
    LTDanmuShowType_Random              = 4,        //随机
    LTDanmuShowType_Commentary_Top      = 5,        //解说置顶
    LTDanmuShowType_Commentary_Bottom   = 6         //解说置底
};

/*
 * 聊天室Info
 */
@interface LTChatRoomInfoModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* startTime;                 //开始时间
@property (nonatomic, strong) NSString<Optional>* roomId;                    //聊天室id
@property (nonatomic, strong) NSString<Optional>* islive;                    //true false
@property (nonatomic, strong) NSString<Optional>* endTime;                   //结束时间

@end

/*
 * 聊天消息userModel
 */
@interface LTChatMessageUserModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* icon;                     //用户头像url
@property (nonatomic, strong) NSString<Optional>* uid;                      //用户uid
@property (nonatomic, strong) NSString<Optional>* nickname;                 //用户昵称
//弹幕新家字段。
@property (nonatomic, strong) NSString<Optional>* vip;                      //用户vip信息
@property (nonatomic, strong) NSString<Optional>* role;                     //用户角色（2:运营、1:明星）

@end

/*
 * 聊天消息MessageModel
 */
@interface LTChatMessageModel : JSONModel<LTDanmakuModelInterface>

@property (nonatomic, strong) NSString<Optional>* forhost;                 //true false
@property (nonatomic, strong) NSString<Optional>* addtime;                 //消息时间戳1423729023
@property (nonatomic, strong) NSString<Optional>* message;                 //消息内容
@property (nonatomic, strong) LTChatMessageUserModel<Optional>* user;      //发送消息的用户
//弹幕新家字段。
@property (nonatomic, strong) NSString<Optional>* color;                    //内容颜色值，例如：00FCFF
@property (nonatomic, strong) NSString<Optional>* font;                     //字体大小［s:小号 m:中号 l:大号］默认值：m
@property (nonatomic, strong) NSString<Optional>* position;                 //显示的位置 ［1:顶部 2:中间 3:底部 4:随机］默认值：4
@property (nonatomic, strong) NSString<Optional>* from;                     //来源［1:Web 2:Mobile 3:Pad 4:TV 5:PC桌面］，默认值：1
@property (nonatomic, strong) NSString<Optional>* type;                     //1:普通消息 2:pc端带表情的消息 3:红包 9:聊天室公告

// 以下几个目前直播解说弹幕才用到
@property (nonatomic, strong) NSString<Optional>* showtime;                 //显示时间
@property (nonatomic, strong) NSString<Optional>* bgcolor;                  //背景颜色
@property (nonatomic, strong) NSString<Optional>* bgopacity;                //背景透明度
@property (nonatomic, strong) NSString<Optional>* link_txt;                 //链接部分文字
@property (nonatomic, strong) NSString<Optional>* link_url;                 //链接Url
@property (nonatomic, strong) NSDictionary<Optional>* extend;   //扩展字段
//非服务器返回字段。客户端添加字段
@property (nonatomic, strong) NSString<Optional>* isNeedShowTime;                 //是否需要显示时间。1是，0不是
//非数据库返回字段。
@property (nonatomic, copy) NSNumber<Optional>* cellHeight;

@end

/*
 * 聊天室post
 */
@interface LTChatRoomPostModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* roomId;                  //聊天室id
@property (nonatomic, strong) NSString<Optional>* addtime;                 //公告时间戳1423729023
@property (nonatomic, strong) NSString<Optional>* message;                 //公告内容

@end

@protocol LTChatServerModel;
@interface LTChatServerModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* token;
@property (nonatomic, strong) NSString<Optional>* server;                 //serverhttp://10.154.252.32:8010

@end

/*
 *历史消息ChatHistoryModel
 */
@protocol LTChatMessageModel;
@interface LTChatHistoryModel : JSONModel

@property (nonatomic, strong) LTChatServerModel<Optional>* server;
@property (nonatomic, strong) LTChatRoomInfoModel<Optional>* roomInfo;     //聊天室Info
@property (nonatomic, strong) LTChatRoomPostModel<Optional>* post;         //公告
@property (nonatomic, strong) NSArray<LTChatMessageModel, Optional>* list; //聊天消息列表
@end

#pragma mark - LTChatMessageModelPB
@protocol LTChatMessageModelPBOCModule <LTProtocolBaseModule>
@property(nonatomic, readwrite, strong)   NSString   *forhost;                  //true false
@property(nonatomic, readwrite, strong)   NSString   *addtime;                  //消息时间戳1423729023
@property(nonatomic, readwrite, strong)   NSString   *message;                  //消息内容
@property(nonatomic, readwrite, strong)   LTChatMessageUserModel   *user;   //发送消息的用户
@property(nonatomic, readwrite, strong)   NSString   *color;                    //内容颜色值，例如：00FCFF
@property(nonatomic, readwrite, strong)   NSString   *font;                     //字体大小［s:小号 m:中号 l:大号］默认值：m
@property(nonatomic, readwrite, strong)   NSString   *position;                 //显示的位置 ［1:顶部 2:中间 3:底部 4:随机］默认值：4
@property(nonatomic, readwrite, strong)   NSString   *from;                     //来源［1:Web 2:Mobile 3:Pad 4:TV 5:PC桌面］，默认值：1
@property(nonatomic, readwrite, strong)   NSString   *type;                     //1:普通消息 2:pc端带表情的消息 3:红包 9:聊天室公告
@property(nonatomic, readwrite, strong)   NSString   *showtime;                 //显示时间
@property(nonatomic, readwrite, strong)   NSString   *bgcolor;                  //背景颜色
@property(nonatomic, readwrite, strong)   NSString   *bgopacity;                //背景透明度
@property(nonatomic, readwrite, strong)   NSString   *link_txt;                 //链接部分文字
@property(nonatomic, readwrite, strong)   NSString   *link_url;                 //链接Url
@end

@interface LTChatMessageModelPBOCModule : LTProtocolBaseModule<LTChatMessageModelPBOCModule>
@end
