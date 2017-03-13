//
//  MovieInfo.h
//  Letv
//
//  Created by iBokanWisdom on 10-6-19.
//  Copyright 2010 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef LT_MERGE_FROM_IPAD_CLIENT

@interface MovieInfo : NSObject 
{
	@private
	NSInteger _ID;
	NSString *_movie_ID;//movieID
	NSString *_p_ID;//专辑ID
	NSString *_mmsID;//mmsID
    NSString *_cid; // cid
	NSString *_title;//标题
    NSString *_mainTitle;//主标题
	NSString *_file_size; //文件大小
	NSString *_icon;//图片	
	NSString *_time_length;//时长
    NSString *_curr_time; // 当前时间
	NSString *_play_times;//播放次数
	NSString *_intro;//简介
	NSString *_sourceType;//影片来源 www/library
	NSString *_lp_url;//标清播放地址
	NSString *_hp_url;//高清清播放地址
	NSString *_download_url;//下载地址
	NSString *_download_size;//已下载文件大小
	NSString *_tags;//标签 
	NSString *_release_year;//上映年份
	NSString *_director;//导演
	NSString *_actor;//演员
	NSString *_score;//评分
	NSString *_movie_cate;//影片类别
	NSString *_movie_area;//影片地区
	NSString *_data_type;// 收藏/播放历史/普通TO
	NSString *_local_path;//下载视频本地地址
	NSString *_tag_num; //播放第几集
    NSString *_updating; // 是否为同步剧 1/0/-1
//	NSString *_count; // 集数
    NSString *_c_ID;//影片类别20110824 收藏添加
    NSInteger _vType;//当前视频集 电影等非剧集默认为0
    NSInteger _offset; //当前视频播放位置 只用于播放记录
    Boolean  _bUpdating; // 是否为跟播剧 1/0
    NSString *_v_ID;
    NSString *_br;      //(视频码率){350,800}
    NSString *_databaseVersion;  //数据库版本
    NSInteger _videoType;
    NSString *_btime;
    NSString *_etime;
    NSString *_atTag;  //根据服务器at字符判断进入详情，播放，跳出，进入主题
    NSString *_albumType; //专辑类型
    NSString *_payfrom; //应用平台 4-VIP， 7-网络院线  0-免费，默认：4,7,此参数支持多个值
    NSString *_allowmonth; //支持包月：0-仅单点，1-单点且支持包月，2-仅支持包月；默认：0,1,2；此参数支持多个值，多个值用“,”分割，例如：0,1,2
    NSString *_paydate; //付费截止日期
    NSString *_singleprice; //付费影片价格
    NSString *_aidTitle;    // 专辑标题
    NSString *_pay;    // 是否付费
    DeviceFromType _deviceFromType;  //视频来源设备类型
    NSString *_lastRecordTime;   //视频播放记录的最后更新时间
    BOOL     _needpay; // 是否为付费骗子
    NSString *_viptag;  // vip标签
    NSString *_nvid;   // 5.9 新加的
    
}
@property(nonatomic,assign) NSInteger ID;
@property(nonatomic,copy) NSString *movie_ID;
@property(nonatomic,copy) NSString *p_ID;
@property(nonatomic,copy) NSString *mmsID;
@property(nonatomic,copy) NSString *cid;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *file_size;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *time_length;
@property(nonatomic,copy) NSString *curr_time;
@property(nonatomic,copy)	NSString *play_times;
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,copy) NSString *sourceType;
@property(nonatomic,copy) NSString *lp_url;
@property(nonatomic,copy) NSString *hp_url;
@property(nonatomic,copy) NSString *download_url;
@property(nonatomic,copy) NSString *download_size;
@property(nonatomic,copy) NSString *tags;
@property(nonatomic,copy) NSString *release_year;
@property(nonatomic,copy) NSString *director;
@property(nonatomic,copy) NSString *actor;
@property(nonatomic,copy) NSString *score;
@property(nonatomic,copy) NSString *movie_cate;
@property(nonatomic,copy) NSString *movie_area;
@property(nonatomic,copy) NSString *data_type;
@property(nonatomic,copy) NSString *local_path;
@property(nonatomic,copy) NSString *tag_num;
@property(nonatomic,copy) NSString *updating;
//@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *v_ID;
@property(nonatomic,copy) NSString *br;
@property(nonatomic,copy) NSString *databaseVersion; 
@property(nonatomic,assign) NSInteger videoType; 
@property(nonatomic,copy) NSString *btime;
@property(nonatomic,copy) NSString *etime;
@property(nonatomic,copy) NSString *atTag;
@property(nonatomic,copy)  NSString *albumType;
@property(nonatomic,copy)  NSString *payfrom;
@property(nonatomic,copy)  NSString *allowmonth;
@property(nonatomic,copy)  NSString *paydate;
@property(nonatomic,copy)  NSString *singleprice;
@property(nonatomic,copy)  NSString *aidTitle;
@property(nonatomic,copy)  NSString *pay;
@property(nonatomic,assign)  DeviceFromType deviceFromType;
@property(nonatomic,copy) NSString *lastRecordTime;
@property(nonatomic,copy) NSString *c_ID;
@property(nonatomic,assign) NSInteger vType;
@property(nonatomic,assign) NSInteger offset;
@property(nonatomic,assign) Boolean bUpdating;
@property(nonatomic,assign) BOOL needpay;
@property(nonatomic,copy) NSString *viptag;
@property(nonatomic,copy) NSString *mainTitle;
@property(nonatomic,copy) NSString *aid;
@property(nonatomic,copy) NSString *nvid;


@property(nonatomic,copy) NSString *favCloudId;
@property(nonatomic,copy) NSString *subTitle;
@property(nonatomic,copy) NSString *favVersion;
@property(nonatomic,copy) NSString *actorAndStarInfo;
@end

#else

@interface MovieInfo : NSObject 
{
	@private
	NSInteger _ID;
	NSString *_movie_ID;//movieID ===== 专辑ID or 视频ID
	NSString *_v_ID;//专辑ID  ====== 视频ID
    NSString *_p_ID;//专辑ID
	NSString *_mmsID;//mmsID ====== mmsid
	NSString *_title;//标题
    NSString *_mainTitle;//主标题
	NSString *_icon;//图片	
	NSString *_time_length;//时长
	NSString *_play_times;//播放次数
	NSString *_intro;//简介
	NSString *_sourceType;//影片来源 www/library
	NSString *_lp_url;//标清播放地址
	NSString *_hp_url;//高清清播放地址
	NSString *_tags;//标签 
	NSString *_release_year;//上映年份
	NSString *_director;//导演
	NSString *_actor;//演员
	NSString *_score;//评分
	NSString *_movie_cate;//影片类别
	NSString *_movie_area;//影片地区
	NSString *_data_type;// 收藏/播放历史/普通TO
    NSString *_c_ID;//影片类别20110824 收藏添加
	NSInteger _vType;//当前视频集 电影等非剧集默认为0
	NSInteger _offset; //当前视频播放位置 只用于播放记录
    Boolean  _bUpdating; // 是否为跟播剧 1/0
	NSString *_download_url;	//缓存路径
	NSInteger _btime; // 片头位置
    NSInteger _etime; // 片尾位置
    BOOL     _needpay; // 是否为付费骗子
    NSString *_viptag;  // vip标签
    NSString *_aid;     // 专辑ID
    DeviceFromType _deviceFromType;  //视频来源设备类型
    NSString *_lastRecordTime;   //视频播放记录的最后更新时间
}
@property(nonatomic,assign) NSInteger ID;
@property(nonatomic,copy) NSString *movie_ID;
@property(nonatomic,copy) NSString *v_ID;
@property(nonatomic,copy) NSString *p_ID;
@property(nonatomic,copy) NSString *mmsID;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *mainTitle;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *time_length;
@property(nonatomic,copy)	NSString *play_times;
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,copy) NSString *sourceType;
@property(nonatomic,copy) NSString *lp_url;
@property(nonatomic,copy) NSString *hp_url;
@property(nonatomic,copy) NSString *tags;
@property(nonatomic,copy) NSString *release_year;
@property(nonatomic,copy) NSString *director;
@property(nonatomic,copy) NSString *actor;
@property(nonatomic,copy) NSString *score;
@property(nonatomic,copy) NSString *movie_cate;
@property(nonatomic,copy) NSString *movie_area;
@property(nonatomic,copy) NSString *data_type;
@property(nonatomic,copy) NSString *cid;
@property(nonatomic,assign) NSInteger vType;
@property(nonatomic,assign) NSInteger offset;
@property(nonatomic,assign) Boolean bUpdating;
@property(nonatomic,copy) NSString *download_url;
@property(nonatomic,assign) NSInteger btime;
@property(nonatomic,assign) NSInteger etime;
@property(nonatomic,assign) BOOL needpay;
@property(nonatomic,copy) NSString *viptag;
@property(nonatomic,copy) NSString *aid;
@property(nonatomic,assign)  DeviceFromType deviceFromType;
@property(nonatomic,copy) NSString *lastRecordTime;


@property(nonatomic,copy) NSString *favCloudId;
@property(nonatomic,copy) NSString *subTitle;
@property(nonatomic,copy) NSString *favVersion;
@property(nonatomic,copy) NSString *actorAndStarInfo;

@end

#endif
