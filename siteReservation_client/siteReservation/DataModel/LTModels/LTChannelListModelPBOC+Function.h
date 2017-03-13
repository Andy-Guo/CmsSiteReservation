//
//  LTChannelListModelPBOC+Function.h
//  LeTVMobileDataModel
//
//  Created by dabao on 16/4/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

//#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
#import <LetvMobileProtobuf/LetvMobileProtobuf.h>

@interface LTChannelListModelPBOC (Function)

@end

@interface LTChannelAlbumListModelPBOC (Function)
- (NSInteger)episode;
- (NSInteger)nowEpisodes;
- (BOOL)pay;
- (BOOL)jump;

- (NSString *)getIcon;
- (NSString *)getUpdateInfo;
- (NSString *)getUpdateInfoWithCid:(NewMovieCid)cid;
- (NSString *)getUpdateInfoNew;
@end
