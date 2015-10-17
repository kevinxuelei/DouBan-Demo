//
//  MovieTableViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong) MovieModel *model;

+(instancetype)MovieTableViewCellWith:(UITableView *)tableView;

@end
