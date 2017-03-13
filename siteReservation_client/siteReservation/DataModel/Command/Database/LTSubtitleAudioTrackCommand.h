//
//  LTSubtitleAudioTrackCommand.h
//  LeTVMobileDataModel
//
//  Created by 彦芳 张 on 16/2/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/SqlDBHelper.h>
@interface LTSubtitleAudioTrackCommand : NSObject
@property (nonatomic,strong)NSString *subtitleKeyStr;//字幕key ie. 1002
@property (nonatomic,strong)NSString *audioKeyStr;//音轨key ie. 1003
@property (nonatomic,strong)NSString *videoPid;//视频专辑

-(LTSubtitleAudioTrackCommand *)initWithPid:(NSString *)pid subtitleKey:(NSString *)subKey audioKey:(NSString *)audioKey;
+(void)creatSubtitleTable;
+(LTSubtitleAudioTrackCommand*)searchSubtitleAudioKeyByPid:(NSString*)pid;
+(LTSubtitleAudioTrackCommand *)wrappResultSet:(id<PLResultSet>)rs;
+(void)insertSubtitle:(NSString *)subtitleKey audioKey:(NSString *)audioKey pid:(NSString *)pid;
+(void)deleteOldSubtitleAndAudioKey;
+(BOOL)hasSubtitleTable;
@end

