//
//  CinemaListTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaListTableViewController.h"
#import "CinemaListTableViewCell.h"
#import "CinemaTableViewController.h"
#import "CinameDetailTableViewController.h"
#import "NetWorkHandle.h"
#import "avPlayerViewController.h"

@interface CinemaListTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CinemaListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"电影列表";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;
    
    [self loadData];
    
    self.tableView.rowHeight = 250;
    
}
-(void)loadData{
    
     NSString *strMovie = [NSString stringWithFormat:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchcinema.php?cinemaId=%@",self.getCinemaID];
   
    [NetWorkHandle postDataWithUrlString:strMovie andBodyString:nil compare:^(id object) {
        
        NSDictionary *dictData = object;
        NSDictionary *dictResult = [dictData objectForKey:@"result"];
        NSDictionary *dictLists = [dictResult objectForKey:@"lists"];
        
        NSMutableArray *arrModel = [NSMutableArray array];
        for (NSDictionary *dict in dictLists) {
            CinameListModel *model = [CinameListModel CinemaDetailModelWithDict:dict];
            [arrModel addObject:model];
        }
        
        self.dataArray = arrModel;
        [self.tableView reloadData];

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
    
    CinemaListTableViewCell *cell = [CinemaListTableViewCell CinemaListTableViewCellWith:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CinameDetailTableViewController *CinameDetilVC = [[CinameDetailTableViewController alloc] init];
    CinameListModel *modelTemp = self.dataArray[indexPath.row];
    NSArray *passArr = [modelTemp valueForKey:@"broadcast"];
    CinameDetilVC.passDetailArr = passArr;
    
    [self.navigationController pushViewController:CinameDetilVC animated:YES];
    
//    avPlayerViewController *av = [[avPlayerViewController alloc] init];
//    [self.navigationController pushViewController:av animated:YES];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

@end
