//
//  PayInfo.h
//  LetvIphoneClient
//
//  Created by 鹏飞 季 on 12-8-31.
//  Copyright (c) 2012年 乐视网. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _payStatus
{
    payStatus_UnKnown = 0,
    payStatus_Succ,
    payStatus_Fail
}ProductPayStatus;

@interface PayInfo : NSObject
{
@private
    NSString *_username;//用户名
    NSString *_price;//价格
    NSString *_isVip;//是否Vip， 0：否 1：是
    NSString *_productName;//商品名
    NSString *_orderID;//订单号
    NSString *_payType;//支付类型 2.8.1版本只有乐点一种类型
    NSString *_deadTime;//截止时间
    NSString *_movieID;  //影片ID
    NSString *_payfrom;  //影片来源
    NSString *_pType;  //1:代表单片 2：非单片
    NSString *_pid; //包月：2 包季：3 包年：5
}
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *isVip;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *orderID;
@property(nonatomic,copy) NSString *payType;
@property(nonatomic,copy) NSString *deadTime;
@property(nonatomic,assign) ProductPayStatus payStatus;
@property(nonatomic,copy) NSString *movieID;
@property(nonatomic,copy) NSString *payfrom;
@property(nonatomic,copy) NSString *pType;
@property(nonatomic,copy) NSString *pid;
@end
