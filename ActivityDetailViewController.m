//
//  ActivityDetailViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityTableViewController.h"
#import "NSString+DataFormatter.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"


#import "DataBaseHandle.h"


@interface ActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImge;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *contentViewLabel;

@property (nonatomic, strong) NSMutableArray *activityModels;



@end

@implementation ActivityDetailViewController


- (void)viewDidLoad {
    
     [super viewDidLoad];
    
    
     self.activityModels = [NSMutableArray array];
    
      self.navigationController.navigationItem.backBarButtonItem.enabled = NO;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
      self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.titleLabel.text = self.model.title;
    
    [self.headerImge sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    
    NSString *beginTime = [NSString dataWithString:self.model.begin_time];
    NSString *endTime = [NSString dataWithString:self.model.end_time];
    NSString *endLastTime = [NSString stringWithFormat:@" -- %@",endTime];
    self.timeLabel.text = [beginTime stringByAppendingString:endLastTime];
    
    NSString *strName = [self.model.owner objectForKey:@"name"];
    self.nameLabel.text = strName;
    
     self.categoryLabel.text = [NSString stringWithFormat:@"类型 : %@",self.model.category_name];
     self.addressLabel.text = self.model.address;
     self.contentLabel.text = self.model.content;
    
    CGFloat fitHeight = [self stringHeightWithString:self.model.content fontSize:18 contentSize:CGSizeMake(self.view.frame.size.width - 20, 10000)] ;
    self.contentLabel.frame = CGRectMake(24, 347, 332, fitHeight + 350);
   
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width - 10, fitHeight);
    // Do any additional setup after loading the view from its nib.
}

-(void)setModel:(ActivityListModel *)model{
    
    _model = model;
    
}

-(void)backAction:(UIBarButtonItem *)sender{
    ActivityTableViewController *activityVC = [[ActivityTableViewController alloc] init];
    [self.navigationController popToRootViewControllerAnimated:activityVC];
}

-(void)saveAction:(UIBarButtonItem *)sender
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *strIsLogin = [userDefault objectForKey:@"isLogin"];
    
    if (![strIsLogin isEqualToString:@"YES"]) {
        
        [self NOLoginAlter];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else{
        
        DataBaseHandle *dataBase = [DataBaseHandle shareDataBase];
        [dataBase openDB];
        [dataBase creatActivityTable];
        
        self.model.userName = [userDefault objectForKey:@"name"];
        
        if ([self modelIsInSaveModelsArray] == YES) {
            [self saveFailAlterView];
        }else{
            [dataBase insertIntoActivityTable:self.model];
            [self saveSuccessAlterView];
        }

    }
 
}

-(BOOL)modelIsInSaveModelsArray{
    
    DataBaseHandle *dataBase = [DataBaseHandle shareDataBase];
    [dataBase openDB];
    
    NSArray * arrModel = [dataBase selectFromTableWhereUserName:self.model.userName ];
        
    NSMutableArray *IDArray = [NSMutableArray array];
    for (ActivityListModel *model in arrModel) {
        
        ActivityListModel *modelTemp = model;
        NSString *strTitle = modelTemp.id;
        [IDArray addObject:strTitle];
        
    }
    
    NSString *modelTitle = self.model.id;
    if ([IDArray containsObject:modelTitle]) {
        return  YES;
    }else{
        return NO;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([self modelIsInSaveModelsArray] == YES) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消收藏" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSave:) ];
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    }
}

-(void)cancelSave:(UIBarButtonItem *)sender{
    
    DataBaseHandle *dataBase = [DataBaseHandle shareDataBase];
    [dataBase openDB];
    [dataBase deleteFromTable:self.model.userName andTitle:self.model.title];
    [self cancelSuccessView];

}

-(void)saveSuccessAlterView{
    UIAlertView *saveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [saveSuccess show];

}
-(void)saveFailAlterView{
    
    UIAlertView *saveSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经收藏过。。。。。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [saveSuccess show];

}
-(void)NOLoginAlter{
    
    UIAlertView *NOLoginAlterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆,请登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NOLoginAlterView show];
    
}
-(void)cancelSuccessView{
    
    UIAlertView *cancelSuccessViewAlter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [cancelSuccessViewAlter show];
    
}

- (CGFloat)stringHeightWithString:(NSString *)str fontSize:(CGFloat)fontSize  contentSize:(CGSize)size{
    
    CGRect stringRect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return stringRect.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
