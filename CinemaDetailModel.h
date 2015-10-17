//
//  CinemaDetailModel.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaDetailModel : NSObject

@property (nonatomic, copy) NSString *hall;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *ticket_url;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *type;


+(instancetype)CinemaDetailModelWith:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
