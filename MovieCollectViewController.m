//
//  MovieCollectViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieCollectViewController.h"
#import "MovieModel.h"
#import "MovieListTableViewController.h"
#import "TestHandle.h"
#import "UIImageView+WebCache.h"


@interface MovieCollectViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation MovieCollectViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list"] style:UIBarButtonItemStylePlain target:self action:@selector(backPrevious:)];
    
    
    self.dataArray = [[TestHandle shareTest] dataArr];
  
    [self loadMovieCollectView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width * 5);

}

-(void)backPrevious:(UIBarButtonItem *)sender{
    

}



-(void)loadMovieCollectView{
    int totalColumns = 3;
    
    
    CGFloat appW = 120;
    CGFloat appH = 170;
    
    
    CGFloat marginX = (self.view.frame.size.width - totalColumns * appW) / (totalColumns + 1);
    CGFloat marginY = 15;
    
    
    for (int index = 0; index<self.dataArray.count; index++) {
        
        NSBundle *bundle = [NSBundle mainBundle];
        
        NSArray *objs = [bundle loadNibNamed:@"MovieCollectView" owner:nil options:nil];
        UIView *appView = [objs lastObject];
        
        
        [self.scrollView addSubview:appView];
        
        
        int row = index / totalColumns;
        int col = index % totalColumns;
        
        CGFloat appX = 10 + marginX + col * (appW + marginX);
        CGFloat appY = 74 + row * (appH + marginY);
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
         MovieModel *model= self.dataArray[index];
        //利用tag值取得一个view中的控件
      UIImageView *imageView = (UIImageView *)[appView viewWithTag:10];
        UILabel *label = (UILabel *)[appView viewWithTag:20];
       
        label.text = model.movieName;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
        
    }

}
    
    
    // Do any additional setup after loading the view.


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
