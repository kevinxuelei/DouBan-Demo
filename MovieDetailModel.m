//
//  MovieDetailModel.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetailModel.h"

@implementation MovieDetailModel

+(instancetype)MovieDetailModelWith:(NSDictionary *)dict;
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

-(void)encodeWithCoder:(NSCoder *)aCoder{
     [aCoder encodeObject:self.plot_simple forKey:@"plot_simple"];
      [aCoder encodeObject:self.title forKey:@"title"];
      [aCoder encodeObject:self.genres forKey:@"genres"];
      [aCoder encodeObject:self.country forKey:@"country"];
      [aCoder encodeObject:self.runtime forKey:@"runtime"];
      [aCoder encodeObject:self.poster forKey:@"poster"];
      [aCoder encodeObject:self.rating_count forKey:@"rating_count"];
      [aCoder encodeObject:self.rating forKey:@"rating"];
      [aCoder encodeObject:self.actors forKey:@"actors"];
      [aCoder encodeObject:self.release_date forKey:@"release_date"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.plot_simple = [aDecoder decodeObjectForKey:@"plot_simple"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.genres = [aDecoder decodeObjectForKey:@"genres"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.runtime = [aDecoder decodeObjectForKey:@"runtime"];
        self.poster = [aDecoder decodeObjectForKey:@"plot_simple"];
        self.rating_count = [aDecoder decodeObjectForKey:@"poster"];
        self.rating = [aDecoder decodeObjectForKey:@"rating"];
        self.actors = [aDecoder decodeObjectForKey:@"actors"];
        self.release_date = [aDecoder decodeObjectForKey:@"release_date"];
        
    }
    
    return self;
    
}

@end
