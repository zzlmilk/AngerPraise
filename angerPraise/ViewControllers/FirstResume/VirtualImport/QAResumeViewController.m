//
//  QAResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "QAResumeViewController.h"
#import "SMS_MBProgressHUD.h"


@interface QAResumeViewController ()

@end

@implementation QAResumeViewController

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
    
    _qaResumeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+70)];
    _qaResumeWebView.scrollView.bounces = NO;
    _qaResumeWebView.delegate = self;
    //NSURL *url=[NSURL URLWithString:_resumeScoreUrl];
    NSURL *url=[NSURL URLWithString:@"http://app.hirelib.com/website/user/create_resume?user_id=1"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_qaResumeWebView loadRequest:request];
    [_qaResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_qaResumeWebView];
    
}

-(void)doBack{
    
    if(_qaResumeWebView.canGoBack)
    {
        [_qaResumeWebView goBack];
        
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
