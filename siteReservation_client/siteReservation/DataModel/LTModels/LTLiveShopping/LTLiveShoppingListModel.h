//
//  LTLiveShoppingListModel.h
//  LeTVMobileDataModel
//
//  Created by Daemonson on 16/1/18.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol LTLiveShoppingModel
@end

@interface LTLiveShoppingListModel : JSONModel
@property (nonatomic, strong) NSArray<LTLiveShoppingModel, Optional> *blockContent;
@property (nonatomic, copy)   NSString<Optional> *startTime;    //是否轮询开关
@property (nonatomic, copy)   NSString<Optional> *endTime;      //购物车跳转商城URL
@property (nonatomic, copy)   NSString<Optional> *serverTime;   //服务器时间戳（从header里面取）
@end

@protocol LTShoppingPicListModel
@end

@interface LTShoppingPicListModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *pic_thumbnail1;  //商品小缩略图1
@property (nonatomic, copy) NSString<Optional> *pic_thumbnail2;  //商品小缩略图2
@property (nonatomic, copy) NSString<Optional> *pic_thumbnail3;  //商品小缩略图3
@property (nonatomic, copy) NSString<Optional> *pic_detail1;     //商品详情图片1
@property (nonatomic, copy) NSString<Optional> *pic_detail2;     //商品详情图片2
@property (nonatomic, copy) NSString<Optional> *pic_detail3;     //商品详情图片3
@property (nonatomic, copy) NSString<Optional> *pic_detail4;     //商品详情图片4
@property (nonatomic, copy) NSString<Optional> *pic_detail5;     //商品详情图片5
- (NSMutableArray *)getThumbnailImageUrls;
- (NSMutableArray *)getDetailImageUrls;
@end

@interface LTLiveShoppingModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *content;      //直播id
@property (nonatomic, copy) NSString<Optional> *title;        //商品标题
@property (nonatomic, copy) NSString<Optional> *subTitle;     //商品id
@property (nonatomic, copy) NSString<Optional> *shorDesc;     //商品简介
@property (nonatomic, copy) NSString<Optional> *remark;       //商品现价
@property (nonatomic, copy) NSString<Optional> *url;          //商城详情url
@property (nonatomic, copy) NSString<Optional> *pic1;         //商品图片（104×104）
@property (nonatomic, copy) NSString<Optional> *startTime;    //出现时间点（自然时间）
@property (nonatomic, copy) NSString<Optional> *endTime;      //隐藏时间点（自然时间)
@property (nonatomic, copy) NSString<Optional> *position;     //商品类型
/*边看边买二期新增加字段*/
@property (nonatomic, copy) NSString<Optional> *tagUrl;       //商品原价
@property (nonatomic, copy) NSString<Optional> *tag;          //商品好评度
@property (nonatomic, strong) LTShoppingPicListModel<Optional> *picList; //商品相关图片列表
/*边看边买三期新增加字段*/
@property (nonatomic, strong) NSDictionary<Optional> *extendJson;       //可配置按钮文案和跳转URL在里面
@end

@interface LTProductAttentionModel : JSONModel
@property (nonatomic, copy) NSString<Optional> *message;      //接口返回信息
@property (nonatomic, copy) NSString<Optional> *status;                 //接口返回状态
@property (nonatomic, strong) NSDictionary<Optional> *result; //商品关注人数
- (NSString *)getProductAttentionCont;
@end
