//
//  LTVipProductPreModel.h
//  LeTVMobileDataModel
//
//  Created by Speed on 15/7/17.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>


@protocol  LTVipProductInfoPreModel @end
@interface LTVipProductInfoPreModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*subscript;
@property (nonatomic, copy) NSString <Optional>*subscriptText;
@property (nonatomic, copy) NSString <Optional>*sort;
@property (nonatomic, copy) NSString <Optional>*days;
@property (nonatomic, copy) NSString <Optional>*productid;
@property (nonatomic, copy) NSString <Optional>*displayPrice;//带货币符号用于显示支付总价格
@property (nonatomic, copy) NSString <Optional>*subPrice;//浮点类型，用于计算每月价格
@property (nonatomic, copy) NSString <Optional>*preSortValue;


@end

@interface LTVipProductPreModel : JSONModel
@property (nonatomic, strong) NSArray<LTVipProductInfoPreModel,Optional> *packageList;

@end
