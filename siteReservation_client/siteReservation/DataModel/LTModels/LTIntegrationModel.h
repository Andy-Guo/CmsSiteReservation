//
//  LTIntegrationModel.h
//  LetvIphoneClient
//
//  Created by wd on 14-3-31.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

//  积分基本规则
@interface IntegrationBaseRule : JSONModel

@property(nonatomic, strong)NSString<Optional> *credit; // 积分
@property(nonatomic, strong)NSString<Optional> *cycletype; // 0:不限制 | 1:一次 | 2:每天
@property(nonatomic, strong)NSString<Optional> *rewardnum; // 0:不限制次数 |  其他数字则为限制多少次
@property(nonatomic, strong)NSString<Optional> *rname; //积分规则项中文含义
@property(nonatomic, strong)NSString<Optional> *state; //完成状态结合规则进行判定


@end

//  积分种类（主要由urlParas控制）
@interface IntegrationCategory : JSONModel

@property (nonatomic, strong) IntegrationBaseRule *sharevideo; //分享视频
@property (nonatomic, strong) IntegrationBaseRule *startmapp;  //打开app
@property (nonatomic, strong) IntegrationBaseRule *video;      //观看视频

@end

//  积分获取成功返回结果
@interface IntegrationResult : JSONModel

@property(nonatomic, strong)NSString<Optional> *rname;  // 规则名称
@property(nonatomic, strong)NSString<Optional> *remind; // 提醒方式，0不提醒，1消息，2气泡
@property(nonatomic, strong)NSString<Optional> *credits;  // 这次增加积分的值



@end


// 5.5增加 获取规则项积分记录
@interface ScoreRecord : JSONModel
@property (nonatomic, strong) NSString<Optional> *rid;    //积分规则ID
@property (nonatomic, strong) NSString<Optional> *cyclenum;   //奖励次数
@property (nonatomic, strong) NSString<Optional> *credits;   //积分值
@property (nonatomic, strong) NSString<Optional> *descript;//描述信息
@property (nonatomic, strong) NSString<Optional> *dateline;   //获取时间戳
@property (nonatomic, strong) NSString<Optional> *action; //积分规则名称
@property (nonatomic, strong) NSString<Optional> *rname;  //积分规则项中文含义
@end
