//
//  UserTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserTableViewController.h"
#import "LoginViewController.h"
#import "MyMovieViewController.h"
#import "MyActivityViewController.h"

#import "DataBaseHandle.h"
#import "ActivityListModel.h"
#import "MovieDetailModel.h"

@interface UserTableViewController ()



@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];

   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(loginAction:)];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"我的豆瓣";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;
}

-(void)loginAction:(UIBarButtonItem *)sender{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
   [self.navigationController pushViewController:loginVC animated:YES];
  
}

-(void)QuitAction:(UIBarButtonItem *)sender{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"NO" forKey:@"isLogin"];
    [self quitSuccess];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strIsLogin = [userDefault objectForKey:@"isLogin"];
    
    if (indexPath.row == 0) {
        
        if ([strIsLogin isEqualToString:@"YES"]) {
            
            MyActivityViewController *MyActivityVC = [[MyActivityViewController alloc] init];
            [self.navigationController pushViewController:MyActivityVC animated:YES];
            
        }else{
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            [self NOLoginAlter];
        }
       
    }
    
    if (indexPath.row == 1) {
        
        if ([strIsLogin isEqualToString:@"YES"]) {
            MyMovieViewController *MyMovieVC = [[MyMovieViewController alloc] init];
            [self.navigationController pushViewController:MyMovieVC animated:YES];
        }else{
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            [self NOLoginAlter];

        }
        
    }
    
    if (indexPath.row == 2) {
        
        if ([strIsLogin isEqualToString:@"YES"]) {
            
            DataBaseHandle *userDB = [DataBaseHandle shareDataBase];
            [userDB openDB];
            
            NSString *currentUser = [userDefault objectForKey:@"name"];
            
            NSMutableArray *arrActivitys = [NSMutableArray array];
            NSArray *arrSaveActivitys = [userDB selectFromTableWhereUserName:currentUser];
            for ( ActivityListModel *modelActivity in arrSaveActivitys) {
                NSString *strTitle = modelActivity.title;
                [arrActivitys addObject:strTitle];
            }
            for (NSString *title in arrActivitys) {
                [userDB deleteFromTable:currentUser andTitle:title];
            }
            
            [userDB openMovieDB];
            NSArray *arrSaveMovies = [userDB selectFromMovieTableWhereUserName:currentUser];
            NSMutableArray *arrMovies = [NSMutableArray array];
            for (MovieDetailModel *modelMovie in arrSaveMovies) {
                NSString *strTitle = modelMovie.title;
                [arrMovies addObject:strTitle];
            }
            for (NSString *movieTitle in arrMovies) {
                [userDB deleteFromMovieTable:currentUser andTitle:movieTitle];
            }
            
            [self cleanCash];
            
        }else{
            
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            [self NOLoginAlter];
        }

    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strIsLogin = [userDefault objectForKey:@"isLogin"];
    
    if ([strIsLogin isEqualToString:@"YES"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(QuitAction:)];
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(loginAction:)];
    }
    
}
-(void)NOLoginAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆,请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}
-(void)quitSuccess{
    
    UIAlertView *quitSuccessAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注销成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [quitSuccessAlterView show];
    
}
-(void)cleanCash{
    
    UIAlertView *cleanCashAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清除缓存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [cleanCashAlterView show];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

@end
