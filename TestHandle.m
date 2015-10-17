//
//  TestHandle.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TestHandle.h"
static TestHandle *testHandle = nil;

@implementation TestHandle

+(instancetype)shareTest{
    
    if (testHandle == nil) {
        testHandle = [[TestHandle alloc] init];
        testHandle.dataArr = nil;
    }
    return testHandle;
}


@end
