//
//  LTPlayerIntroModel.h
//  LeTVMobileDataModel
//
//  Created by zyf on 15/3/30.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@interface LTPlayerIntroModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* nameCn; // string	标题
@property (strong, nonatomic) NSString<Optional>* nowEpisodes;     // 未完结：（跟播的当前总集数）|| 期数
@property (strong, nonatomic) NSString<Optional>* episode;//已完结：总集数
@property (strong, nonatomic) NSString<Optional>* playStatus;      //更新频率
@property (strong, nonatomic) NSString<Optional>* playCount;          // 播放数
@property (strong, nonatomic) NSString<Optional>* danmuCount;         // 弹幕数
@property (strong, nonatomic) NSString<Optional>* commentCount;      //评论数
@property (strong, nonatomic) NSString<Optional>* starring;     // 	主演
@property (strong, nonatomic) NSString<Optional>* directory;             //导演
@property (strong, nonatomic) NSString<Optional>* area;   //  地区

@property (strong, nonatomic) NSString<Optional>* releaseDate;  // string   发布年月日
@property (strong, nonatomic) NSString<Optional>* subCategory;      //子分类,多个空格分隔。
@property (strong, nonatomic) NSString<Optional>* desc; //简介描述
@property (strong, nonatomic) NSString<Optional>* videoDesc; //第XX集简介
@property (strong, nonatomic) NSString<Optional>* isHomemade;//是否为自制
@property (strong, nonatomic) NSString<Optional>* isEnd;//是否完结 电视剧、动漫
//film
@property (strong, nonatomic) NSString<Optional>* alias;  // 别名
@property (strong, nonatomic) NSString<Optional>* score; //评分
@property (strong, nonatomic) NSString<Optional>* duration;//片长

//anime
@property (strong, nonatomic) NSString<Optional>* fitAge;//适合年龄段
@property (strong, nonatomic) NSString<Optional>* originator;//原作
@property (strong, nonatomic) NSString<Optional>* supervise;//主创
@property (strong, nonatomic) NSString<Optional>* cast;//声优
@property (strong, nonatomic) NSString<Optional>* dub;//配音

//Variety  正片
@property (strong, nonatomic) NSString<Optional>* compere;//主持人
@property (strong, nonatomic) NSString<Optional>* playTv;//播出电视台


//musci
@property (strong, nonatomic) NSString<Optional>* singer;//歌手

//car || fashion
@property (strong, nonatomic) NSString<Optional>* style;//类型

//ent
@property (strong, nonatomic) NSString<Optional>* createTime;//创建时间


@property (strong, nonatomic) NSString<Optional>* videoType;//类型

@property (strong, nonatomic) NSString<Optional>* varietyShow;//栏目非栏目

@property (strong, nonatomic) NSString<Optional>* linenum;//收起态显示行数
@property (strong, nonatomic) NSString<Optional>* up;//赞的数量
@property (strong, nonatomic) NSString<Optional>* down;//踩的数量
// 辅助属性存储cell高度
@property (nonatomic, strong) NSNumber<Ignore> *introCellHeight;

@end
