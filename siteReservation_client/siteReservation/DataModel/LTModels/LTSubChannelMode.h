//
//  LTSubChannelMode.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-5.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/OldMovieDetailModel.h>

@interface LTSubChannelMode : JSONModel

@property (strong, nonatomic) NSString<Optional> *__total;
@property (strong, nonatomic) NSMutableArray<OldMovieDetailModel,Optional>* data;

- (NSInteger)total;

- (NSMutableArray *)getSpecAtIndex:(NSInteger)index
                         ChannelID:(ChannelID)channelID
                       VideoSource:(VIDEOSOURCE)videoSource
                         DataArray:(NSMutableArray *)array;
- (NSString *)getUpdateInfoAtIndex:(NSInteger)index isNeedEndInfo:(BOOL)bNeedEndInfo DataArray:(NSMutableArray *)array;
- (BOOL)isJujiAtIndex:(NSInteger)index DataArray:(NSMutableArray *)array ;
@end
