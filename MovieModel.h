//
//  MovieModel.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MovieModel : NSObject

@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *movieId;

+(instancetype)MovieModelWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;


@end
