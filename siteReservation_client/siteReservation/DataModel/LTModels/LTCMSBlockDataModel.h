//
//  LTCMSBlockDataModel.h
//  LetvIpadClient
//
//  Created by bob on 14-9-16.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTMySelfFocusImageModel.h>

@interface LTCMSBlockDataModel : JSONModel

@property (strong, nonatomic) NSMutableArray<BlockContent, Optional> *blockContent; // 焦点图

@end
