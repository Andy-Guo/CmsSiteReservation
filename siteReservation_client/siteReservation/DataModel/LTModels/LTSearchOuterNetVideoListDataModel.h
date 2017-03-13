//
//  LTSearchOuterNetVideoListDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-11.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTSearchOuterNetVideoData @end
@interface LTSearchOuterNetVideoData : JSONModel
@property (nonatomic, strong) NSString<Optional> *aorder;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *url;
@end

@interface LTSearchOuterNetVideoListDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTSearchOuterNetVideoData, Optional> *video_list;
@end

