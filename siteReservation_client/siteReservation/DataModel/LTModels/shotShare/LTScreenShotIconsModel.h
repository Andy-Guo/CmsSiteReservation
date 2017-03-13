//
//  LTScreenShotIconsModel.h
//  LeTVMobileDataModel
//
//  Created by 韩阳 on 15/11/19.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@interface LTScreenShotIconSubListMoel : JSONModel
@property(nonatomic,strong) NSString <Optional> *pic1;
@property(nonatomic,strong) NSString <Optional> *pic1_s;
@property(nonatomic,strong) NSString <Optional> *pic1_1_b;
@property(nonatomic,strong) NSString <Optional> *pic1_2_b;
@property(nonatomic,strong) NSString <Optional> *pic2;
@property(nonatomic,strong) NSString <Optional> *pic2_s;
@property(nonatomic,strong) NSString <Optional> *pic2_1_b;
@property(nonatomic,strong) NSString <Optional> *pic2_2_b;
@property(nonatomic,strong) NSString <Optional> *pic3;
@property(nonatomic,strong) NSString <Optional> *pic3_s;
@property(nonatomic,strong) NSString <Optional> *pic3_1_b;
@property(nonatomic,strong) NSString <Optional> *pic3_2_b;
@property(nonatomic,strong) NSString <Optional> *pic_bigback;
@end

@interface LTScreenShotIconListMoel : JSONModel
@property(nonatomic,strong) NSString <Optional> *cid;
@property(nonatomic,strong) LTScreenShotIconSubListMoel <Optional> *picList;
@end

@protocol LTScreenShotIconListMoel

@end

@interface LTScreenShotIconsModel : JSONModel
@property(nonatomic,strong) NSArray <LTScreenShotIconListMoel,Optional> *data;
@end
