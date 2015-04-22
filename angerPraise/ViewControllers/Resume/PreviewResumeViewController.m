//
//  PreviewResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/17.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "MBProgressHUD.h"

@interface PreviewResumeViewController ()

@end

@implementation PreviewResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _previewResumeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -65, WIDTH, HEIGHT+65)];
    _previewResumeWebView.delegate = self;
    
    _resumePreviewUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"previewResumeUrl"];
    NSURL *url=[NSURL URLWithString:_resumePreviewUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_previewResumeWebView loadRequest:request];
    [_previewResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_previewResumeWebView];
}

//网页 刚开始加载
- (void)webViewDidStartLoad:(UIWebView  *)webView{
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc]init];
    progressHUD.mode = MBProgressHUDModeDeterminate;
    [progressHUD show:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

//网页 加载完成
- (void)webViewDidFinishLoad:(UIWebView  *)webView{
    
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
