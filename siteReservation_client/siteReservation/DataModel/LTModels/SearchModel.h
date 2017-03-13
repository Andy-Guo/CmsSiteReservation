//
//  SearchModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-5.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/OldMovieDetailModel.h>


@interface SearchSuggestModel : JSONModel

@property (strong, nonatomic) NSArray<Optional>* suggest;

@end

@protocol HotWordsModel @end
@interface HotWordsModel : JSONModel
@property (strong, nonatomic) NSString<Optional>* keyword; //String 搜索关键词

@end

@interface SearchHotWordsModel : JSONModel

@property (strong, nonatomic) NSArray<HotWordsModel,Optional>* hotwords;
@property (strong, nonatomic) NSString<Optional>* searchwords; //String 搜索默认词

@end

@protocol SearchSubNavModel @end
@interface SearchSubNavModel : JSONModel

@property (strong, nonatomic)  NSString<Optional>* cid;  //频道cid
@property (strong, nonatomic)  NSString<Optional>* cname; //频道名称
@property (strong, nonatomic) NSString<Optional>* num; //String 搜索结果数
@property (strong, nonatomic) NSString<Optional>* show; //String 是否显示，1：显示 0：不显示
 
@end

@interface SearchModel : JSONModel

@property (strong, nonatomic) NSMutableArray<OldMovieDetailModel,Optional>* data;
@property (strong, nonatomic) NSArray<SearchSubNavModel,Optional>* subNav;
@property (strong, nonatomic) NSString<Optional>* total;
@property (strong, nonatomic) NSArray<OldMovieDetailModel,Optional>*film;
@property (strong, nonatomic) NSArray<OldMovieDetailModel,Optional>*tv;

- (BOOL)isEmptyResult;
- (BOOL)totalValueExist;
- (NSMutableArray *)dataArray;
- (OldMovieDetailModel *)dataModel:(NSInteger)index;
- (SearchSubNavModel *)subNavModel:(NSInteger)index;
- (NSMutableArray *)getSpec:(OldMovieDetailModel *)dataModel;

- (NSString *)getUpdateInfoAtIndex:(NSInteger)index isNeedEndInfo:(BOOL)bNeedEndInfo DataArray:(NSMutableArray *)array;
@end
