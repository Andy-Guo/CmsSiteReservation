//
//  LTMovieStatisticInfo.h
//  LetvIpadClient
//
//  Created by Letv on 14-9-20.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>

@interface LTMovieStatisticInfo : NSObject

@property (nonatomic) LTDCCodePlayFrom playFrom;
@property (nonatomic) NSInteger offSet;
@property (nonatomic, strong) NSString *ref;
@property (nonatomic, assign) BOOL isCancelAnimate;
@property (nonatomic, copy) NSString *utype ;// 手动｜自动 从m站跳转到app统计

@end
