//
//  MovieTableViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MovieTableViewCell


+(instancetype)MovieTableViewCellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MovieTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setModel:(MovieModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.movieName;
    [self.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.model.pic_url]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
