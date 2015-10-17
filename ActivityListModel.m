//
//  ActivityListModel.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityListModel.h"

@implementation ActivityListModel
+(instancetype)ActivityListModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
            self.title = [aDecoder decodeObjectForKey:@"title"];
            self.begin_time = [aDecoder decodeObjectForKey:@"begin_time"];
            self.end_time = [aDecoder decodeObjectForKey:@"end_time"];
            self.address = [aDecoder decodeObjectForKey:@"address"];
            self.category_name = [aDecoder decodeObjectForKey:@"category_name"];
            self.participant_count = [aDecoder decodeObjectForKey:@"participant_count"];
            self.wisher_count = [aDecoder decodeObjectForKey:@"wisher_count"];
            self.image = [aDecoder decodeObjectForKey:@"image"];
            self.name = [aDecoder decodeObjectForKey:@"name"];
            self.content = [aDecoder decodeObjectForKey:@"content"];
            self.owner = [aDecoder decodeObjectForKey:@"owner"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.begin_time forKey:@"begin_time"];
    [aCoder encodeObject:self.end_time forKey:@"end_time"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.category_name forKey:@"category_name"];
    [aCoder encodeObject:self.participant_count forKey:@"participant_count"];
    [aCoder encodeObject:self.wisher_count forKey:@"wisher_count"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.owner forKey:@"owner"];
   
}

@end
