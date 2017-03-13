//
//  LTFeedFlowListDataModel.h
//  LetvMobileClient
//
//  Created by meizhen on 2017/2/17.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>

@protocol LTFeedFlowDataModel @end
@interface LTFeedFlowDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *videoId;
@property (nonatomic, strong) NSString<Optional> *pic; // 视频图片
@property (nonatomic, strong) NSString<Optional> *name; // 视频标题
@property (nonatomic, strong) NSString<Optional> *duration; // 时长
@property (nonatomic, strong) NSString<Optional> *userId; // 发布者ID
@property (nonatomic, strong) NSString<Optional> *up; // 点赞数
@property (nonatomic, strong) NSString<Optional> *vcomm_count; //评论数
@property (nonatomic, strong) NSString<Optional> *userNickName;
@property (nonatomic, strong) NSString<Optional> *userpicture;
@property (nonatomic, strong) NSString<Optional> *media_play_count; // 播放次数
// 上报需要的参数
@property (nonatomic, strong) NSString<Optional> *alg; // 算法
@property (nonatomic, strong) NSString<Optional> *req_id; // 请求id
@property (nonatomic, strong) NSString<Optional> *sessionId; // sessionId
// 置顶参数
@property (nonatomic, strong) NSString<Optional> *index;

- (NSString*) getMinSizeImage;
@end


@interface LTFeedFlowListDataModel : JSONModel

@property (nonatomic, strong) NSMutableArray<LTFeedFlowDataModel, Optional> *data;
@property (nonatomic, strong) NSArray <LTFeedFlowDataModel, Optional> *top;
@property (nonatomic, strong) NSString<Optional> *req_id;
@property (nonatomic, strong) NSString<Optional> *count;
@property (nonatomic, strong) NSString<Optional> *error_code;
@property (nonatomic, strong) NSString<Optional> *error_msg;

@end
