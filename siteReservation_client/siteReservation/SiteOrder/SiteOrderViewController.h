//
//  SiteOrderViewController.h
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoNetworkView.h"
#import "SiteOrderHeaderView.h"
#import "SiteWallViewController.h"

@interface SiteOrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SiteOrderHeaderViewDelegate>
{
    NoNetworkView *_noNetworkView;             // 没有网络时显示的视图
}

@property (nonatomic, strong) UITableView *tableView;

@end
