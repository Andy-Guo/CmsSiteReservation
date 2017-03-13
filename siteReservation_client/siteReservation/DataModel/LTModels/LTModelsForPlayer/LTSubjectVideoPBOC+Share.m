//
//  LTSubjectVideoPBOC+Share.m
//  LeTVMobileDataModel
//
//  Created by zhangyongtao on 16/5/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "LTSubjectVideoPBOC+Share.h"
#import "LTDownloadCommand.h"

@implementation LTSubjectVideoPBOC (Share)

-(NSString*)getMinSizeImage
{
    if (![NSString isBlankString:self.pic320_200]) {
        return self.pic320_200;
    }else{
        return self.pic400_300;
    }
}

- (BOOL)isPlaySupported
{
    return ([self.play integerValue] > 0);
}

- (BOOL)isDownloadSupported
{
    return ([self.download integerValue] > 0);
}

- (BOOL)isAlreadyDownloadComplete{
    
    LTDownloadCommand *downloadInfo = [LTDownloadCommand searchByVID:self.vid];
    if (nil != downloadInfo) {
        enum DownloadStatus status = (enum DownloadStatus)[downloadInfo.download_status intValue];
        return (DownloadStatusComplete == status);
    }
    
    return NO;
}

@end
