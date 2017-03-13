//
//  IndexModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

//#import "JSONModel.h"
#import "LTChannelIndexModel.h"

#import <LetvMobileDataModel/MovieDetailModel.h>

@protocol IndexModel @end
@protocol BlockModel @end
@protocol BootimgModel @end
@protocol PopinfoModel @end


@interface BlockModel : JSONModel

@property (strong, nonatomic) NSString *name;      // String	区块名称
//@property (strong, nonatomic) NSString *cate;       // String	区块所属频道id
//@property (assign, nonatomic) BOOL islink;          // String	是否跳转到频道页：1-是，0-否
//@property (assign, nonatomic) BOOL ismask;          // String	是否显示蒙板：1-是，0-否
//@property (assign, nonatomic) int stampnum;         // String	盖章类型为“new-最新” 的个数
@property (strong, nonatomic) NSMutableArray<FocusPicModel, ConvertOnDemand>* video; // video	影片列表

@end



@interface BootimgModel : JSONModel

//@property (strong, nonatomic) NSString *pic800_1280;        // 800*1280	String	图片地址：尺寸（android phone,800*1280）
//@property (strong, nonatomic) NSString *pic1024_768;        // 1024*768	String	图片地址：尺寸（pad,1024*768）
//@property (strong, nonatomic) NSString *pic640_960;         // 640*960	String	图片地址：尺寸（iphone,640*960）
//@property (strong, nonatomic) NSString *pic640_1136;        // 640*1136	String	图片地址：尺寸（iphone,640*1136）
//@property (strong, nonatomic) NSDate *pushpic_starttime;    // String	开始时间
//@property (strong, nonatomic) NSDate *pushpic_endtime;      // String	结束时间
//@property (assign, nonatomic) BOOL settop;                  // String	置顶：1-置顶，0-非置顶
//@property (strong, nonatomic) NSString *type;               // String	跳转类型：1-vrs专辑(进详情)，2-vrs视频(直接播放)，其他值不跳转
//@property (strong, nonatomic) NSString *id;                 // String	对应跳转类型：type为1时是专辑id，type为2时是视频id

@property (nonatomic, strong) NSString *name;   // 开机图片名字
@property (nonatomic, strong) NSString *pic_1;  // 开机图片地址
@property (nonatomic, strong) NSDate *pushpic_starttime; // 开始时间
@property (nonatomic, strong) NSDate *pushpic_endtime;   // 结束时间
@property (nonatomic, strong) NSString *order;             // 暂时没有使用

// 获取开机推送图名称
- (NSString *)getPushPicName;

// 获取开机推送图优先级
- (LTBootImagePriority)getPushPicPriority;

@end

@interface PopinfoModel : JSONModel
@property (strong,nonatomic) NSString *pid;                // String 专辑id
@property (strong,nonatomic) NSString *vid;                // String 视频id
@property (strong,nonatomic) NSString *title;              // String 标题
@property (strong,nonatomic) NSString *subTitle;           // String 副标题
@property (strong,nonatomic) PicCollectionModel *picCollections; //图片列表
@property (strong,nonatomic) NSString *type;               // String 影片来源 1-vrs专辑 3-vrs视频
@end

@interface IndexModel : JSONModel

@property (strong, nonatomic) NSArray<BlockModel, ConvertOnDemand>* block;          // 推荐频道数据
@property (strong, nonatomic) NSArray<BootimgModel, ConvertOnDemand>* bootimg;      // 开机推送图
@property (strong, nonatomic) NSMutableArray<FocusPicModel, ConvertOnDemand>* focuspic;    // 焦点图
@property (strong, nonatomic) PopinfoModel<Optional> *popinfo;
@property (strong, nonatomic) NSMutableArray<FocusPicModel, Optional, ConvertOnDemand> *recommend;   // 内容推荐


// 指定图片是否存在当前开机推送图列表中
- (BOOL)isPushPicExisted:(NSString *)picname;

- (void)removeInvalidData;

@end
