//
//  LTCloudRecordModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-10.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/MovieInfo.h>

@protocol LTCloudRecordItemPicAll @end
@interface LTCloudRecordItemPicAll : JSONModel

@property (strong, nonatomic) NSString<Optional> *img_300_300;
@property (strong, nonatomic) NSString<Optional> *img_120_90;
@property (strong, nonatomic) NSString<Optional> *img_400_225;
@property (strong, nonatomic) NSString<Optional> *img_400_250;

@end

@class LTPlayHistoryCommand;

@protocol LTCloudRecordItemModel @end
@interface LTCloudRecordItemModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* cid;        	//频道id
@property (strong, nonatomic) NSString<Optional>* from;         //来源:1:web;2:mobile;3:pad;4:tv;5:pc桌面
@property (strong, nonatomic) NSString<Optional>* htime;        //播放时间点
@property (strong, nonatomic) NSString<Optional>* img;          //视频封面图
@property (strong, nonatomic) NSString<Optional>* isend;
@property (strong, nonatomic) NSString<Optional>* nvid;         //下一个视频id
@property (strong, nonatomic) NSString<Optional>* pid;          //专辑id
@property (strong, nonatomic) NSString<Optional>* title;        //视频标题
@property (strong, nonatomic) NSString<Optional>* utime;        //最后更新时间
@property (strong, nonatomic) NSString<Optional>* vid;          //视频id
@property (strong, nonatomic) NSString<Optional>* vtime;
@property (strong, nonatomic) NSString<Optional>* vtype;        //视频类型
@property (strong, nonatomic) NSString<Optional>* nc;           //当前集数
@property (assign, nonatomic) BOOL isCheck;
@property (strong, nonatomic) LTCloudRecordItemPicAll<Optional> *picAll;
@property (strong, nonatomic) NSString<Optional>* upgc;    //短视频标记 为1则是短视频

// ZhangQigang: 5.8.2 增加视频类型
@property (strong, nonatomic) NSString<Optional>* videoType;    //当前视频类型, 正片, 非正片
+ (LTCloudRecordItemModel *)createFromLocalPlayHistory:(LTPlayHistoryCommand *)localPlayHistory;

- (NSString *)getPlayHistoryShowInfo;
@end


@interface LTCloudRecordModel : JSONModel
@property (strong, nonatomic) NSArray<LTCloudRecordItemModel,Optional>* items;  //播放记录内容
@property (strong, nonatomic) NSString<Optional>* page;       //当前页
@property (strong, nonatomic) NSString<Optional>* pageSize;   //每页条数
@property (strong, nonatomic) NSString<Optional>* stime;
@property (strong, nonatomic) NSString<Optional>* total;      //总数

-(MovieInfo *)wrapResultSet:(LTCloudRecordItemModel *)itemModel forID:(NSInteger)theID;


@end
