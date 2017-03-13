//
//  LTRequestURLInfo.h
//  LetvIphoneClient
//
//  Created by zhaocy on 14-5-12.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTRequestURLDefine.h>

@interface LTRequestURLInfo : NSObject

@property(nonatomic, assign) LTRequestURLDomainType urlDomainType;  // 域名分类
@property(nonatomic, assign) LTRequestURLType urlType;              // 地址类型
@property(nonatomic, strong)  NSMutableArray  *urlParams;           // 参数
@property(nonatomic, strong) NSMutableArray   *urlHeadParams;      //url头需要传的参数
@property(nonatomic, strong) NSString *urlHeadPath; //url头的path，需要带问号
@end
