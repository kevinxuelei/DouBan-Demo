//
//  ActivityTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityListModel.h"
#import "ActivityDetailViewController.h"
#import "NetWorkHandle.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"


@interface ActivityTableViewController ()<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic,retain) MBProgressHUD * hud;

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self p_setupProgressHud];
    
    [self loadData];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
    [self.navigationItem.backBarButtonItem setEnabled:NO];
   self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"活动";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;

}

-(void)p_setupProgressHud{
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.frame = self.view.bounds;
    self.hud.minSize = CGSizeMake(100, 100);
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    self.hud.dimBackground = YES;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

-(void)loadData{
    
    [NetWorkHandle postDataWithUrlString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php" andBodyString:nil compare:^(id object) {
        
      [self.hud hide:YES];
        
        if (object == nil) {
            return ;
        }
        
        NSArray *array = [object objectForKey:@"events"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ActivityListModel *model = [[ActivityListModel alloc] initWithDict:dict];
            [arr addObject:model];
        }
        self.dataArray = arr;
        [self.tableView reloadData];
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityDetailViewController *ActivityDetailVC = [[ActivityDetailViewController alloc] init];
    ActivityDetailVC.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:ActivityDetailVC animated:YES];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [ActivityTableViewCell ActivityTableViewCellWith:tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
}



@end
