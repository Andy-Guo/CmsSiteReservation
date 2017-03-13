//
//  LTUserSystemMessageModel.h
//  LeTVMobileDataModel
//
//  Created by Speed on 15/8/28.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol LTSystemMessageDetailModel @end
@interface LTSystemMessageDetailModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *content;
@property (nonatomic,strong) NSString<Optional> *image_url;
@property (nonatomic,strong) NSString<Optional> *native;
@property (nonatomic,strong) NSString<Optional> *title;
@property (nonatomic,strong) NSString<Optional> *url;
@property (nonatomic,strong) NSString<Optional> *vid;
@property (nonatomic,strong) NSString<Optional> *pid;


@end

@protocol LTSystemMessageModel @end
@interface LTSystemMessageModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *ctime;
@property (nonatomic,strong) NSString<Optional> *is_read;
@property (nonatomic,strong) NSString<Optional> *messageId;
@property (nonatomic,strong) LTSystemMessageDetailModel<Optional> *data;

@end


@interface LTUserSystemMessageModelData : JSONModel

@property (nonatomic,strong) NSArray<LTSystemMessageModel,Optional> *system_message;
@property (nonatomic,strong) NSArray<LTSystemMessageModel,Optional> *user_message;
@property (nonatomic,strong) NSString<Optional> *countnum;

@end

@interface LTUserSystemMessageModel : JSONModel

@property (nonatomic,strong) NSString<Optional> * code;
@property (nonatomic,strong) LTUserSystemMessageModelData<Optional> *data;

@end

/* 开机未读消息数目模型 */
@interface LTUnreadMessageModel : JSONModel
// 未读消息数目
@property (nonatomic,strong) NSString<Optional> *countnum;

@end
