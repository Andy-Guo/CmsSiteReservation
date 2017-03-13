//
//  LTPlayHalfScreenCardXMLParse.h
//  LetvIphoneClient
//
//  Created by liuxuan on 15/8/25.
//  Copyright (c) 2015年 liuxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTXMLPlayCardTypeModel,LTXMLPlayCardModel,LTXMLPlayCardTemplateModel;
/**
 *  点播半屏播放页card配置文件解析管理类
 */
@interface LTPlayHalfScreenCardXMLParse : NSObject

/**
 *  XML版本号
 */
@property(readonly,nonatomic)NSString * xmlVersion;

/**
 *  以CID为key写入的字典
 */
@property(readonly,nonatomic)NSDictionary * cardTemplates;

/**
 *  xml中以cardID为key写入的字典
 */
@property(readonly,nonatomic)NSDictionary * cardModels;

/**
 *  检查pageCardXML文件更新
 */
+(void)checkHalfScreenCardXMLUpdate;

/**
 *  获取解析器单例对象
 *
 */

+(LTPlayHalfScreenCardXMLParse*)shareCardParse;

/**
 *  获取某个一级模板
 *
 *  @param cid 频道ID
 *
 *  @return
 */
-(LTXMLPlayCardTemplateModel*)getCardTemplateWithCid:(NSInteger)cid;

/**
 *  获取一个card模板
 *
 *  @param cardID cardID
 *
 *  @return
 */
-(LTXMLPlayCardModel*)getCardModelWithCardID:(NSInteger)cardID;

@end

/**
 *  当前某个card可能的类型
 */
@interface LTXMLPlayCardTypeModel: NSObject

@property(strong,nonatomic)NSString * type;
@property(strong,nonatomic)NSString * title_simp;//简体中文
@property(strong,nonatomic)NSString * title_trad;//繁体中文
@property(strong,nonatomic)NSString * defaultRowCount;//非xml定义的
@property(strong,nonatomic)NSString * cell_style; // card展示类型 1两行六个样式 2单行横滑样式

/**
 *  根据当前语言设置获取适合的title
 *
 *  @return
 */
-(NSString*)getTitleForLocalLanguage;
@end

/**
 *  当前某个card的样式
 */
@protocol LTXMLPlayCardStyleModel <NSObject>
@end
@interface LTXMLPlayCardStyleModel : NSObject

@property(strong,nonatomic)NSString *styleID;
@property(strong,nonatomic)NSString *episodeStyle;
@end

/**
 *  card配置模型
 */
@interface LTXMLPlayCardModel: NSObject

@property(strong,nonatomic)NSString *  cardID;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * direction;
@property(strong,nonatomic)NSArray * cardTypes;
@property(strong,nonatomic)NSArray<LTXMLPlayCardStyleModel> * cardStyles;

- (LTXMLPlayCardStyleModel *)getAvalibleCardStyleForStyleID:(NSString *)styleID
                                               episodeStyle:(NSInteger)episodeStyle;
@end

/**
 *  工具条配置模型
 */
@interface LTXMLPlayToolBarCardModel : NSObject

@property(strong,nonatomic)NSString *  cardID;
@property(strong,nonatomic)NSString * name;
@property(assign,nonatomic,getter=isShowComment)BOOL showComment;
@property(assign,nonatomic,getter=isShowDownload)BOOL showDownload;
@property(assign,nonatomic,getter=isShowFav)BOOL showFav;
@property(assign,nonatomic,getter=isShowShare)BOOL showShare;

@end

/**
 *  简介配置模型
 */
@interface LTXMLPlayVideoInfoCardModel : NSObject

@property(strong,nonatomic)NSString *  cardID;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * defaultRowCount;
@end

/**
 *  踩、赞按钮配置模型
 */
@interface LTXMLPlayLikeBtnCardModel : NSObject

@property(strong,nonatomic)NSString *  cardID;
@property(strong,nonatomic)NSString * name;
@property(assign,nonatomic,getter=isShowLike)BOOL showLike;
@property(assign,nonatomic,getter=isShowUnLike)BOOL showUnLike;
@end


@interface LTXMLPlayTemplateDefaultRowCountModel : JSONModel

@property(strong,nonatomic)NSString * defaultRowCountA;
@property(strong,nonatomic)NSString * defaultRowCountB;
@property(strong,nonatomic)NSString * cardID;
@property(strong,nonatomic)NSString * cid;//非xml定义的
@end

@interface LTXMLPlayTemplateCardTypeModel : JSONModel

@property(strong,nonatomic)NSString *templateA;
@property(strong,nonatomic)NSString *templateB;
@property(strong,nonatomic)NSString * cardID;
@property(strong,nonatomic)NSString * cid;//非xml定义的
@end

/**
 *  最小粒度二级模板
 */
@interface LTXMLPlaySubTemplateModel : NSObject

@property(strong,nonatomic)NSString * name;             //模板名称
@property(strong,nonatomic)NSString * videoInfoRowCount;//简介行数
@property(strong,nonatomic)NSString * isShowComment;    //是否展示评论
@property(strong,nonatomic)NSString * isShowDownload;   //是否展示下载
@property(strong,nonatomic)NSString * isShowFav;        //是否展示收藏
@property(strong,nonatomic)NSString * isShowShare;      //是否展示分享
@property(strong,nonatomic)NSString * isShowLike;       //是否展示赞
@property(strong,nonatomic)NSString * isShowUnlike;     //是否展示踩
@property(strong,nonatomic)NSArray  * cardList;         //模板card列表  iphone使用
@property(strong,nonatomic)NSArray  * bottomCardList;   //模板card列表  ipad使用
@property(strong,nonatomic)NSArray  * rightCardList;    //模板card列表  ipad使用
@end

/**
 *  按cid区分的一级模板
 */
@interface LTXMLPlayCardTemplateModel : NSObject

@property(strong,nonatomic)NSString * templateName;
@property(strong,nonatomic)NSString * cid;
@property(strong,nonatomic)LTXMLPlaySubTemplateModel * templateA;
@property(strong,nonatomic)LTXMLPlaySubTemplateModel * templateB;
/**
 *  LTXMLPlayTemplateDefaultRowCountModel 以cardID为key写入的字典
 */
@property(strong,nonatomic)NSDictionary * defaultRowCounts;
/**
 *  LTXMLPlayTemplateCardTypeModel 以cardID为key写入的字典
 */
@property(strong,nonatomic)NSDictionary *cardTypes;

-(LTXMLPlayTemplateDefaultRowCountModel*)getDefaultRowCountWithCardID:(NSInteger)cardID;

- (LTXMLPlayTemplateCardTypeModel *)getXMLPlayTemplateCardTypeModelWithCardID:(NSInteger)cardID;

@end
