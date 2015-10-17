//
//  CinameModel.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinameModel.h"

@implementation CinameModel
+(instancetype)CinameModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
    [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
