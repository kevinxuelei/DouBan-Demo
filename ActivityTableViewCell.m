//
//  ActivityTableViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "NSString+DataFormatter.h"
#import "UIImageView+WebCache.h"

@interface ActivityTableViewCell ()

@property (nonatomic, strong) NSData *data;

@end

@implementation ActivityTableViewCell

+(instancetype)ActivityTableViewCellWith:(UITableView *)tableView
{
    static NSString *ID = @"activityCell";
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:nil options:nil] lastObject];
     
    }

    return cell;
    
}

-(void)setModel:(ActivityListModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.title;

    NSString *beginTime = [NSString dataWithString:model.begin_time];
    NSString *endTime = [NSString dataWithString:model.end_time];
    NSString *endLastTime = [NSString stringWithFormat:@" -- %@",endTime];
    self.timeLabel.text = [beginTime stringByAppendingString:endLastTime];
    
    self.addressLabel.text = model.address;
    self.catagoryLabel.text = [NSString stringWithFormat:@"类型 : %@",model.category_name];
    
    NSString *strParticipant = [NSString stringWithFormat:@"    参加:  %@  ",model.participant_count];
  
    NSString *strWisher = [NSString stringWithFormat:@"感兴趣: %@",model.wisher_count];
    NSString *strcount = [strWisher stringByAppendingString:strParticipant];
   NSMutableAttributedString *strclor = [[NSMutableAttributedString alloc] initWithString:strcount];
    [strclor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 4)];
     [strclor addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17, 5)];
    self.countLabel.attributedText = strclor;
    
    //图片请求方式
    [self.iamgeDesc sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
}

-(CGFloat)cellHeight:(NSString *)stringValue{
    
    //计算字符串 根据字体 宽度 有一个rect类型 返回字符串的高度  自适应高度的使用
    CGRect stringRect = [stringValue boundingRectWithSize:CGSizeMake(self.frame.size.width - 20, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    
    return stringRect.size.height;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
