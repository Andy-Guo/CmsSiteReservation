//
//  LTDataInfo.h
//  LetvIpadClient
//
//  Created by iosdev on 14-10-9.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileDataModel/LTDataCenterEnumDef.h>
#import <LetvMobileDataModel/LTDataCenterCommDef.h>

@interface LTDataInfo : NSObject

@property(nonatomic,assign) LTDCActionPropertyCategory  acode;   //动作类型
@property(nonatomic,assign) LTDCPageID  pageID;     //页面id
@property(nonatomic,assign) NSInteger  wz;
@property(nonatomic,assign) NSInteger  selectRow;

@property(nonatomic,strong) NSString *speedString;

@property (nonatomic, copy) NSDictionary *pushMsg; // 推送内容(目前只用于直播)

@property (nonatomic, copy) NSString *msiteFrom;   // M站调起来源

+ (LTDataInfo *)sharedInstance;

@end
