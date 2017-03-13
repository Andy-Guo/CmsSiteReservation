//
//  WaterMarkModel.h
//  LeTVMobileDataModel
//
//  Created by zyf on 15/1/21.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol WaterMarkDataModel @end

@interface WaterMarkDataModel :JSONModel
@property (nonatomic,strong) NSString <Optional>*lasttime;
@property (nonatomic,strong) NSString <Optional>*link;
@property (nonatomic,strong) NSString <Optional>*position;
@property (nonatomic,strong) NSString <Optional>*url;
@property (nonatomic,strong) NSString <Optional>*size;
@end

@interface WaterMarkResultModel : JSONModel
@property (nonatomic,strong) NSString <Optional>*cid;
@property (nonatomic,strong) NSMutableArray <WaterMarkDataModel> *data;
@property (nonatomic,strong) NSString <Optional>*offset;
@property (nonatomic,strong) NSString <Optional>*pid;
@end

@interface WaterMarkModel : JSONModel
@property (nonatomic,strong)WaterMarkResultModel<Optional> *result;

@end

