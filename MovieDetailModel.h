//
//  MovieDetailModel.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *plot_simple;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *genres;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *runtime;
@property (nonatomic, copy) NSString *poster;
@property (nonatomic, copy) NSString *rating_count;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *actors;
@property (nonatomic, copy) NSString *release_date;

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *IDMoive;


+(instancetype)MovieDetailModelWith:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
