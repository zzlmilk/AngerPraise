//
//  SettingWebViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "SettingWebViewController.h"
#import "SMS_MBProgressHUD.h"

@interface SettingWebViewController ()

@end

@implementation SettingWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _settingWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+70)];
    _settingWebView.scrollView.bounces = NO;
    _settingWebView.delegate = self;
    NSURL *url=[NSURL URLWithString:_settingDetailUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_settingWebView loadRequest:request];
    [_settingWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_settingWebView];
    
}

-(void)doBack{
    
    if (_settingWebView.canGoBack)
    {
        [_settingWebView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//网页 刚开始加载
- (void )webViewDidStartLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

//网页 加载完成
- (void )webViewDidFinishLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
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
