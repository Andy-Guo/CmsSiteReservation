//
//  UCConsumeModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-18.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTOrderInfo.h>

@protocol  UCConsumeInfoModel @end
@interface UCConsumeInfoModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *id; //订单ID
@property (strong, nonatomic) NSString<Optional> *status;
@property (strong, nonatomic) NSString<Optional> *cancelTime;//失效时间
@property (strong, nonatomic) NSString<Optional> *payType;
@property (strong, nonatomic) NSString<Optional> *money;//价格
@property (strong, nonatomic) NSString<Optional> *moneyDes;//
@property (strong, nonatomic) NSString<Optional> *orderName;
@property (strong, nonatomic) NSString<Optional> *addTime;//开始时间

- (LTOrderInfo *) getOrderInfo;
@end

@interface UCConsumeModel : JSONModel
@property (strong, nonatomic) NSArray<UCConsumeInfoModel,Optional>*orderList;
@property (strong, nonatomic) NSString<Optional> *totalCount;
@property (strong, nonatomic) NSString<Optional> *msg;
@end
