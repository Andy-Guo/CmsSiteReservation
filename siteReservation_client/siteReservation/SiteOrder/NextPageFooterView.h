//
//  NextPageFooterView.h
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum
{
    PullNextPagePulling = 0,    //网络错误的时候
    PullNextPageNormal,
    PullNextPageLoading,
    PullLastPage,
    PullNewLastPage,
} PullNextPageState;

@interface NextPageFooterView : UIView
{
    UILabel *statusLabel;
    CALayer *arrowImage;
    UIView *arrowView;
    UIActivityIndicatorView *activityView;
    
    PullNextPageState _state;
    BOOL isLastPage;
}

@property(strong,nonatomic)UIColor * loadingTextColor;
@property(strong,nonatomic)UIFont * loadingTextFont;
@property(nonatomic,assign) PullNextPageState state;
@property (nonatomic) BOOL isLastPage;
- (void)setState:(PullNextPageState)aState;

- (void)createFooterView;
- (void)createLastFooterView;

@end
