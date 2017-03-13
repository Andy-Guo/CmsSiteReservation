//
//  LTSearchSuggestDataModel.h
//  LetvIphoneClient
//
//  Created by 吴彦伟 on 14-6-25.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTSearchSuggestDataItemModel <NSObject> @end

@interface LTSearchSuggestDataItemModel : JSONModel

@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *aid;
@property(nonatomic,strong)NSString<Optional> *vid;
@property(nonatomic,strong)NSString<Optional> *isEnd;

@end

@interface LTSearchSuggestDataModel : JSONModel

@property(nonatomic,strong)NSArray<LTSearchSuggestDataItemModel, Optional> *result;

@end
