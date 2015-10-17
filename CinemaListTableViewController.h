//
//  CinemaListTableViewController.h
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinameListModel.h"

@interface CinemaListTableViewController : UITableViewController

@property (nonatomic, strong) CinameListModel *CLModel;

@property (nonatomic, copy) NSString *getCinemaID;

@end
