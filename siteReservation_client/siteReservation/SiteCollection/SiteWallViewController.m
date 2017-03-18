//
//  SiteWallViewController.m
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteWallViewController.h"

static NSString *kSiteWallCollectionViewCellIdentifier = @"SiteWallCollectionViewCell";
static NSString * const reuseIdentifier = @"Cell";

@interface SiteWallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation SiteWallViewController

#pragma mark - lifeCycle
- (id)initWithLayout:(UICollectionViewFlowLayout *)flowLayout
{
    if (self = [super init]) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight-64) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.backgroundColor = [UIColor blackColor]; // 设置导航栏背景颜色    [self initCollectionView];
     [self initCollectionView];
}

- (void)initCollectionView
{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 10;
    //最小两行之间的间距
    layout.minimumLineSpacing = 10;
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(self.navigationController.view.frame.origin.x, self.navigationController.view.frame.origin.y + self.navigationController.view.frame.size.height , kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    // 注册要复用的cell
    [self.collectionView registerClass:[SiteWallCollectionViewCell class] forCellWithReuseIdentifier:kSiteWallCollectionViewCellIdentifier];
    if (!_cellAttributesArray) {
//        _cellAttributesArray = [[NSArray alloc]init];
//        _cellAttributesArray = @[@"8.00",@"9.00",@"10.00",@"11.00",@"12.00",@"13.00",@"14.00",@"15.00",@"16.00",@"17.00",@"18.00",@"19.00",@"20.00",@"21.00",@"22.00",@"23.00"];
    }
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _cellAttributesArray.count;
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteWallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSiteWallCollectionViewCellIdentifier forIndexPath:indexPath];
   
//    __weak typeof(self) weakSelf = self;
    
    if (indexPath.section == 0) {
        
        if (_siteModel.site.count > indexPath.item) {
            
            // 数据解析
            SiteMainListModel *dataModel = (SiteMainListModel *)[_siteModel.site objectAtIndex:indexPath.item];
            [cell configCell:dataModel];
//            }
        }
        
    } else {

    }
    
    // Configure the cell
    [cell configCell:nil];
    cell.gridViewItem.backgroundColor = COMMON_COLOUR;
    cell.title.text=[NSString stringWithFormat:@"%ld",indexPath.section*100+indexPath.row];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    return cell;
}



#pragma mark - set_and_get


#pragma mark <UICollectionViewDelegate>
//头部和脚部的加载
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 30)];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        label.text=@"头";
    }else{
        label.text=@"脚";
    }
    [view addSubview:label];
    return view;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(50, 60);
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(50, 60);
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 100);
}
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
