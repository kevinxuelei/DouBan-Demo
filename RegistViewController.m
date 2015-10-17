//
//  RegistViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"

@interface RegistViewController ()

@end
                                                                                          
@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"注册";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registAction:)];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)registAction:(UIBarButtonItem *)sender{
    
    
   if ([self.nameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""] || [self.rePasswrodTF.text isEqualToString:@""] || [self.emailTF.text isEqualToString:@""] || [self.phoneTF.text isEqualToString:@""]  ) {
       
       [self lackRegistInfo];
       
   }else{
       
       if (self.passwordTF.text.length < 6) {
           
           [self shortPasswordLength];
           
       }else{
           
           if ([self.passwordTF.text isEqualToString:self.rePasswrodTF.text]) {
               
               NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
               NSString *userInfoPath = [documentStr stringByAppendingString:@"/UserBooks.txt"];
               NSLog(@"%@",userInfoPath);
               
               NSMutableDictionary *saveDict =[NSMutableDictionary dictionaryWithContentsOfFile:userInfoPath];
               
               if (saveDict == nil) {
                   
                   NSMutableDictionary * mainDict = [NSMutableDictionary dictionary];
                   [mainDict setObject:self.passwordTF.text forKey:self.nameTF.text ];
                   [mainDict writeToFile:userInfoPath atomically:YES];

               }else{
                   
                   [saveDict setObject:self.passwordTF.text forKey:self.nameTF.text ];
                   [saveDict writeToFile:userInfoPath atomically:YES];
               }
               
               [self registSuccess];
               

           }else{
               
               [self differPassword];
           }
       
    }

 }
    
}

-(void)lackRegistInfo{
    UIAlertView *alertViewRegistFail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertViewRegistFail show];
}

-(void)registSuccess{
    UIAlertView *alertViewRegistSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertViewRegistSuccess show];

}

-(void)shortPasswordLength{
    UIAlertView *shortPasswordLengthView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码长度小于6" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [shortPasswordLengthView show];
    
}
-(void)differPassword{
    UIAlertView *differPasswordLengthView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [differPasswordLengthView show];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
