//
//  CinemaListTableViewCell.m
//  UI-豆瓣SB版
//
//  Created by lanou3g on 15/10/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "NetWorkHandle.h"
#import "avPlayerViewController.h"


@interface CinemaListTableViewCell ()<MBProgressHUDDelegate,NSURLConnectionDelegate>

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, assign) CGFloat  expectedLength;
@property (nonatomic, assign) CGFloat  currentLength;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CinemaListTableViewCell


///////////////////////////////////////////////----------------------------
- (IBAction)downLoad:(UIButton *)sender {
    
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [documentStr stringByAppendingString:@"/moviedate.txt"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://a1408.g.akamai.net/5/1408/1388/2005110403/1a1a1ad948be278cff2d96046ad90768d848b41947aa1986/sample_iPod.m4v.zip"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection start];
    
    self.HUD = [[MBProgressHUD alloc] init];
    self.HUD.delegate = self;
    self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.HUD.labelText = @"success";
    [self addSubview:self.HUD];
    [self.HUD show:YES];
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    self.dataArray = [NSMutableData data];
    self.expectedLength = MAX([response expectedContentLength], 1);
    self.currentLength = 0;
   // self.HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
     [self.dataArray appendData:data];
    
    self.currentLength += [data length];
    self.HUD.progress = self.currentLength / (float)self.expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [documentStr stringByAppendingString:@"/moviedate.txt"];
    
    [self.dataArray writeToFile:filepath atomically:YES];
    
    self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] ;
    self.HUD.mode = MBProgressHUDModeCustomView;
    [self.HUD hide:YES afterDelay:2]; //下载完成后的延迟操作
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.HUD hide:YES];
}




///////////////////////////////////////////////----------------------------

- (IBAction)showMovieOnTime:(UIButton *)sender {
    
    self.webView = [[UIWebView alloc] initWithFrame:self.frame];
    
    NSString *urlStr =@"http://www.iqiyi.com/v_19rrhjtpm4.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
   [self addSubview:self.webView];
    //avPlayerViewController *avPlayVC = [[avPlayerViewController alloc] init];
    
}



//////////
+(instancetype)CinemaListTableViewCellWith:(UITableView *)tableView{
    
    static NSString *ID = @"CELL";
    CinemaListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaListTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(void)setModel:(CinameListModel *)model{
    
    _model = model;
    
    self.nameLabel.text = model.movieName;
    self.IDLabel.text = model.movieId;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
