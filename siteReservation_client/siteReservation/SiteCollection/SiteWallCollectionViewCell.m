//
//  SiteWallCollectionViewCell.m
//  siteReservation
//
//  Created by Nigel Lee on 14/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteWallCollectionViewCell.h"

@implementation SiteWallCollectionViewCell


- (void)configCell:(SiteMainListModel *)dataModel
{
//    self.isShow = ![[NSString safeString:dataModel.lock] isEqualToString:@"locationSpace"];
//    self.isFixed = [[NSString safeString:dataModel.lock] isEqualToString:@"1"];
    if (dataModel) {
        [self.gridViewItem setCellMaxViewModel:dataModel];
    } else { // 无数据源的情况下的测试
        
    }
    
}

@end
