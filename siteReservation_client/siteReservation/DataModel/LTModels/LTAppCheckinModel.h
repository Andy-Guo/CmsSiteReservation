//
//  LTAppSignInModel.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-6-25.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface LTCheckinExchangeModel: JSONModel

@property(strong,nonatomic)NSString<Optional> *               vip;//赠送的vip天数。
@property(strong,nonatomic)NSString<Optional> *               lottery;//可以抽奖的次数

@end

@interface LTAppCheckinModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *               msg;//签到情况描述。
@property(strong,nonatomic)LTCheckinExchangeModel<Optional> * exchange;//可兑换的物品
@property(strong,nonatomic)NSString<Optional> *               urlindex;//具体的领奖页地址
@property(strong,nonatomic)NSString<Optional> *               status;//本次签到后的状态1.去领取 2.去抽奖 3.去看看
@property(strong,nonatomic)NSString<Optional> *               urldesc;//详情url

@end
