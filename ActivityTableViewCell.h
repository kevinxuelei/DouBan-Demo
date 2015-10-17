//
//  ActivityTableViewCell.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *catagoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeDesc;


@property (nonatomic, strong) ActivityListModel *model;

+(instancetype)ActivityTableViewCellWith:(UITableView *)tableView;

@end
