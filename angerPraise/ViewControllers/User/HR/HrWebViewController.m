//
//  HRWebViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HrWebViewController.h"
#import "SMS_MBProgressHUD.h"
#import "User.h"
#import "ApIClient.h"

@interface HrWebViewController ()

@end

@implementation HrWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    _hrWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _hrWebView.delegate = self;
    _hrWebView.scrollView.bounces = NO;

    NSURL *url=[NSURL URLWithString:_hrUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_hrWebView loadRequest:request];
    [_hrWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_hrWebView];
    
    
    [self loadDataUrl];
}

// 获取 收藏Url
-(void)loadDataUrl{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

    [User getHrUrl:dic WithBlock:^(User *user, Error *e) {
        
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
            
            _hrUrl = user.hr_url;
            
            NSURL *url=[NSURL URLWithString:_hrUrl];
            NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
            [_hrWebView loadRequest:request];
            
        }
    }];
}



//网页 刚开始加载
- (void)webViewDidStartLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

//网页 加载完成
- (void)webViewDidFinishLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];
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
