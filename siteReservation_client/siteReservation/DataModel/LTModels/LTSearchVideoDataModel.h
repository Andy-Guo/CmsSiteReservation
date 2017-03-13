//
//  LTSearchVideoDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-10.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTSearchDataModel.h>

/**
    用于搜索明星下的单视频
 */

@interface LTSearchVideoDataModel : JSONModel

@property(nonatomic, strong) NSArray<LTSearchVideoData, Optional> *video_list;
@property(nonatomic, strong) NSString<Optional> *video_count;

@end
