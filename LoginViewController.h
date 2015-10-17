//
//  LoginViewController.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (nonatomic, copy) NSString *saveFilePath;

- (IBAction)LoginAction:(id)sender;
- (IBAction)RegistAction:(id)sender;

@end
