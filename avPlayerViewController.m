//
//  avPlayerViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "avPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>



@interface avPlayerViewController ()

@property (nonatomic, strong) AVAudioPlayer *moviePlayer;

@end

@implementation avPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor yellowColor];
    
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [documentStr stringByAppendingString:@"/moviedate.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    self.moviePlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.moviePlayer play];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.moviePlayer play];
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
