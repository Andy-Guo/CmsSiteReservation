//
//  LTLoadingImageCommand.h
//  LeTVMobileDataModel
//
//  Created by LETV-Daemonson on 15/10/10.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTLoadingImageCommand.h>

@interface LTLoadingImageCommand : NSObject
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *imagePath;

/* 根据vid查询 */
+ (NSString *) searchLoadingImageByVid:(NSString *)vid pid:(NSString *)pid;
//直播
+ (NSString *) searchLiveLoadingImageByLiveId:(NSString *)vid;

/* 根据vid和pid存图片 */
+ (void) saveLoadingImageByVid:(NSString *)vid pid:(NSString *)pid imagePath:(NSString*)imgPath;
@end
