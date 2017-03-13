//
//  MyConcernModel.h
//  LeTVMobileDataModel
//
//  Created by liuhai on 15/9/14.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@interface MyConcernModelDetail : JSONModel
@property (nonatomic ,strong) NSString <Optional> *follow_id;
@property (nonatomic ,strong) NSString <Optional> * headimg;
@property (nonatomic ,strong) NSString <Optional> * follow_num;
@property (nonatomic ,strong) NSString <Optional> * nickname;
@end
@protocol MyConcernModelDetail
@end


@interface MyConcernModel : JSONModel
@property (nonatomic ,strong) NSString <Optional> * page;
@property (nonatomic ,strong) NSString <Optional> * count;
@property (nonatomic ,strong) NSArray <MyConcernModelDetail,Optional> * list;
@end


