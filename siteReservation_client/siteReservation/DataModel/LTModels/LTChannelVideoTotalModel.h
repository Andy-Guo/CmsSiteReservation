//
//  LTChannelVideoTotalModel.h
//  LetvIphoneClient
//
//  Created by wangduan on 14-5-15.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>


@protocol LTChannelVideoTotalListModel @end
@interface LTChannelVideoTotalListModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *cid;                // String	频道id
@property (strong, nonatomic) NSString<Optional> *update_num;           //，更新数。
@end

@interface LTChannelVideoTotalModel : JSONModel

@property (strong, nonatomic)NSMutableArray<LTChannelVideoTotalListModel, Optional>* channel;


@end
