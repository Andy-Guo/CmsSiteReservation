//
//  LTChannelIndexModelPBOC+Function.h
//  LeTVMobileDataModel
//
//  Created by dabao on 16/4/1.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LTDataCenter.h>
#import <LetvMobileDataModel/LTVideoAuxiliaryInfoManager.h>

@interface LTChannelIndexModelPBOC (Function)
- (void)removeInvalidData;
- (BOOL)isContainPageID:(NSString *)pageID;
- (BOOL)isContainFilter;

/**
 *  是否需要缓存数据
 *
 *  @return 返回YES需要，NO不需要
 */
- (BOOL)isShouldCache;
@end


@interface FilmListModelPBOC (Function)
- (NSString *)playCountTextFromPlayCount;
- (NSString *)getUpdateInfo;
- (BOOL)isValid;
- (NSString *)getIcon;
- (NSString *)getNewIcon;

/**
 *  是否是全景视频
 *
 *  @return
 */
- (BOOL)isPanorama;
@end

@interface ChannelListBlockModelPBOC (Function)
- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section flag:(NSString *)flag;
- (void)addStatisticAction:(LTDCPageID)pageID row:(NSInteger)index section:(NSInteger)section;

- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index;
- (void)addStatisticShow:(LTDCPageID)pageID index:(NSInteger)index flag:(NSString *)flag;

@end
