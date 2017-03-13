//
//  LTOrderInfo.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-8-29.
//
//

#import <Foundation/Foundation.h>

@interface LTOrderInfo : NSObject{
    
@private
    
    NSString *_orderId;         // 订单号
    NSString *_productName;     // 商品名称 乐视**服务 or 影片名称
    CGFloat _singlePrice;       // 单价，元为单位
    
    NSDate  *_dateExpired;      // 过期时间 date
    NSInteger _periodOfValidity;// 有效期 单位：天
    BOOL _isExpired;            // 是否已过期
    
    BOOL _isPaySuccess;         // 是否支付成功
    
    NSString *_ptype;   // 1 ,2 (1代表是单片 2非单片);
    NSString *_pid;     // ptye为1时 pid是当前影视剧的专辑ID; ptye2时 pid 是当前包月(2) 包季(3) 包年(5)的信息
    
    // 支付成功需要直接播放的传以下几个参数
    NSString *_movieTitle;  // 影片title
    NSString *_movieId;     // 影片ID
    NSString *_movieType;   // 影片type
    
    NSString *_productID; //IAP,产品ID
    
}

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, assign) CGFloat singlePrice;
@property (nonatomic, strong) NSDate *dateExpired;
@property (nonatomic, assign) NSInteger periodOfValidity;
@property (nonatomic, assign) BOOL isExpired; 

@property (nonatomic, assign) BOOL isPaySuccess;

@property (nonatomic, copy) NSString *ptype;
@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *movieType;
@property (nonatomic, copy) NSString *movieTitle;
@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *productID;

@end
