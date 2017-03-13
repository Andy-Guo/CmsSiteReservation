//
//  LTScreenShotTextModel.h
//  LeTVMobileDataModel
//
//  Created by 韩阳 on 15/7/27.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol LTShotShareTextSubList;
@interface LTScreenShotTextModel : JSONModel
@property(nonatomic,strong) NSString <Optional> *contentName;
@property(nonatomic,strong) NSString <Optional> *contentId;
@property(nonatomic,strong) NSArray <LTShotShareTextSubList,Optional> *blockContents;

@end

@interface LTShotShareTextSubList : JSONModel
@property(nonatomic, strong) NSString <Optional> *remark;
@end

