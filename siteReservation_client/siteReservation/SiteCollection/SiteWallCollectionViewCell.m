//
//  SiteWallCollectionViewCell.m
//  siteReservation
//
//  Created by Nigel Lee on 14/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteWallCollectionViewCell.h"

@implementation SiteWallCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 70, 70)];
//        _topImage.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:_topImage];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y + self.contentView.frame.size.height/2, 70, 30)];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor blueColor];
        _title.font = [UIFont systemFontOfSize:15];
        _title.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_title];
    }
    
    return self;
}
- (void)configCell:(SiteMainListModel *)dataModel
{
//    self.isShow = ![[NSString safeString:dataModel.lock] isEqualToString:@"locationSpace"];
//    self.isFixed = [[NSString safeString:dataModel.lock] isEqualToString:@"1"];
    if (dataModel) {
        [self.gridViewItem setCellMaxViewModel:dataModel];
    } else { // 无数据源的情况下的测试
        
    }
//    [self.contentView addSubview:self.title];
    
}

@end
