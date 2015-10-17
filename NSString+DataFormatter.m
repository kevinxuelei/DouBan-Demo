//
//  NSString+DataFormatter.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NSString+DataFormatter.h"

@implementation NSString (DataFormatter)

+(NSString *)dataWithString:(NSString *)string{
    
    return [string substringWithRange:NSMakeRange(5, 11)];
}

@end
