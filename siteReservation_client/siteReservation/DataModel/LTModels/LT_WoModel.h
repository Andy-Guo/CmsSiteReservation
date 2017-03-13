//
//  LT_WoModel.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-8-6.
//
//


#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface LT_WoModel : JSONModel

@end

@interface LT_WoCheckModel : JSONModel

@property (strong, nonatomic) NSString<Optional>*                province;      //省份
@property (strong, nonatomic) NSString<Optional>*                provinceId;    //省份编码
@property (strong, nonatomic) NSString<Optional>*                city;          //城市
@property (strong, nonatomic) NSString<Optional>*                cityId;        //城市编码
@property (strong, nonatomic) NSString<Optional>*                isp;           //运营商
@property (strong, nonatomic) NSString<Optional>*                ispId;         //运营商编码
@property (strong, nonatomic) NSString<Optional>*                is3g;          //是否3G 1：是，0：否
@property (strong, nonatomic) NSString<Optional>*                isopen;        //该地区是否开通 1：是，0：否
@end

@interface LT_IsOrderModel : JSONModel

@property (strong, nonatomic) NSString<Optional>*                canorder;      //订购状态
@property (strong, nonatomic) NSString<Optional>*                desc;          //描述信息
@property (strong, nonatomic) NSString<Optional>*                username;      //首次订购时登陆用户名

@end


@interface LT_OrderInfoModel : JSONModel

@property (strong, nonatomic) NSString<Optional>*                type;               //类型 空：未订购，0：订购， 1：退订，2：失效
@property (strong, nonatomic) NSString<Optional>*                ordertime;          //订购时间，格式为：yyyyMMddHHmmss
@property (strong, nonatomic) NSString<Optional>*                endtime;            //失效时间，格式为：yyyyMMddHHmmss
@property (strong, nonatomic) NSString<Optional>*                canceltime;         //退订时间，格式为：yyyyMMddHHmmss

@end
