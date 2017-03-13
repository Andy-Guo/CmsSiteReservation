//
//  LTDownTasker.h
//  LeTVMobileDownloader
//
//  Created by dong on 15/11/9.
//  Copyright © 2015年 Letv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTDownTasker : NSObject

@property (nonatomic, assign) long long downloadSize;
@property (nonatomic, strong) NSString * downVid;
@property (nonatomic, strong) NSString * downSpeed;
@property (nonatomic, strong) NSDate * downDate;
@property (nonatomic, assign) NSInteger download_status;
@property (nonatomic, strong) NSString * fileSize;
//@property (nonatomic, assign) long long download_Size;

- (id)initWithVid:(NSString *)vid andFileSize:(NSString *)size;
- (void) calculateSpeed:(long long)bufferData andDownLoadSize:(long long)downsize;

- (NSString *)convertionDownLoadSpeed:(long long)speed;

@end
