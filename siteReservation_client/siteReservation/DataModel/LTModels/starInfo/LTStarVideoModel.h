//
//  LTStarVideoModel.h
//  LeTVMobileDataModel
//
//  Created by 韩阳 on 15/9/1.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//
/***
vid: "23375687",
pid: "10008140",
nameCn: "2015釜山电影节将开幕 汤唯刘亦菲携作品亮相",
subTitle: "汤唯刘亦菲携作品亮相",
cid: "3",
duration: "75",
images: {
    400*300: "http://i1.letvimg.com/lc01_isvrs/201508/26/11/04/1e14354f-28da-4361-ada4-570ec35731f9.jpg"
}
*/
#import <LetvMobileOpenSource/LetvMobileOpenSource.h>
#import <LetvMobileDataModel/LTLiveModel.h>

typedef NS_ENUM(NSInteger, LTStarModelCardType){
    LTStarModelStarIDCardType       =    0,   //Ta在乐视
    LTStarModelBigShotCardType      =    1,
    LTStarModelActivityCardType     =    2,
    LTStarModelAlbumListCardType    =    3,   //代表作品
    LTStarModelVideoListCardType    =    4,   //相关资讯
    LTStarModelLiveListCardType     =    5,   //Live直播
    LTStarModelRingListCardType     =    6,   //明星铃声
    LTStarModelMusicCardType        =    7    //音乐作品
};
@protocol LTStarVideoModel
@end
@protocol LTStarInfoHeaderModel
@end
@protocol LTStarBigShotModel <NSObject>
@end

@interface LTStarBaseModel : JSONModel
@property(nonatomic, assign) LTStarModelCardType modelType;
@end

@interface LTStarImageModel :JSONModel
@property (nonatomic, strong) NSString<Optional> *pic300;
@property (nonatomic, strong) NSString<Optional> *pic250;
@property (nonatomic, strong) NSString<Optional> *pic225;
@end

@interface LTStarVideoModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *vid;
@property (nonatomic, strong) NSString<Optional> *pid;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *title;//明星Id视频有这个标题 其他用nameCn
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *duration;
@property (nonatomic, strong) LTStarImageModel <Optional> *images;
@property (nonatomic, strong) NSString<Optional> *episode;
@property (nonatomic, strong) NSString<Optional> *nowEpisode;
@property (nonatomic, strong) NSString<Optional> *albumType;
@property (nonatomic, strong) NSString<Optional> *director;
@property (nonatomic, strong) NSString<Optional> *starring;
@property (nonatomic, strong) NSString<Optional> *rightCorner;
@property (nonatomic, strong) NSString<Optional> *leftCorner;
@end
//资讯
@interface LTStarSubListVideoModel : LTStarBaseModel
@property(nonatomic, strong) NSArray<LTStarVideoModel, Optional> *videoList;
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;

@end
//专辑
@interface LTStarSubListAlbumModel : LTStarBaseModel
@property(nonatomic, strong) NSArray<LTStarVideoModel, Optional> *videoList;
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;

@end
//铃声
@interface LTStarSubListRingModel : LTStarBaseModel
@property(nonatomic, strong) NSArray<LTStarVideoModel, Optional> *videoList;
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;

@end
//明星id
@interface LTStarSubListStarIdModel : LTStarBaseModel
@property(nonatomic, strong) NSArray<LTStarVideoModel, Optional> *videoList;
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;

@end
//音乐
@interface LTStarSubListMusicModel : LTStarBaseModel
@property(nonatomic, strong) NSArray<LTStarVideoModel, Optional> *videoList;
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;

@end
//头像
@interface LTStarInfoHeaderModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *leId;
@property (nonatomic, strong) NSString<Optional> *leName;
@property (nonatomic, strong) NSString<Optional> *postS1_11_300_300;
@property (nonatomic, strong) NSString<Optional> *backPic;
@property (nonatomic, strong) NSString<Optional> *professional;
@property (nonatomic, strong) NSString<Optional> *tDescription;
@property (nonatomic, strong) NSString<Optional> *fansnum;
@property (nonatomic, strong) NSString<Optional> *birthday;
@property (nonatomic, strong) NSString<Optional> *sequence;

@end
//活动
@interface LTStarActivityModel : LTStarBaseModel
@property (nonatomic, strong) NSString<Optional> *mobilePic;
@property (nonatomic, strong) NSString<Optional> *skipUrl;
@property(nonatomic, strong)NSString <Optional> * sequence;
@end


//铁粉数据
@protocol LTStarFansModel <NSObject>
@end
@interface LTStarFansModel : JSONModel
@property(nonatomic, strong) NSString <Optional> * star_vote_id;
@property(nonatomic, strong) NSString <Optional> * num;
@property(nonatomic, strong) NSString <Optional> * uid;
@property(nonatomic, strong) NSString <Optional> * nickname;
@property(nonatomic, strong) NSString <Optional> * picture;
@end

//大咖榜

@interface LTStarBigShotModel : LTStarBaseModel
@property(nonatomic, strong)NSArray <LTStarFansModel,Optional> * rank; //铁粉列表
@property(nonatomic, strong)NSString <Optional> * ranking; //明星在当月榜单排名
@property(nonatomic, strong)NSString <Optional> * vote_num; //总票数
@property(nonatomic, strong)NSString <Optional> * sequence;
@property(nonatomic, strong)NSString <Optional> * title;
@end

//直播
@interface LTStarLiveListModel : LTStarBaseModel
@property (nonatomic, strong) NSArray<LTLiveRoomDetailModel,Optional> *videoList;
@property(nonatomic, strong) NSString <Optional> * sequence;
@property(nonatomic, strong) NSString <Optional> * title;
@end

@interface LTStarVideoListModel : JSONModel
@property(nonatomic, strong) NSString <Optional> * is_vote;
@property(nonatomic, strong) LTStarInfoHeaderModel<Optional> *star;
@property(nonatomic, strong) LTStarSubListVideoModel<Optional> *videoList;
@property(nonatomic, strong) LTStarSubListAlbumModel<Optional> *albumList;
@property(nonatomic, strong) LTStarActivityModel<Optional> *starActivity;
@property(nonatomic, strong) LTStarBigShotModel <Optional> * bigShot;
@property(nonatomic, strong) LTStarSubListRingModel<Optional> *ringList;
@property(nonatomic, strong) LTStarLiveListModel<Optional> *liveList;
@property(nonatomic, strong) LTStarSubListMusicModel<Optional> *musicList;
@property(nonatomic, strong) LTStarSubListStarIdModel<Optional> *starIdVideo;

@end

