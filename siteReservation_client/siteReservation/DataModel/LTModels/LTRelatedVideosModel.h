//
//  LTRelatedVideosModel.h
//  LetvIpadClient
//
//  Created by liuxuan on 14-9-12.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/PicCollectionModel.h>

@protocol LTRelatedVideoItem

@end

@interface LTRelatedVideoItem : JSONModel

@property(strong,nonatomic)NSString<Optional>*vid;
@property(strong,nonatomic)NSString<Optional>*cid;
@property(strong,nonatomic)NSString<Optional>*nameCn;
@property(strong,nonatomic)NSString<Optional>*subTitle;
@property(strong,nonatomic)NSString<Optional>*singer;
@property(strong,nonatomic)NSString<Optional>*type;
@property(strong,nonatomic)NSString<Optional>*btime;
@property(strong,nonatomic)NSString<Optional>*etime;
@property(strong,nonatomic)NSString<Optional>*duration;
@property(strong,nonatomic)NSString<Optional>*mid;
@property(strong,nonatomic)NSString<Optional>*episode;
@property(strong,nonatomic)NSString<Optional>*porder;
@property(assign,nonatomic)BOOL pay;
@property(assign,nonatomic)BOOL download;
@property(assign,nonatomic)BOOL play;
@property(assign,nonatomic)BOOL jump;
@property(strong,nonatomic)PicCollectionModel<Optional>*picCollections;

@end

@interface LTRelatedVideosModel : JSONModel

@property(strong,nonatomic)NSArray<LTRelatedVideoItem,ConvertOnDemand>*videoInfo;//半屏相关系列
@end
