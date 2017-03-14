//
//  GridViewListItem.h
//  siteReservation
//
//  Created by Nigel Lee on 14/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteMainListModel.h"

@interface GridViewListItem : UIView
@property (nonatomic, strong)UIImageView *sortIndetImageView;
@property (nonatomic, strong)CAShapeLayer *border;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)SiteMainListModel *maxModel;

- (void)setCellMaxViewModel:(SiteMainListModel *)model;
@end

typedef NS_ENUM(NSInteger ,EditorState)
{
    EditorStateNormal = 0 ,
    EditorStateDelete = 1 ,
    EditorStateAdd = 2,
    EditorStateSet = 3
};
