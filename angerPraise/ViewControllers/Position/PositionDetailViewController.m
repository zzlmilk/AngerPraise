//
//  PositionDetailViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/15.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PositionDetailViewController.h"
#import "Position.h"
#import "MBProgressHUD.h"

@interface PositionDetailViewController ()

@end

@implementation PositionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _positionDetailWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -70, WIDTH, HEIGHT+70)];
    _positionDetailWebView.delegate = self;
    NSURL *url=[NSURL URLWithString:_positionDetailUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_positionDetailWebView loadRequest:request];
    [_positionDetailWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_positionDetailWebView];
    
}

//网页 刚开始加载
- (void )webViewDidStartLoad:(UIWebView  *)webView{

    MBProgressHUD *progressHUD = [[MBProgressHUD alloc]init];
    progressHUD.mode = MBProgressHUDModeDeterminate;
    [progressHUD show:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

}

//网页 加载完成
- (void )webViewDidFinishLoad:(UIWebView  *)webView{

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
