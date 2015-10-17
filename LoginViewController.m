//
//  LoginViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"

#import "UserTableViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"用户登陆";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)passSaveFilePath:(NSString *)filePath{
    self.saveFilePath = filePath;
}

- (IBAction)LoginAction:(id)sender {
    
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userInfoPath = [documentStr stringByAppendingString:@"/UserBooks.txt"];
    NSLog(@"%@",userInfoPath);
    
    NSMutableDictionary *saveDict =[NSMutableDictionary dictionaryWithContentsOfFile:userInfoPath];
    
    NSString *strName = self.nameTF.text;
    NSArray *arrNames = [saveDict allKeys];
    if ([arrNames containsObject:strName]) {
        
        NSString *currentPassword = [saveDict objectForKey:self.nameTF.text];
        if ([currentPassword isEqualToString:self.passwordTF.text]) {
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setValue:self.nameTF.text forKey:@"name"];
            [userDefault setValue:@"YES" forKey:@"isLogin"];
            
            [self loginSuccess];
        }else{
            [self WrongPassWord];
        }
        
    }else{
        [self NoUserInfo];
    }
    
}

-(void)loginSuccess{
    
    UIAlertView *loginSuccessInfo = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [loginSuccessInfo show];

}
-(void)NoUserInfo{
    
    UIAlertView *NoUser = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不存在,请重新登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [NoUser show];
}
-(void)WrongPassWord{
    
    UIAlertView *WrongPassWordInfo = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误,请重新登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [WrongPassWordInfo show];
}

- (IBAction)RegistAction:(id)sender {
    
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}
@end
