//
//  LTTVODPayModel.h
//  LetvMobileClient
//
//  Created by dullgrass on 17/2/15.
//  Copyright © 2017年 LeEco. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@interface LTTVODPayModel : JSONModel

@property (nonatomic,strong) NSString *videoPrice;       //!< 影片价格
@property (nonatomic,strong) NSString *vipVideoPrice;    //!< 会员影片价格
@property (nonatomic,strong) NSString *videoProductID;   //!< 影片ProductID
@property (nonatomic,strong) NSString *vipVideoProductID;//!< 会员影片ProductID

@property (nonatomic,strong) NSString *payVideoPrice;    //!< 用于购买的影片价格
@property (nonatomic,strong) NSString *payVideoProductID;   //!< 用于购买影片ProductID

@property (nonatomic,strong) NSString *videoName;        //!< 影片名称
@property (nonatomic,strong) NSString *validDays;
@property(nonatomic, assign)  LTMoviePlayerStyle playerStyle;

@end
