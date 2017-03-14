//
//  SiteWallViewController.m
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteWallViewController.h"
#import "SiteMainListModel.h"
#import "DataModelCommDef.h"
#import "SiteWallCollectionViewCell.h"

static NSString *cellIdentifier = @"SiteWallCollectionViewCell";

@interface SiteWallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) NSMutableArray *cellAttributesArray;
@property (nonatomic, strong) NSIndexPath *currentPressIndexPath;
@property (nonatomic, strong) UIView *startCellBorderView;
@property (nonatomic, strong) UIView *endCellBorderView;
@property (nonatomic, strong) SiteMainListModel *siteModel;
@property (nonatomic, strong) SiteMainListModel *otherSiteMode;
//@property (nonatomic, strong) LTChannelWallReusableView *headOneReusableView;
//@property (nonatomic, strong) LTChannelWallReusableView *headTwoReusableView;
@property (nonatomic, strong) UIView *collectionbgView;
@property (nonatomic, strong) UIView *sectionOneView;
@property (nonatomic, strong) UIView *sectionTwoView;
@property (nonatomic, strong) UILabel *lblTip;
@property (nonatomic, strong) UIImageView *noDataImageView;
@end

@implementation SiteWallViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteWallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   
    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section == 0) {
        
        if (_siteModel.site.count > indexPath.item) {
            
            // 数据解析
            SiteMainListModel *dataModel = (SiteMainListModel *)[_siteModel.site objectAtIndex:indexPath.item];
            [cell configCell:dataModel];
//            if (self.isSort && !cell.isFixed && cell.isShow) {
//                cell.isLongPress = NO;
//                [cell changeContentViewWithState:EditorStateDelete];
//            }else {
//                
//                [cell changeContentViewWithState:EditorStateNormal];
//            }
        }
        
    } else {
//        if (_siteModel.otherSite.count > indexPath.item) {
//            LTNewChannelMainListModel *dataModel = (LTNewChannelMainListModel *)[_channelWallModel.otherChannel objectAtIndex:indexPath.item];
//            
//            [cell configCell:dataModel];
//            if (self.isSort && !cell.isFixed && cell.isShow) {
//                cell.isLongPress = NO;
//                [cell changeContentViewWithState:EditorStateAdd];
//            }else {
//                if (_channelWallModel.otherChannel.count == 1) {
//                    LTNewChannelMainListModel *model = _channelWallModel.otherChannel[0];
//                    if ([[NSString safeString:model.lock] isEqualToString:@"locationSpace"]) {
//                        [cell changeContentViewWithState:EditorStateSet];
//                    }else{
//                        [cell changeContentViewWithState:EditorStateNormal];
//                    }
//                }else{
//                    [cell changeContentViewWithState:EditorStateNormal];
//                }
//            }
//        }
    }
    
    cell.itemLongPressedOperationBlock = ^(UILongPressGestureRecognizer *longPressed){

    };
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
