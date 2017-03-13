//
//  LTVoteModel.h
//  LeTVMobileDataModel
//
//  Created by dongjianpeng on 15/9/6.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>


@interface LTVoteResultModel : JSONModel
@property (nonatomic, strong) NSString      <Optional>*code;
@property (nonatomic, strong) NSDictionary  <Optional>*data;
@property (nonatomic, strong) NSString      <Optional>*_timestamp;
@property (nonatomic, strong) NSDictionary  <Optional>*remain;
@end

@protocol  LTVoteDetailModel
@end

@interface LTVoteDetailModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* vote_id;     //投票id
@property (nonatomic, strong) NSString <Optional>* vote_title;  //投票歌手名称
@property (nonatomic, strong) NSString <Optional>* vote_head;   //投票歌手头像
@property (nonatomic, assign) long long vote_num;    //票数
@end

@protocol LTVoteListModel
@end

@interface LTVoteListModel : JSONModel
@property (nonatomic, strong) NSString <Optional>* vid;          //视频id
@property (nonatomic, strong) NSString <Optional>* vote_name;    //视频名称
@property (nonatomic, strong) NSArray  <Optional, ConvertOnDemand, LTVoteDetailModel>* vote_content; //投票详情
@end

@interface LTVoteModel : JSONModel
@property (nonatomic, strong) NSArray  <Optional, ConvertOnDemand, LTVoteListModel>* votelist; //投票详情
@end

/**
 *  新版图文投票
 */
@interface LTFSVoteShareModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*subtitle;
@property (nonatomic, copy) NSString <Optional>*remarks;
@property (nonatomic, copy) NSString <Optional>*url;              //分享链接
@end

@interface LTFSVoteDetailModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*option_id;        //投票选项id
@property (nonatomic, copy) NSString <Optional>*title;            //投票选项标题
@property (nonatomic, copy) NSString <Optional>*subtitle;         //投票选项副标题
@property (nonatomic, copy) NSString <Optional>*remarks;          //投票选项备注
@property (nonatomic, copy) NSString <Optional>*img;              //投票选项图片
@property (nonatomic, copy) NSString <Ignore>*markName;           //角标
@property (nonatomic, copy) NSString <Ignore>*markColor;          //角标颜色
@property (nonatomic, copy) NSString <Ignore>*markImage;          //角标图
@property (nonatomic, assign) long long vote_num;                 //投票数
@property (nonatomic, assign) long long rate;                     //投票率
@property (nonatomic, copy) NSString <Ignore>*votePercent;        //投票比例
@end

@protocol LTFSVoteDetailModel;
@protocol LTFSVoteBubbleTipModel;
@protocol LTFSVoteShareModel;

@interface LTFSVoteListModel : JSONModel
@property (nonatomic, copy)   NSString <Optional>*title;            //投票标题
@property (nonatomic, copy)   NSString <Optional>*subtitle;         //气泡标题
@property (nonatomic, copy)   NSString <Optional>*vote_id;          //投票id
@property (nonatomic, copy)   NSString <Optional>*rule;             //投票遵循规则
@property (nonatomic, copy)   NSString <Optional>*vid;              //视频vid
@property (nonatomic, copy)   NSString <Optional>*pid;              //视频pid
@property (nonatomic, copy)   NSString <Optional>*vote_total_num;   //投票参与总人数
@property (nonatomic, copy)   NSString <Optional>*icon;             //气泡图片
@property (nonatomic, assign) long long second;           //触发秒数
@property (nonatomic, assign) long long lifestart;        //开始时间戳
@property (nonatomic, assign) long long lifeend;          //结束时间戳
//投票选项
@property (nonatomic, strong) NSArray      <LTFSVoteDetailModel, ConvertOnDemand>*options;
@end

@protocol LTFSVoteListModel;

@interface LTFSVoteDataModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*code;             //状态码
@property (nonatomic, strong) NSArray <Optional, ConvertOnDemand, LTFSVoteListModel>*data; //投票数据
@end

