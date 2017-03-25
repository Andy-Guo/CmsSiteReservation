//
//  SiteOrderViewController.m
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteOrderViewController.h"
#import "SiteListCell.h"

static NSString *kSiteOrderTableViewCellIdentifier = @"SiteOrderTableViewCellIdentifier";

@interface SiteOrderViewController ()
@property (nonatomic, strong) SiteOrderHeaderView *headerView;
@end


@implementation SiteOrderViewController

#pragma mark - lifeCycle
- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self initTableView];
}

- (void)initTableView
{
    self.headerView = [[SiteOrderHeaderView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height, 300, 50)];
    self.headerView.delegate = self; // 设置代理对象
    [self.view addSubview:self.headerView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins  = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    
    
    //tableView.allowsSelection = YES;//这一句加不加都可以，默认就是YES,如果不想被选中，可以置为NO.
    //设置头标题
    //UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.frame), 40)];
    //label.text = @"section header";
    //tableView.tableHeaderView = label;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SiteListCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             kSiteOrderTableViewCellIdentifier];
    if (cell == nil) {
        cell = (SiteListCell*)[[SiteListCell alloc] init];
    }
    cell.backgroundColor = [UIColor greenColor];
    return cell;

}

#pragma mark <UITableViewDelegate>
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 通过接口进行预定操作
    if ([indexPath row] > 1) {//后两行

        
    }
}

#pragma mark SiteOrderHeaderViewDelegate
- (void)showAnotherDay:(NSString *)title
{
    
}

- (void)showCalendar
{
    
}
@end
