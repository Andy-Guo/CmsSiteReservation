//
//  LTUserCommentReplyModel.h
//  LeTVMobileDataModel
//
//  Created by Speed on 15/9/8.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol LTuserCommentInfoModel @end
@interface LTuserCommentInfoModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *imgurl;    //头像url
@property (nonatomic,strong) NSString<Optional> *content;   //评论内容
@property (nonatomic,strong) NSString<Optional> *ctime;     //评论时间
@property (nonatomic,strong) NSString<Optional> *nickname;  //昵称     回复者有
@property (nonatomic,strong) NSString<Optional> *picture;   //用户头像  回复者有
@property (nonatomic,strong) NSString<Optional> *commentid; //被评论回复的ID

@end


@protocol LTUserCommentReplyInfoModel @end
@interface LTUserCommentReplyInfoModel : JSONModel

@property (nonatomic,strong) LTuserCommentInfoModel<Optional> *commentInfo;
@property (nonatomic,strong) LTuserCommentInfoModel<Optional> *replyInfo;

@end


@protocol LTUserCommentReplyContentModel @end
@interface LTUserCommentReplyContentModel : JSONModel

@property (nonatomic,strong) LTUserCommentReplyInfoModel<Optional> *content;

@end


@protocol LTUserCommentReplyDataModel @end
@interface LTUserCommentReplyDataModel : JSONModel

@property (nonatomic,strong) LTUserCommentReplyContentModel<Optional> *data;
@property (nonatomic,strong) NSString<Optional> *ctime;
@property (nonatomic,strong) NSString<Optional> *messageId;
@property (nonatomic,strong) NSString<Optional> *is_read;

@end


@interface LTUserCommentReplyModel : JSONModel

@property (nonatomic,strong) NSArray<LTUserCommentReplyDataModel,Optional> *user_message;
@property (nonatomic,strong) NSString<Optional> *countnum;

@end
