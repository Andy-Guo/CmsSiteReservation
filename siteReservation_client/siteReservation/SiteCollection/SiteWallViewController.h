//
//  SiteWallViewController.h
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteMainListModel.h"
#import "DataModelCommDef.h"
#import "SiteWallCollectionViewCell.h"

@interface SiteWallViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *siteCollectionView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, strong) NSIndexPath *currentPressIndexPath;
@property (nonatomic, strong) UIView *startCellBorderView;
@property (nonatomic, strong) UIView *endCellBorderView;
@property (nonatomic, strong) SiteMainListModel *siteModel;
@property (nonatomic, strong) SiteMainListModel *otherSiteMode;
//@property (nonatomic, strong) LTChannelWallReusableView *headOneReusableView;
//@property (nonatomic, strong) LTChannelWallReusableView *headTwoReusableView;
@property (nonatomic, strong) UIView *sectionOneView;
@property (nonatomic, strong) UIView *sectionTwoView;
@property (nonatomic, strong) UILabel *lblTip;
@property (nonatomic, strong) UIImageView *noDataImageView;

@end
