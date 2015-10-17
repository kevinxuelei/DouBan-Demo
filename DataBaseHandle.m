//
//  DataBaseHandle.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>


@implementation DataBaseHandle
+(DataBaseHandle *)shareDataBase{
    
    static DataBaseHandle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[DataBaseHandle alloc] init];
        }
    });
    
    return instance;
}

static sqlite3  *dataBase = nil;
-(void)openDB{
    
    if (dataBase != nil) {
        return;
    }
    
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [documentStr stringByAppendingString:@"/UserInformation.sqlite"];
    
    int result = sqlite3_open(dataPath.UTF8String, &dataBase);
    
    if (result == SQLITE_OK) {
       NSLog(@"打开成功");
    }else{
         NSLog(@"打开失败");
    }

}

-(void)closeDB{
    
    int result = sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else{
        NSLog(@"关闭失败");
    }

}

-(void)creatActivityTable{
    
    NSString *creatStr = @"CREATE TABLE UserInformation(userName text, title text,id text, begin_time text, address text, category_name text )";
    
    int result = sqlite3_exec(dataBase, creatStr.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}

-(void)insertIntoActivityTable:(ActivityListModel *)userInfo{
    
    NSString *insertStr = [NSString stringWithFormat:@"INSERT INTO UserInformation(userName, title, id, begin_time,address, category_name) VALUES('%@','%@','%@', '%@' ,'%@','%@')",userInfo.userName ,userInfo.title,userInfo.id,userInfo.begin_time ,userInfo.address,userInfo.category_name ];
    
    int result = sqlite3_exec(dataBase, insertStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }

}

-(void)deleteFromTable:(NSString *)userName andTitle:(NSString *)title{
    
    NSString *deleteStr  = [NSString stringWithFormat:@"DELETE FROM UserInformation WHERE userName = '%@' AND title = '%@'",userName,title];
    int result = sqlite3_exec(dataBase, deleteStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }

}

-(NSArray *)selectFromTableWhereUserName:(NSString *)UserName{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *selectStr = @"SELECT *FROM UserInformation WHERE userName = ?";
    
    sqlite3_stmt *stmt = nil;

    int result = sqlite3_prepare(dataBase, selectStr.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, UserName.UTF8String, -1, NULL);
       
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * userName = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)];
            
            NSString * title = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
            
            NSString * id = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 2)];
         
            
            ActivityListModel *activityModel = [[ActivityListModel alloc] init];
            activityModel.userName = userName;
            activityModel.title = title;
            activityModel.id = id;
            [dataArray addObject:activityModel];
        }
        
        sqlite3_finalize(stmt);
        
        for (ActivityListModel *model in dataArray) {
            NSLog(@"%@ %@ %@",model.userName,model.id,model.title);
        }
        
        NSLog(@"查找成功");
    }else{
        NSLog(@"查找失败");
    }
    
    
    return dataArray;

}

//movieDataBase
static sqlite3  *movieDataBase = nil;
-(void)openMovieDB{
    
    if (movieDataBase != nil) {
        return;
    }
    
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [documentStr stringByAppendingString:@"/UserMovieInformation.sqlite"];
    
    int result = sqlite3_open(dataPath.UTF8String, &movieDataBase);
    
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
    
}

-(void)closeMovieDB{
    
    int result = sqlite3_close(movieDataBase);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else{
        NSLog(@"关闭失败");
    }
    
}
-(void)creatMovieTable{
    
    NSString *creatStr = @"CREATE TABLE UserMovieInformation(userName text, title text,IDMoive text, country text)";
    
    int result = sqlite3_exec(movieDataBase, creatStr.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建失败");
    }
}

-(void)insertIntoMovieTable:(MovieDetailModel *)userInfo{
    
    NSString *insertStr = [NSString stringWithFormat:@"INSERT INTO UserMovieInformation(userName, title, IDMoive, country) VALUES('%@','%@','%@', '%@')",userInfo.userName ,userInfo.title,userInfo.IDMoive,userInfo.country];
    
    int result = sqlite3_exec(movieDataBase, insertStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    
}
-(void)deleteFromMovieTable:(NSString *)userName andTitle:(NSString *)title{
    
    NSString *deleteStr  = [NSString stringWithFormat:@"DELETE FROM UserMovieInformation WHERE userName = '%@' AND title = '%@'",userName,title];
    int result = sqlite3_exec(movieDataBase, deleteStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
}
-(NSArray *)selectFromMovieTableWhereUserName:(NSString *)UserName{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *selectStr = @"SELECT *FROM UserMovieInformation WHERE userName = ?";
    
    sqlite3_stmt *stmt = nil;
    
    
    int result = sqlite3_prepare(movieDataBase, selectStr.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        sqlite3_bind_text(stmt, 1, UserName.UTF8String, -1, NULL);
       
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString * userName = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)];
            
            NSString * title = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
            
            NSString * IDMoive = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 2)];
            
            MovieDetailModel *movieModel = [[MovieDetailModel alloc] init];
            movieModel.userName = userName;
            movieModel.title = title;
            movieModel.IDMoive = IDMoive;
            [dataArray addObject:movieModel];
        }
        
        sqlite3_finalize(stmt);
        
        for (MovieDetailModel *model in dataArray) {
            NSLog(@"%@ %@ %@",model.userName,model.IDMoive,model.title);
        }
        
        NSLog(@"查找成功");
    }else{
        NSLog(@"查找失败");
    }
    
    return dataArray;
    
}


@end
