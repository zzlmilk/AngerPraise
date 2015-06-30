//
//  VirtualImportViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "VirtualImportViewController.h"
//#import "MYBlurIntroductionView.h"
//#import "MYIntroductionPanel.h"
#import "NeedDataViewController.h"
#import "ApIClient.h"
#import "Resume.h"
#import "MainViewController.h"
#import "SMS_MBProgressHUD.h"

@interface VirtualImportViewController ()

@end

@implementation VirtualImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *bgTitleLabel = [[UILabel alloc]init];
//    bgTitleLabel.frame = CGRectMake(0, 0, WIDTH, 44);
//    bgTitleLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
//    [self.view addSubview:bgTitleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    _virtuaImportlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0,-44, WIDTH, HEIGHT-70)];
    _virtuaImportlWebView.delegate = self;
    NSURL *url=[NSURL URLWithString:@"http://m.51job.com/my/login.php"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_virtuaImportlWebView loadRequest:request];
    [_virtuaImportlWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_virtuaImportlWebView];

    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(0, _virtuaImportlWebView.frame.size.height+_virtuaImportlWebView.frame.origin.y, WIDTH, 1);
    lineLabel.backgroundColor = RGBACOLOR(190, 190, 190, 1.0f);
    [self.view addSubview:lineLabel];
    
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.frame = CGRectMake(40, lineLabel.frame.origin.y+lineLabel.frame.size.height, WIDTH-2*40, HEIGHT-_virtuaImportlWebView.frame.size.height+44);
    _tipLabel.numberOfLines = 0;
    _tipLabel.text = @"请使用51Job账号进行登录";
    _tipLabel.textColor = RGBACOLOR(0, 203, 251, 1.0f);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont fontWithName:@"Helvetica-Blod" size:14];
    [self.view addSubview:_tipLabel];
    
    
    _importButton = [[UIButton alloc]init];
    _importButton.frame = CGRectMake(80, lineLabel.frame.origin.y+lineLabel.frame.size.height+35, WIDTH - 2*80, 40);
    [_importButton setTitle:@"导 入 此 简 历" forState:UIControlStateNormal];
    [_importButton.layer setMasksToBounds:YES];
    [_importButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [_importButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    _importButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    _importButton.hidden = YES;
    _importButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    _importButton.layer.borderWidth = 1.0f;
    [_importButton addTarget:self action:@selector(importResume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_importButton];
    
    [self timeAction];
    
}

#pragma mark --  计时器  每秒执行一次方法  建议使用 - (void )webViewDidFinishLoad:(UIWebView  *)webView 方法来调用 lookWebUrl 方法
-(void)timeAction{

    __block int timeout=90; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置

                
            });
        }else{
            // int minutes = timeout / 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                
                [self lookWebUrl];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -- 获取51job网页url地址
-(void)lookWebUrl{

    NSString *urlLastPathComponent =_virtuaImportlWebView.request.URL.lastPathComponent;
    
    // 51job网页url地址后缀分别为login.php / myresume.php resumepreview.php
    if ([urlLastPathComponent isEqual:@"/"]) {
    
        _tipLabel.text = @"点击 我的简历";
        
    }else if([urlLastPathComponent isEqual:@"myresume.php"]){
    
        _tipLabel.text = @"预览需要导入的简历";
    
    }else if([urlLastPathComponent isEqual:@"resumepreview.php"]){
    
        _tipLabel.hidden = YES;
        _importButton.hidden = NO;

    }
        

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    
    // UIWebViewNavigationTypeOther
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        if([[UIApplication sharedApplication]canOpenURL:url])
        {
            //[[UIApplication sharedApplication]openURL:url];
        }
    }
    return YES;
}


#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//NSString *js = @"document.getElementById('lg')";
//NSString *pageSource = [webView stringByEvaluatingJavaScriptFromString:js];
//NSLog(@"pagesource:%@", pageSource);

#pragma mark -- 导入简历
-(void)importResume{
    
    NSString *urlLastPathComponent =_virtuaImportlWebView.request.URL.lastPathComponent;
    
    if ([urlLastPathComponent isEqual:@"resumepreview.php"]) {
        
        NSString *lJsHtml = @"document.documentElement.innerHTML";
        NSString *resumeHtml = [_virtuaImportlWebView stringByEvaluatingJavaScriptFromString:lJsHtml];
        
        NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
        [dic setObject:resumeHtml forKey:@"html"];
        
        [Resume importResume:dic WithBlock:^(Resume *resume, Error *e) {
            
            //NSLog(@"%@",resume.res);
            
            if ([resume.res isEqualToString:@"1"]) {

                [APIClient showSuccess:nil title:@"导入成功"];
                
                MainViewController *mainVC = [[MainViewController alloc]init];
                [self presentViewController:mainVC animated:YES completion:nil];
                
            }else{

                [APIClient showMessage:e.info title:@"导入失败"];
            }
        }];
        
        
        
    }else{
        
        [APIClient showMessage:@"未在简历预览界面" title:@"导入失败"];
    
    }
    
}

////网页 刚开始加载
//- (void )webViewDidStartLoad:(UIWebView  *)webView{
//    
//    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//}
//
////网页 加载完成
//- (void )webViewDidFinishLoad:(UIWebView  *)webView{
//    
//    [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
//}

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
