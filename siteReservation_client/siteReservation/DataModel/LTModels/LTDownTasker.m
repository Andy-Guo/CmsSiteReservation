//
//  LTDownTasker.m
//  LeTVMobileDownloader
//
//  Created by dong on 15/11/9.
//  Copyright © 2015年 Letv. All rights reserved.
//

#import "LTDownTasker.h"

@implementation LTDownTasker

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (id)initWithVid:(NSString *)vid andFileSize:(NSString *)size
{
    if(self = [super init]){
        self.downVid = vid;
        self.fileSize = size;
        self.downDate = [NSDate date];
        self.downSpeed = @"0 KB/s";
    }
    return self;
}

- (void) calculateSpeed:(long long)bufferData andDownLoadSize:(long long)downsize
{
    long long currentsize = self.downloadSize + bufferData;
    self.downloadSize = currentsize;
    NSDate *currentDate = [NSDate date];
    if ([currentDate timeIntervalSinceDate:self.downDate] >= 1) {
        self.downSpeed = [self convertionDownLoadSpeed:self.downloadSize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CalculateDownSpeed" object:self];
        self.downloadSize = 0.f;
        self.downDate = currentDate;
    }
}

- (NSString *)convertionDownLoadSpeed:(long long)speed
{
    speed = speed / 1024;
    if ((speed <= 0)) {
        return [NSString stringWithFormat:@"0 KB/s"];
    }else if(speed <= 1024){
        return [NSString stringWithFormat:@"%lldKB/s",speed];
    }else if((speed > 1024)&&(speed <= 1024*1024)){
        return [NSString stringWithFormat:@"%.1fMB/s",(float)speed/1024];
    }
    return [NSString stringWithFormat:@"%.1fGB/s",(float)speed/1024/1024];
}
/*缓存速度的显示(显示固定位数，其他四舍五入)
 1、当速度小于0时，不显示速度。
 ——0KB/s<速度<1000KB/s 显示XXXKB/s
 ——1000KB/s<=速度<1000MB/s 显示XXX.XMB/s
 ——1000MB/s<=速度 显示XXX.XGB/s
 */

@end
