//
//  CinemaTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaTableViewController.h"
#import "CinameModel.h"
#import "CinemaTableViewCell.h"
#import "CinemaListTableViewController.h"
#import "NetWorkHandle.h"
#import "MBProgressHUD.h"

@interface CinemaTableViewController ()<MBProgressHUDDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dataDict;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation CinemaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
     self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"影院";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;
    
    [self p_setupMBProgressHUD];
     [self loadData];
}


-(void)p_setupMBProgressHUD{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.delegate =self;
    self.HUD.labelText = @"loading";
    self.HUD.tintColor = [UIColor redColor];
  //  self.HUD.backgroundColor = [UIColor yellowColor];
//    self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
   [self.view addSubview:self.HUD];
    [self.HUD show:YES];
   
}


-(void)loadData{
    
    [NetWorkHandle postDataWithUrlString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php" andBodyString:nil compare:^(id object) {
        [self.HUD hide:YES];
        
        self.dataDict = object;
        if (self.dataDict != nil) {
            
            NSDictionary *dictTmep = [self.dataDict objectForKey:@"result"];
            NSArray *arrData = [dictTmep objectForKey:@"data"];
            NSMutableArray *arr = [NSMutableArray array];
            
            for (NSDictionary *arrmodel in arrData) {
                CinameModel *model = [CinameModel CinameModelWithDict:arrmodel];
                [arr addObject:model];
            }
            
            self.dataArray = arr;
            [self.tableView reloadData];
            
        };

    }];

}
     

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CinemaTableViewCell *cell = [CinemaTableViewCell CinemaTableViewCellWith:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CinemaListTableViewController *CinemaListVC = [[CinemaListTableViewController alloc] init];
    CinameModel *modelTemp = self.dataArray[indexPath.row];
    CinemaListVC.getCinemaID = modelTemp.id;
    
    [self.navigationController pushViewController:CinemaListVC animated:YES];
}


@end
