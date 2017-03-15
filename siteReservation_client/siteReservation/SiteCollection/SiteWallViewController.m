//
//  SiteWallViewController.m
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteWallViewController.h"

static NSString *cellIdentifier = @"SiteWallCollectionViewCell";
static NSString * const reuseIdentifier = @"Cell";

@interface SiteWallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation SiteWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.siteCollectionView = [[UICollectionView alloc] init];
    [self.siteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.siteCollectionView setCollectionViewLayout:flowLayout];
    
    self.siteCollectionView.frame = CGRectMake(0, 60, 320, 500);
    self.siteCollectionView.backgroundColor = [UIColor whiteColor];
    self.siteCollectionView.delegate = self;
    self.siteCollectionView.dataSource = self;
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteWallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configCell];
   
//    __weak typeof(self) weakSelf = self;
    
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
    
    // Configure the cell
    
    return cell;
}



#pragma mark - set_and_get
-(UICollectionView *)collectionView{
    if (!_siteCollectionView) {
        //自动网格布局
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //网格布局
        _siteCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        //注册cell
        [_siteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        //设置数据源代理
        _siteCollectionView.dataSource = self;
    }
    return _siteCollectionView;
    
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
