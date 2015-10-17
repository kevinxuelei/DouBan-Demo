//
//  CinemaTableViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinameModel.h"

@interface CinemaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) CinameModel *model;

+(instancetype)CinemaTableViewCellWith:(UITableView *)tableView;


@end
