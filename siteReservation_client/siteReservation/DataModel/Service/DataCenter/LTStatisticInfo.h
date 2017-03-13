//
//  LTStatisticInfo.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 14-8-14.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>

@interface LTStatisticInfo : NSObject

@property(nonatomic,assign)LTDCActionCode acode;   //动作类型
@property(nonatomic,assign)LTDCPageID pageID;     //页面id
@property(nonatomic,strong)NSString *pid;     //专辑id
@property(nonatomic,strong)NSString *vid;     //视频id
@property(nonatomic,strong)NSString *zid;     //专题id
@property(nonatomic,strong)NSString *cid;     //频道id
@property(nonatomic,strong)NSString *name;    //名称
@property(nonatomic,strong)NSString *name1;     //名称1
@property(nonatomic,strong)NSString *cur_url;  //当前url
@property(nonatomic,assign)BOOL isSuccess;     //是否成功
@property(nonatomic,assign)NSInteger wz;      //位置
@property(nonatomic,strong)NSString *scidID;   //接口返回的页面ID
@property(nonatomic,assign)LTDCActionPropertyCategory apc; //统计动作属性(ap)分类(fl)
@property(nonatomic,strong)NSString * hbid;    //红包id
@property(nonatomic,strong)NSString * rpid;    //春节红包ID
@property(nonatomic,strong)NSString * vip;     //是否Vip
@property(nonatomic,strong)NSString * ispay;   //是否付费
@property(nonatomic,strong)NSString *sc;        //分享渠道

@property(nonatomic,strong)NSString *reid;     //推荐反馈的随机数
@property(nonatomic,strong)NSString *area;     //页面区域标识
@property(nonatomic,strong)NSString *bucket;   //推荐的算法策略
@property(nonatomic,strong)NSString *rank;     //点击视频在推荐区域的排序
@property(nonatomic,strong)NSString *is_rec;   // 是否推荐数据
@property(nonatomic,strong)NSString *time;     //点击时间点。
@property(nonatomic,strong)NSString *pids;     // 推荐视频所在的视频列表的pids
@property(nonatomic,strong)NSString *vids;     // 推荐视频所在的视频列表的vids
@property(nonatomic,strong)NSString *avg_speed; // 下载的平均速度

@property(nonatomic,strong)NSString *ref;      //页面来源
@property(nonatomic,strong)NSString *type;     //大tip点击需要传的
@property(nonatomic,strong)NSString *messagetype; //通知类型
@property(nonatomic,strong)NSString *fragId;     // 板块碎片id
@property(nonatomic,strong)NSString *lid;
@property(nonatomic,strong)NSString *st;
@property(nonatomic,strong)NSString *sk;
@property(nonatomic,strong)NSString *nt;
@property(nonatomic,strong)NSString *ps;
@property(nonatomic,strong)NSString *of;
@property(nonatomic,strong)NSString *cl;
@property(nonatomic,strong)NSString *sh;
@property(nonatomic,strong)NSString *kd;
@property(nonatomic,strong)NSString *ar;

@property(nonatomic,strong)NSString *nid;
@property(nonatomic,strong)NSString *ft;
//6.2 新加
@property(nonatomic,assign)NSInteger lc;     //副标题在模块名称icon的位置 1,2,3
@property(nonatomic,strong)NSString *lcName; //副标题名称
@property(nonatomic,strong)NSString *sorts;  //频道墙排序后数据上报；
//6.7 新加
@property(nonatomic,strong)NSString *vidlist; // 半屏card中显示的vid列表，冒号拼接
//6.8.2新加
/**
 * (0-点播，1-直播，2-轮播，3-缓存播放，4-播放本地视频)
 */
@property (nonatomic, strong) NSString *ty; //播放类型-扩展字段
@property (nonatomic, strong) NSString *flag; //分屏id

//6.13新增登陆字段
@property (nonatomic, strong) NSString *quittype;
+ (LTStatisticInfo *)sharedInstance;

- (void)reset;
@end
