//
//  MovieDetailViewController.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailModel.h"

@interface MovieDetailViewController : UIViewController

@property (nonatomic, strong) MovieDetailModel *model;
@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *moviePic;

@end
