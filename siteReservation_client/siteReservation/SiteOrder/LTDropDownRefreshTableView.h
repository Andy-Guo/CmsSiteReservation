//
//  LTDropDownRefreshTableView.h
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextPageFooterView.h"

@protocol LTDropDownRefreshViewDelegate;
@interface LTDropDownRefreshTableView : UITableView
{
    UIImageView *tableHeaderView;
    NextPageFooterView   *tableFooterView;
    BOOL    isGettingNextPage;
}

@property(nonatomic, weak)id<LTDropDownRefreshViewDelegate>  refreshDelegate;

- (void)refreshTableViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshTableViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
