//
//  LTDevicePaymentInfoModel.h
//  LeTVMobileDataModel
//
//  Created by Qinxl on 15/3/8.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

@protocol LTDevicePaymentInfoModel @end
@interface LTDevicePaymentInfoModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* userid;        // string	虚拟用户id
@property (strong, nonatomic) NSString<Optional>* uname;         // string	虚拟用户name
@property (strong, nonatomic) NSString<Optional>* viptype;       // string	会员类型
@property (strong, nonatomic) NSString<Optional>* create_time;   // string 

@end
