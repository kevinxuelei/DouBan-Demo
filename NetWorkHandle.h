//
//  NetWorkHandle.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BackDataBlock) (id object);

@interface NetWorkHandle : NSObject

+(void)getDataWithUrlString:(NSString *)string
                    compare:(BackDataBlock)block;


//post 方法如果没有上传参数则 没有任何的意义
+(void)postDataWithUrlString:(NSString *)string
               andBodyString:(NSString *)bodyString
                     compare:(BackDataBlock)block;

@end
