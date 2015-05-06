//
//  PreviewResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/17.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "SMS_MBProgressHUD.h"

@interface PreviewResumeViewController ()

@end

@implementation PreviewResumeViewController

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
    
    _previewResumeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+65)];
    _previewResumeWebView.delegate = self;
    
    _resumePreviewUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"previewResumeUrl"];
    NSURL *url=[NSURL URLWithString:_resumePreviewUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_previewResumeWebView loadRequest:request];
    [_previewResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_previewResumeWebView];
}


-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
