//
//  DataBaseHandle.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ActivityListModel.h"
#import "MovieDetailModel.h"

@interface DataBaseHandle : NSObject


+(DataBaseHandle *)shareDataBase;

//activity--DataBase
-(void)openDB;
-(void)closeDB;
-(void)creatActivityTable;
-(void)insertIntoActivityTable:(ActivityListModel *)userInfo;
-(void)deleteFromTable:(NSString *)userName andTitle:(NSString *)title;
-(void)updataFromTableWhereName:(NSString *)userName toUserName:(NSString *)toUserName;
-(NSArray *)selectAll;
-(NSArray *)selectFromTableWhereUserName:(NSString *)UserName;

//movie--DataBase
-(void)openMovieDB;
-(void)closeMovieDB;
-(void)creatMovieTable;
-(void)insertIntoMovieTable:(MovieDetailModel *)userInfo;
-(void)deleteFromMovieTable:(NSString *)userName andTitle:(NSString *)title;
-(void)updataFromMovieTableWhereName:(NSString *)userName toUserName:(NSString *)toUserName;
-(NSArray *)selectMovieTableAll;
-(NSArray *)selectFromMovieTableWhereUserName:(NSString *)UserName;

@end
