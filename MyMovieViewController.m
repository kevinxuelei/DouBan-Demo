//
//  MyMovieViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyMovieViewController.h"
#import "MovieDetailModel.h"

#import "DataBaseHandle.h"

@interface MyMovieViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self loadData];
    [self loadTableView];
    
    // Do any additional setup after loading the view.
}

-(void)loadData{
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"name"];
    
    DataBaseHandle *movieDB = [DataBaseHandle shareDataBase];
    [movieDB openMovieDB];
    NSArray *arrMovieModels = [movieDB selectFromMovieTableWhereUserName:userName];
    
    self.dataArray = [NSMutableArray arrayWithArray:arrMovieModels];
 
    
}
-(void)loadTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Moivecell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Moivecell" forIndexPath:indexPath];
  MovieDetailModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text =model.title;
    
    return cell;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"name"];
    
    DataBaseHandle *movieDB = [DataBaseHandle shareDataBase];
    [movieDB openMovieDB];
    
    MovieDetailModel *currentModel = self.dataArray[indexPath.row];
    [movieDB deleteFromMovieTable:userName andTitle:currentModel.title];
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
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

@end
