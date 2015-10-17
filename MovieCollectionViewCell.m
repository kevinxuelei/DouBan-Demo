//
//  MovieCollectionViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MovieCollectionViewCell

-(void)setMovieModel:(MovieModel *)movieModel{
    
    _movieModel = movieModel;
    
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:movieModel.pic_url]];
    self.movieTitle.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.movieTitle.text = movieModel.movieName;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
