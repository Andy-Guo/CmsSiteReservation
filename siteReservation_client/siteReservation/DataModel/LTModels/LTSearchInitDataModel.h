//
//  LTSearchInitDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-7.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTSearchInitDataSrc @end
@interface LTSearchInitDataSrc : JSONModel
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@end

@protocol LTSearchInitDataChannel @end

@interface LTSearchInitDataChannel : JSONModel
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@end

@interface LTSearchInitDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTSearchInitDataChannel, Optional> *channel;
@property (nonatomic, strong) NSArray<LTSearchInitDataSrc, Optional> *srclist;
@end
