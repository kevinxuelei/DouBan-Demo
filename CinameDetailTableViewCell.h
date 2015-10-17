//
//  CinameDetailTableViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaDetailModel.h"

@interface CinameDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hallLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, strong) CinemaDetailModel *model;

+(instancetype)CinameDetailTableViewCellWith:(UITableView *)tableView;

@end
