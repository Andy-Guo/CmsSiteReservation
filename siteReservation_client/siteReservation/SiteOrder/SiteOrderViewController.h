//
//  SiteOrderViewController.h
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoNetworkView.h"

@interface SiteOrderViewController : UIViewController
{
    NoNetworkView *_noNetworkView;             // 没有网络时显示的视图
}

@end
