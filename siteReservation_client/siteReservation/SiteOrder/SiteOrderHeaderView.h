//
//  SiteOrderHeaderView.h
//  siteReservation
//
//  Created by Nigel Lee on 25/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>
#import "Global.h"

@protocol SiteOrderHeaderViewDelegate<NSObject>
- (void)showAnotherDay:(NSString *)title;
- (void)showCalendar; //展示日历
@end

@interface SiteOrderHeaderView : UIView
@property (nonatomic, weak) id<SiteOrderHeaderViewDelegate> delegate;
@end
