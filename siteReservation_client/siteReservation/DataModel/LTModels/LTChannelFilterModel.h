//
//  LTChannelFilterModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-11-6.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTFilterParamModel @end
@interface LTFilterParamModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *key;
@property(nonatomic,strong)NSString<Optional> *value;
@end

@protocol LTFilterValueModel @end
@interface LTFilterValueModel:JSONModel
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *opposite;   // 是否单视频，走单视频检索接口
@property(nonatomic,strong)NSArray<LTFilterParamModel, Optional> *param;
@end

@protocol LTFilterKeyModel @end
@interface LTFilterKeyModel:JSONModel
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *selectIndex;
@property(nonatomic,strong)NSMutableArray<LTFilterValueModel,Optional> *items;
@end

@protocol LTFilterModel @end
@interface LTFilterModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *cid;
@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSArray<LTFilterKeyModel,Optional> *types;

- (BOOL)isFilterModelValuesExist;

@end

@interface LTChannelFilterModel : JSONModel
@property(nonatomic,strong)NSArray<LTFilterModel,Optional> *data;
@end

