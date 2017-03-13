//
//  LTCloudCollectModel.m
//  LetvIphoneClient
//
//  Created by wangduan on 14-3-31.
//
//

#import "LTCloudFollowModel.h"
//#import "NSString+HTTPExtensions.h"
#import "HistoryCommand.h"

@implementation LTCloudFollowItemModel

-(MovieInfo *)wrapResultSet
{
    MovieInfo *movieInfo = [[MovieInfo alloc] init];
    
#ifdef LT_IPAD_CLIENT
    
#else
    movieInfo.cid = self.cid;
    movieInfo.p_ID = self.pid;
    movieInfo.v_ID = self.id;
    movieInfo.videoType = [self.category integerValue];
    movieInfo.title = self.title;
    if (![NSString isBlankString:self.vid]) {
        movieInfo.movie_ID = self.vid;
    }
    else
    {
        movieInfo.movie_ID = self.pid;
    }
    movieInfo.data_type = DATA_TYPE_FAVORITE;
    movieInfo.icon = self.pic;
    movieInfo.lastRecordTime = nil;
#endif
    return movieInfo;
}

@end


@implementation LTCloudFollowModel
//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"description"  : @"desc",
//                                                       }];
//}

@end
