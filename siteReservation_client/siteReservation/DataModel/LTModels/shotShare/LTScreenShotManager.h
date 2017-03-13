//
//  LTScreenShotManager.h
//  LeTVMobileDataModel
//
//  Created by 韩阳 on 15/12/3.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTScreenShotManager : NSObject
@property (nonatomic, assign) NSTimeInterval currentShotPlayTime;
@property (nonatomic, strong) UIImage *currentShotImage;
@end
