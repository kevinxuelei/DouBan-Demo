//
//  CinameModel.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinameModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *cinemaName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *trafficRoutes;

+(instancetype)CinameModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
