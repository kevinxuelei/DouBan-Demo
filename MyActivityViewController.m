
//
//  MyActivityViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyActivityViewController.h"
#import "ActivityListModel.h"


#import "DataBaseHandle.h"

@interface MyActivityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyActivityViewController

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
    
    DataBaseHandle *dataBase = [DataBaseHandle shareDataBase];
    [dataBase openDB];
    NSArray *arrActivityModels = [dataBase selectFromTableWhereUserName:userName];
    
    self.dataArray = [NSMutableArray arrayWithArray:arrActivityModels];
    
    
}

-(void)loadTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"activityCell"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
    ActivityListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefault  = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"name"];
    
    DataBaseHandle *dataBase = [DataBaseHandle shareDataBase];
    [dataBase openDB];

    ActivityListModel *model = self.dataArray[indexPath.row];
    NSString *titleStr = model.title;
    
    [dataBase deleteFromTable:userName andTitle:titleStr];
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
