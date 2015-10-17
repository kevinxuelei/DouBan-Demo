//
//  CinameDetailTableViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinameDetailTableViewCell.h"

@implementation CinameDetailTableViewCell

+(instancetype)CinameDetailTableViewCellWith:(UITableView *)tableView{
    
    static NSString *ID = @"detailCell";
    CinameDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinameDetailTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}


-(void)setModel:(CinemaDetailModel *)model{
    _model = model;
        
    //model初始化后才能直接使用点语法
    self.hallLabel.text = [model valueForKey:@"hall"];
    self.languageLabel.text = [model valueForKey:@"language"];
    self.priceLabel.text = [model valueForKey:@"price"];
    self.ticketLabel.text= [model valueForKey:@"ticket_url"];
    self.timeLabel.text =[model valueForKey:@"time"];
    self.typeLabel.text =[model valueForKey:@"type"];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
