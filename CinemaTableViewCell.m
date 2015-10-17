//
//  CinemaTableViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaTableViewCell.h"

@implementation CinemaTableViewCell


+(instancetype)CinemaTableViewCellWith:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setModel:(CinameModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.cinemaName;
    self.addressLabel.text = model.address;
    self.phoneLabel.text = model.telephone;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
