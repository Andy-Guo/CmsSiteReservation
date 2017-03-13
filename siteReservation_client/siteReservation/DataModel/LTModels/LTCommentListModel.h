//
//  LTCommentListModel.h
//  LetvIphoneClient
//
//  Created by bob on 14-3-26.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTCommentImagePack <NSObject>
@end

@interface LTCommentImagePack : JSONModel

@property(strong,nonatomic)NSString<Optional> * image_180;
@property(strong,nonatomic)NSString<Optional> * image_310;
@property(strong,nonatomic)NSString<Optional> * image_o;
@end


@protocol LTCommentUser <NSObject>
@end

@interface LTCommentUser : JSONModel

@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *photo;
@property (nonatomic, strong) NSString<Optional> *username;
@property (nonatomic, strong) NSString<Optional> *ssouid;
@property (nonatomic, assign) BOOL isvip;
@property (nonatomic, assign) BOOL isStar; //是否为明星  6.0新加

@end


@protocol LTCommentDataElem <NSObject>
@end

@interface LTCommentDataElem : JSONModel

@property (nonatomic, assign) NSInteger isLike;
@property (nonatomic, strong) NSString<Optional> *_id;        // 评论id
@property (nonatomic, strong) NSString<Optional> *commentid;  // 回复对应的评论的id
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand, Optional> *replys; // 默认展示的三条评论
@property (nonatomic, strong) LTCommentDataElem<Optional> *reply; // 被回复人的信息
@property (nonatomic, strong) NSString<Optional> *pid;        // 视频专辑ID
@property (nonatomic, strong) NSString<Optional> *htime;
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *from;       // 例子：PC
@property (nonatomic, strong) NSString<Optional> *ctime;      // 评论时间戳
@property (nonatomic, strong) NSString<Optional> *replynum;   // 评论回复数量，新版不用关心这个字段
@property (nonatomic, strong) NSString<Optional> *vtime;      // 评论格式化时间
@property (nonatomic, strong) NSString<Optional> *city;       // 评论地区
@property (nonatomic, strong) NSString<Optional> *flag;       // 是否通过审核，1 未通过 | 0 通过
@property (nonatomic, strong) LTCommentUser<Optional> *user;
@property (nonatomic, strong) NSString<Optional> *share;      // 评论分享数
@property (nonatomic, strong) NSString<Optional> *ssouid;
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *content;    // 评论内容
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *mmsid;
@property (nonatomic, strong) NSString<Optional> *like;       // 评论喜欢数
@property (nonatomic, strong) NSString<Optional> *img;
@property (nonatomic, strong) NSString<Optional> *xid;        // 视频播放ID
@property (nonatomic, strong) NSString<Optional> *voteFlag;   //是否是阵营投票 1，支持红方，2支持蓝方

// 业务相关数据
//@property (nonatomic, strong) UIImage<Ignore>    *localImg;    // 本地发送的图片数据
@property (nonatomic, strong) NSString<Optional> *section;     // 对应的section
@property (nonatomic, strong) NSString<Optional> *row;         // 对应的row
@property (nonatomic, strong) NSString<Optional> *isReplyUnfold;  // 回复是否已经展开
@property (nonatomic, strong) NSString<Optional> *isLocalReply;
@property (nonatomic, strong) NSString<Optional> *isLocalData;
@property (nonatomic, strong) LTCommentImagePack<Optional> *imgPack;
@property (nonatomic, strong) NSIndexPath<Optional>  *fatherIndexPath;
@property (nonatomic, strong) NSIndexPath<Optional>  *selfIndexPath;
@end

@interface LTCommentAnnouncementElem : JSONModel
@property (nonatomic, strong) NSString<Optional> *content;
@property (nonatomic, strong) NSString<Optional> *link_t;
@property (nonatomic, strong) NSString<Optional> *link_a;
@end

@interface LTCommentListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *result;
@property (nonatomic, assign) NSInteger rule;
@property (nonatomic, assign) NSInteger total;//实际的评论数
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand,Optional> *data; // 推荐频道数据
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand,Optional> *authData;//未通过审核的评论数据
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand,Optional> *topData;//精华评论数据
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand,Optional> *godData;//热评评论数据
@property (nonatomic, strong) LTCommentAnnouncementElem<Optional> *announcementData; //置顶评论数据
@property (nonatomic, strong) NSString<Optional> *video_title; //被回复的评论列表页 视频信息标题
@property (nonatomic, strong) NSString<Optional> *pic_320_200; //被回复的评论列表页 视频信息缩略图
@property (nonatomic, strong) NSString<Optional> *pic_420_250; //被回复的评论列表页 视频信息缩略图
@property (nonatomic, strong) NSString<Optional> *comment_total;//回复和评论的总数

@end

@interface LTCommentNumberModel : JSONModel
@property (nonatomic, assign) long long vdm_count;
@property (nonatomic, assign) long long plist_count;
@property (nonatomic, assign) long long plist_score;
@property (nonatomic, assign) long long vcomm_count;
@property (nonatomic, assign) long long pcomm_count;
@property (nonatomic, assign) long long preply;
@property (nonatomic, assign) long long vreply;
@property (nonatomic, assign) long long vnpcomm;
@property (nonatomic, assign) long long pdm_count;
@property (nonatomic, assign) long long media_play_count;
@property (nonatomic, assign) long long down;
@property (nonatomic, assign) long long up;
@property (nonatomic, assign) long long pnpcomm;
@property (nonatomic, assign) long long plist_play_count;
@property (nonatomic, assign) long long vcomm_total;
@property (nonatomic, assign) long long pcomm_total;
@property (nonatomic, assign) NSInteger is_comm;
@end

@interface LTReplyListModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *result;
@property (nonatomic, assign) NSInteger rule;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSMutableArray<LTCommentDataElem, ConvertOnDemand,Optional> *data; // 回复列表
@property (nonatomic, strong) LTCommentDataElem<Optional> *comment; // 评论体
@end

@interface LTAddCommentParameModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *vid;        // 视频ID
@property (nonatomic, strong) NSString<Optional> *pid;       // 专辑id
@property (nonatomic, strong) NSString<Optional> *cid;       //频道id
@property (nonatomic, strong) NSString<Optional> *type;     //评论类型
@property (nonatomic, strong) NSString<Optional> *ctype;     //评论类型 img cmt
@property (nonatomic, strong) NSString<Optional> *content;      // 评论文本内容
@property (nonatomic, strong) NSString<Optional> *htime;   // 截图时间
@property (nonatomic, strong) NSString<Optional> *voteFlag;      // 投票标志
@property (nonatomic, strong) NSData<Optional> *imgData;       // 图片数据
@property (nonatomic, strong) NSString<Optional> *fileName;       // 图片名称
@end

