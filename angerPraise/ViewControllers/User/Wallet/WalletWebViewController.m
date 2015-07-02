//
//  WalletWebViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "WalletWebViewController.h"
#import "SMS_MBProgressHUD.h"
#import "User.h"
#import "ApIClient.h"

@interface WalletWebViewController ()

@end

@implementation WalletWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _walletWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+65)];
    _walletWebView.delegate = self;

    NSURL *url=[NSURL URLWithString:_walletUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_walletWebView loadRequest:request];
    _walletWebView.scrollView.bounces = NO;
    [_walletWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_walletWebView];
    
    [self loadDataUrl];
}

// 获取 钱包Url
-(void)loadDataUrl{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

    [User getWalletUrl:dic WithBlock:^(User *user, Error *e) {
        
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
            
            _walletUrl = user.pay_url;
            
            NSURL *url=[NSURL URLWithString:_walletUrl];
            NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
            [_walletWebView loadRequest:request];
            
        }
    }];
}

-(void)doBack{
    
    if (_walletWebView.canGoBack)
    {
        [_walletWebView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
