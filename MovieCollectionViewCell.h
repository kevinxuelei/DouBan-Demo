//
//  MovieCollectionViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"


@interface MovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@property (nonatomic, strong) MovieModel *movieModel;

@end
