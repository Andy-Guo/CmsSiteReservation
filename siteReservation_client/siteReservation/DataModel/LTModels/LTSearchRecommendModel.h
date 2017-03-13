//
//  LTSearchRecommendModel.h
//  LetvIphoneClient
//
//  Created by bob on 14-3-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>


@protocol LTSearchRecommendData <NSObject> @end

@interface LTSearchRecommendData : JSONModel

@property (nonatomic, strong) NSString<Optional> *cid;
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *src;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *subtitle;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *pic_st;
@property (nonatomic, strong) NSString<Optional> *pic_ht;
@property (nonatomic, strong) NSString<Optional> *url;

//以前的
@property (nonatomic, strong) NSString<Optional> *subname;
@property (nonatomic, strong) NSString<Optional> *picST;
@property (nonatomic, strong) NSString<Optional> *picHT;
@property (nonatomic, strong) NSString<Optional> *isEnd;
@property (nonatomic, strong) NSString<Optional> *episode;
@property (nonatomic, strong) NSString<Optional> *nowEpisodes;
@property (nonatomic, strong) NSString<Optional> *jump;
@property (nonatomic, strong) NSString<Optional> *pay;

@end

@protocol LTSearchRecommendArrayItem <NSObject> @end

@interface LTSearchRecommendArrayItem : JSONModel

@property (nonatomic, strong) NSArray<LTSearchRecommendData, Optional> *data;
@property (nonatomic, strong) NSString<Optional> *name;

@end


@interface LTSearchRecommendModel : JSONModel

@property (nonatomic, strong) NSArray<LTSearchRecommendArrayItem, Optional> *recommend;

@end

