//
//  SiteWallCollectionViewCell.h
//  siteReservation
//
//  Created by Nigel Lee on 14/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteMainListModel.h"
#import "DataModelCommDef.h"
#import "GridViewListItem.h"

@interface SiteWallCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>
@property (nonatomic, strong)GridViewListItem *gridViewItem;
@property (nonatomic, strong)UIButton *deleteButton;
@property (nonatomic, assign)BOOL isFixed;
@property (nonatomic, copy) void (^itemLongPressedOperationBlock)(UILongPressGestureRecognizer *longPressed);

//- (void)changeContentViewWithState:(EditorState)state;
- (void)configCell:(SiteMainListModel *)dataModel;

@end
