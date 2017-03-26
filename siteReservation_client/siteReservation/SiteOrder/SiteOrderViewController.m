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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.origin.y + self.headerView.frame.size.height, kScreenWidth, kScreenHeight - self.navigationController.navigationBar.frame.size.height - 50 - 20) style:UITableViewStylePlain];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins  = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataMArr = [NSMutableArray array];
    // 测试数据，将来会在服务端配置，通过建立model初始化
    self.dataMArr = @[@"8：00-9：00",
                      @"9：00-10：00",
                      @"10：00-11：00",
                      @"11：00-12：00",
                      @"12：00-13：00",
                      @"13：00-14：00",
                      @"14：00-15：00",
                      @"15：00-16：00",
                      @"16：00-17：00",
                      @"17：00-18：00",
                      @"18：00-19：00",
                      @"19：00-20：00",
                      @"20：00-21：00",
                      @"21：00-22：00"
                      ];
    
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
    return self.dataMArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SiteListCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             kSiteOrderTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[SiteListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:kSiteOrderTableViewCellIdentifier];
    }
    cell.timeSlot.text = self.dataMArr[indexPath.row];
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
