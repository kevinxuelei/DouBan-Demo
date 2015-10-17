//
//  CinemaListTableViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinameListModel.h"

@interface CinemaListTableViewCell : UITableViewCell

@property (nonatomic, strong) CinameListModel *model;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (nonatomic, strong) NSMutableData *dataArray;

- (IBAction)downLoad:(UIButton *)sender;

+(instancetype)CinemaListTableViewCellWith:(UITableView *)tableView;

@end
