//
//  PerfectViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/7/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PerfectResumeViewController.h"
#import "MBProgressHUD.h"
#import "Resume.h"
#import "ApIClient.h"

#import "JSONKit.h"
#import "WebViewJavascriptBridge.h"

@interface PerfectResumeViewController ()
@property WebViewJavascriptBridge* bridge;

@end

@implementation PerfectResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    _perfectResumeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+70)];
    _perfectResumeWebView.scrollView.bounces = NO;
    _perfectResumeWebView.delegate = self;
    [_perfectResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_perfectResumeWebView];
    
    
    if (_bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_perfectResumeWebView webViewDelegate:self handler:^(NSString *data, WVJBResponseCallback responseCallback) {
        
        if (NZ_DugSet) {
            NSLog(@"ObjC received message from JS: %@", data);
        }
        
        
        NSMutableDictionary *resultsDic = [data objectFromJSONString];
        
        if ([[resultsDic objectForKey:@"string"] isEqualToString:@"perfect_resume_success"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }];
    
    
    [self getQaCreatResumeUrl];
}


// 获取 创建简历的 url
-(void)getQaCreatResumeUrl{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

    [Resume perfectResume:dic WithBlock:^(Resume *resume, Error *e) {
        
        if (e.info !=nil) {
            
            [APIClient showTextMeggage:e.info view:self.view];
            
        }else{
            
            _perfectResumeUrl = resume.resume_perfect_url;
            
            NSURL *url=[NSURL URLWithString:_perfectResumeUrl];
            NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
            [_perfectResumeWebView loadRequest:request];
            
        }
        
    }];
    
}


//网页 刚开始加载
- (void )webViewDidStartLoad:(UIWebView  *)webView{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

//网页 加载完成
- (void )webViewDidFinishLoad:(UIWebView  *)webView{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
