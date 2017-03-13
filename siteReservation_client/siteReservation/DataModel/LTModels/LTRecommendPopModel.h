//
//  LTRecommendPopModel.h
//  LetvIphoneClient
//
//  Created by bob on 14-4-8.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTRecommendPopModel <NSObject>

@end

@interface LTRecommendPopModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *icon;

@end


@interface LTRecommendPopModelArray : JSONModel

@property (nonatomic, strong) NSArray<LTRecommendPopModel, Optional> *exchange;

@end

