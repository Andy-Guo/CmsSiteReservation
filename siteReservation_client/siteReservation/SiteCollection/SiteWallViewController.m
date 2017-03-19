//
//  SiteWallViewController.m
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

/**
 
 *View Layout:
 
 ----------------------------------------------------------------——
 |                             Header                             |
 ----------------------------------------------------------------——
 |                              top|                              |
 ------------------------------------------------------——----------
 |    |                                                     |     |
 |    |    cell1  cell2 ...                                 |     |
 |    |                                                     |     |
 |left|  inset = UIEdgeInsetMake(top, left, bottom, right); |right|
 |    |                                                     |     |
 |    |                 ...celln-1, celln                   |     |
 |    |                                                     |     |
 ------------------------------------------------------------------
 |                              bottom|                           |
 ------------------------------------------------------------------
 |                              Footer                            |
 ------------------------------------------------------------------

**/

#import "SiteWallViewController.h"

static NSString *kSiteWallCollectionViewCellIdentifier = @"SiteWallCollectionViewCell";
static NSString *kSiteWallCollectionViewHeaderIdentifier = @"SiteWallCollectionViewHeader";

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
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self initCollectionView];
}

- (void)initCollectionView
{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(110, 150);
    
    //初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight-64) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //这是头部与脚部的注册
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSiteWallCollectionViewHeaderIdentifier];
    // 注册要复用的cell
    [self.collectionView registerClass:[SiteWallCollectionViewCell class] forCellWithReuseIdentifier:kSiteWallCollectionViewCellIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//#pragma mark - UINavigationControllerDelegate
//// 将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}

#pragma mark <UICollectionViewDataSource>
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _cellAttributesArray.count;
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteWallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSiteWallCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.title.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    [cell configCell:nil]; 
    cell.backgroundColor = COMMON_COLOUR;
    return cell;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSiteWallCollectionViewHeaderIdentifier forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight-64)];
    label.text = @"这是collectionView的头部";
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    return headerView;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


#pragma mark <UICollectionViewDelegate>
//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置(Highlight)高亮下的颜色
- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:RGBACOLOR(0, 0, 0, 0.08)];
}

//设置(Nomal)正常状态下的颜色
- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];

    [cell setBackgroundColor:COMMON_COLOUR];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SiteOrderViewController *vc = [[SiteOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - set_and_get

@end
