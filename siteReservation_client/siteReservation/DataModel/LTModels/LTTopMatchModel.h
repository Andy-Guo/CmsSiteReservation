//
//  LTTopMatchModel.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-4-25.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTImageUrlItemModel @end
@interface LTImageUrlItemModel : JSONModel //主客队国旗
@property(strong, nonatomic) NSString<Optional>* icon100_100;
@property(strong, nonatomic) NSString<Optional>* icon120_90;
@end


@protocol LTTopMatchItemModel @end
@interface LTTopMatchItemModel : JSONModel
@property (strong, nonatomic) NSString<Optional>*                      matchId;      //赛事id
@property (strong, nonatomic) NSString<Optional>*                      matchTime;    //比赛时间
@property (strong, nonatomic) NSString<Optional>*                      homeGamer;    //主队名称
@property (strong, nonatomic) NSString<Optional>*                      awayGamer;    //客队名称
@property (strong, nonatomic) NSString<Optional>*                      matchState;     //比赛状态(1、未开始 2、直播中 3、已结束)
@property (strong, nonatomic) NSString<Optional>*                      homeScore;    //主队得分
@property (strong, nonatomic) NSString<Optional>*                      awayScore;    //客队得分
@property (strong, nonatomic) LTImageUrlItemModel<Optional>*           homeImageUrl; //主队国旗
@property (strong, nonatomic) LTImageUrlItemModel<Optional>*           awayImageUrl; //客队国旗
@property (strong, nonatomic) NSString<Optional>*                      groups;       //分组
@property (strong, nonatomic) NSString<Optional>*                      vid;          //视频id
@property (strong, nonatomic) NSString<Optional>*                      url;          //集锦地址(比赛已结束)、投注地址(比赛未结束)
@property (strong, nonatomic) NSString<Optional>*                      url1;         //专题地址(比赛已结束)、竞猜地址(比赛未结束)
@property (strong, nonatomic) NSString<Optional>*                      url_more;     //更多地址
@property (strong, nonatomic) NSString<Optional>*                      homeGamerKey; //主队ID
@property (strong, nonatomic) NSString<Optional>*                      awayGamerKey; //客队ID
@property (strong, nonatomic) NSString<Optional>*                      homeGamerUrl; //主队url
@property (strong, nonatomic) NSString<Optional>*                      awayGamerUrl; //主队url

@end
@interface LTTopMatchModel : JSONModel
@property (strong, nonatomic) NSArray<LTTopMatchItemModel,Optional>* match;
@end
