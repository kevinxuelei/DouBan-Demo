//
//  MovieDetailViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "NetWorkHandle.h"
#import "MovieListTableViewController.h"

#import "LoginViewController.h"
#import "DataBaseHandle.h"
#import "MBProgressHUD.h"

@interface MovieDetailViewController ()<MBProgressHUDDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *runTimeLabel;

@property (nonatomic, strong) NSMutableArray *saveMovieModel;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.saveMovieModel = [NSMutableArray array];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self p_setupMBProgressHUD];
    [self loadData];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)backAction:(UIBarButtonItem *)sender{
    MovieListTableViewController *movieListVC = [[MovieListTableViewController alloc] init];
    [self.navigationController popToRootViewControllerAnimated:movieListVC]; // pop到跟视图控制器
}

-(void)saveAction:(UIBarButtonItem *)sender{
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strIsLogin = [userDefault objectForKey:@"isLogin"];
    
    if (![strIsLogin isEqualToString:@"YES"]) {
        
        [self NOLoginAlter];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else{
        
        DataBaseHandle *movieDB = [DataBaseHandle shareDataBase];
        [movieDB openMovieDB];
        [movieDB creatMovieTable];
        
        MovieDetailModel *movieModel = self.dataArray[0];
        movieModel.IDMoive = self.movieId;
        movieModel.userName = [userDefault objectForKey:@"name"];
        
        if ([self modelIsInSave] == YES) {
            
            [self MovieSaveFailAlterView];
            
        }else{
            
            [movieDB insertIntoMovieTable:movieModel];
             [self MovieSaveSuccessAlterView];
            
            }
        }
}

-(void)viewDidAppear:(BOOL)animated{
    
    if ([self modelIsInSave] == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消收藏" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSave:) ];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    }
}
-(void)cancelSave:(UIBarButtonItem *)sender{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strName = [userDefault objectForKey:@"name"];
    
    MovieDetailModel *movieModel = self.dataArray[0];
    
    DataBaseHandle *movieDB = [DataBaseHandle shareDataBase];
    [movieDB openMovieDB];
    [movieDB deleteFromMovieTable:strName andTitle:movieModel.title];
    
    [self cancelSuccessView];
    
}
-(void)NOLoginAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆,请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}
-(void)cancelSuccessView{
    
    UIAlertView *cancelSuccessViewAlter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [cancelSuccessViewAlter show];
    
}
-(BOOL)modelIsInSave{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    DataBaseHandle *movieDB = [DataBaseHandle shareDataBase];
    [movieDB openMovieDB];;
    NSArray *arrMovieModels = [movieDB selectFromMovieTableWhereUserName:[userDefault objectForKey:@"name"]];
    
    MovieDetailModel *model = self.dataArray[0];
    NSString *modelStr = model.title;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (MovieDetailModel *model in arrMovieModels) {
        NSString *titleStr = model.title;
        [arr addObject:titleStr];
    }
    
    if ([arr containsObject:modelStr]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)MovieSaveSuccessAlterView{
    UIAlertView *MovieSaveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [MovieSaveSuccess show];
}
-(void)MovieSaveFailAlterView{
    UIAlertView *MovieFailSaveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经收藏过！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [MovieFailSaveSuccess show];
}


-(void)p_setupMBProgressHUD{

    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.delegate  = self;
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"loading";
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
}
-(void)loadData{
    
    NSString *strMovie = [NSString stringWithFormat:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php?movieId=%@",self.movieId];
    
    [NetWorkHandle postDataWithUrlString:strMovie andBodyString:nil compare:^(id object) {
        
        [self.HUD hide:YES];
        
        NSDictionary *dictData = object;
        NSMutableArray *arr = [NSMutableArray array];
        
        NSDictionary *dictModel = [dictData objectForKey:@"result"];
        MovieDetailModel *model = [[MovieDetailModel alloc] initWithDict:dictModel];
        [arr addObject:model];
        
        self.dataArray = arr;
        
        if (self.dataArray != nil) {
            [self loadAllInfo];
        }

    }];
    

}

-(void)loadAllInfo{
    
    MovieDetailModel *model = self.dataArray[0];
    
    self.ratingLabel.text = model.rating;
    self.releaseTimeLabel.text = model.release_date;
    self.runTimeLabel.text = model.runtime;
    self.genresLabel.text = model.genres;
    self.countryLabel.text = model.country;
    self.introLabel.text = model.actors;
    self.detailLabel.text = model.plot_simple;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.moviePic]];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.imageHeader.image = [UIImage imageWithData:data];
    
    CGFloat fitHeight = [self stringHeightWithString:model.plot_simple fontSize:18 contentSize:CGSizeMake(self.view.frame.size.width - 20, 10000)];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width - 10, fitHeight + 340);

}

- (CGFloat)stringHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize  contentSize:(CGSize)size{
    
    CGRect stringRect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return stringRect.size.height;
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
