//
//  MovieListTableViewController.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieListTableViewController.h"
#import "MovieModel.h"
#import "MovieTableViewCell.h"
#import "MovieCollectViewController.h"
#import "MovieDetailViewController.h"
#import "TestHandle.h"
#import "NetWorkHandle.h"
#import "MovieCollectionViewCell.h"
#import "MBProgressHUD.h"


@interface MovieListTableViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *changeViewBtn;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation MovieListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_nav"]];

    [self.changeViewBtn setBackgroundImage:[UIImage imageNamed:@"btn_nav_list"] forState:UIControlStateNormal];
     [self.changeViewBtn setBackgroundImage:[UIImage imageNamed:@"btn_nav_collection"] forState:UIControlStateSelected];
     [self.changeViewBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleView.text = @"电影";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = titleView;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self p_setupProgressHud];
   [self loadData];
    
   [self loadCollectionView];
   

}

-(void)loadCollectionView{
    
    UICollectionViewFlowLayout *flowLY = [[UICollectionViewFlowLayout alloc] init];
    flowLY.itemSize = CGSizeMake(110, 150);
    flowLY.minimumLineSpacing = 40;
    flowLY.minimumInteritemSpacing = 10;
    flowLY.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLY.sectionInset = UIEdgeInsetsMake(30, 10, 20, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLY];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MovieCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"movieCell"];
   self.collectionView.hidden = YES;
}
-(void)btnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected; // 属性取反，进行反复选择
    self.collectionView.hidden = !self.collectionView.hidden;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.movieModel = self.dataArray[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailViewController *MovieDetailVC = [[MovieDetailViewController alloc] init];
    MovieModel *model = self.dataArray[indexPath.row];
    
    MovieDetailVC.movieId = model.movieId;
    MovieDetailVC.moviePic = model.pic_url;
    
    [[TestHandle shareTest] setDataArr:self.dataArray];
    
    [self.navigationController pushViewController:MovieDetailVC animated:YES];
}


-(void)p_setupProgressHud{
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.delegate = self;
//    self.HUD.mode = MBProgressHU; //默认是菊花类型的
    self.HUD.dimBackground = YES;
    self.HUD.labelText = @"loading";
    [self.view addSubview:self.HUD];
    
    [self.HUD show:YES];
}

-(void)loadData{
    
    [NetWorkHandle postDataWithUrlString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php" andBodyString:nil compare:^(id object) {
        
        [self.HUD hide:YES];
        
        NSArray *array = [object objectForKey:@"result"];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            MovieModel *model = [MovieModel MovieModelWithDict:dict];
            [arr addObject:model];
        }
        self.dataArray = arr;
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    MovieTableViewCell *cell = [MovieTableViewCell MovieTableViewCellWith:tableView];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailViewController *MovieDetailVC = [[MovieDetailViewController alloc] init];
    MovieModel *model = self.dataArray[indexPath.row];
    
    MovieDetailVC.movieId = model.movieId;
    MovieDetailVC.moviePic = model.pic_url;
    
    [[TestHandle shareTest] setDataArr:self.dataArray];
    
    [self.navigationController pushViewController:MovieDetailVC animated:YES];
    
}


@end
