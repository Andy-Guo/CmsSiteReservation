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
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x/2, self.contentView.frame.origin.y/2, self.frame.size.width, 30)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blueColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.backgroundColor = COMMON_COLOUR;
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}
- (void)configCell:(SiteMainListModel *)dataModel
{    
    if (dataModel) {
        [self.gridViewItem setCellMaxViewModel:dataModel];
    } else { // 无数据源的情况下的测试
        
    }
//    [self.contentView addSubview:self.title];
    
}

@end
