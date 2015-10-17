//
//  ActivityListModel.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityListModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *begin_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *participant_count;
@property (nonatomic, copy) NSString *wisher_count;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSDictionary *owner;
@property (nonatomic, copy) NSString * id;


@property (nonatomic, copy) NSString *userName;

+(instancetype)ActivityListModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;


@end
