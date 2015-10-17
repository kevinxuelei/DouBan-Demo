//
//  CinameDetailTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinameDetailTableViewController.h"
#import "CinameDetailTableViewCell.h"

@interface CinameDetailTableViewController ()

@end

@implementation CinameDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"电影信息";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;
  
    self.tableView.rowHeight = 220;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.passDetailArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CinameDetailTableViewCell *cell = [CinameDetailTableViewCell CinameDetailTableViewCellWith:tableView];
    
    CinemaDetailModel *OneModel = self.passDetailArr[indexPath.row];
    cell.model = OneModel;
    
    return cell;
}


@end
