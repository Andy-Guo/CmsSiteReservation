//
//  LTSearchVideoSourceDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-11.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>


@protocol LTSearchVideoSourceData @end
@interface LTSearchVideoSourceData : JSONModel
@property (nonatomic, strong) NSString<Optional> *src;      // 数据源：1-站内 2-站外
@property (nonatomic, strong) NSString<Optional> *vrsAid;   // 内网专辑id
@property (nonatomic, strong) NSString<Optional> *aid;      // 外网和内网关联专辑id
@property (nonatomic, strong) NSString<Optional> *site;     // 数据源
@end


@interface LTSearchVideoSourceDataModel : JSONModel

@property (nonatomic, strong) NSArray<LTSearchVideoSourceData, Optional> *src_list;

@end
