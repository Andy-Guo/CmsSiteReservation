//
//  MoviePayDetail.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-22.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface MoviePayDetail : JSONModel

@property (strong, nonatomic) NSString<Optional> *__payDate;        // string	服务期限
@property (strong, nonatomic) NSString<Optional> *__singlePrice;    // string	单片价格
@property (strong, nonatomic) NSString<Optional> *__allowMonth;     // string	0:点播;1:点播且包月;2:包月
@property (strong, nonatomic) NSString<Optional> *tryLookTime;      // string   试看时长，单位是秒。如果是0的话，则表示不能试看

// 对应属性（__propertyName）的类型转换
- (VIPAllowMonth)allowMonth;
- (float)singlePrice;
- (NSInteger)payDate;

// iOS平台不支持单点，当allowmonth支持包月时，返回TRUE
- (BOOL)isPayForMonth;
// 单点
- (BOOL)isPayForSingle;

@end
