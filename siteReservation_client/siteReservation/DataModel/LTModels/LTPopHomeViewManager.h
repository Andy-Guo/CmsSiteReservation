//
//  LTPopHomeViewManager.h
//  LetvIphoneClient
//
//  Created by dabao on 15/11/19.
//  只用于App首页弹框处理逻辑，不用与其他地方的。
//

#import <Foundation/Foundation.h>

@interface LTPopHomeViewManager : NSObject
+ (LTPopHomeViewManager *)shareClient;

/**
 *  默认是YES，什么时候不弹就赋值为NO
 */
@property (nonatomic, assign) BOOL showPopView;
@end
