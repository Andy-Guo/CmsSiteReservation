//
//  LTSubjectVideoPBOC+Share.h
//  LeTVMobileDataModel
//
//  Created by zhangyongtao on 16/5/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileProtobuf/LetvMobileProtobuf.h>

@interface LTSubjectVideoPBOC (Share)

- (NSString*)getMinSizeImage;
- (BOOL)isPlaySupported;
- (BOOL)isDownloadSupported;
- (BOOL)isAlreadyDownloadComplete;

@end
