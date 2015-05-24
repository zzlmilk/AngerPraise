//
//  PreviewResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/17.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "SMS_MBProgressHUD.h"

#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>

@interface PreviewResumeViewController ()

@end

@implementation PreviewResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 44, 44);
    [_backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(WIDTH-44, 0, 44, 44);
    [_shareBtn setImage:[UIImage imageNamed:@"0share"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareResume)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:_shareBtn];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    _previewResumeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+65)];
    _previewResumeWebView.delegate = self;
    
//    _resumePreviewUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"previewResumeUrl"];
    
    //NSURL *url=[NSURL URLWithString:_resumePreviewUrl];
    NSURL *url =[NSURL URLWithString:@"http://app.hirelib.com/website/user/user_resume?user_id=1"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_previewResumeWebView loadRequest:request];
    [_previewResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_previewResumeWebView];
}

-(void)shareResume{

    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"我通过<怒赞APP>对你进行了点评，点击链接 www.baidu.com下载查看"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"我的简历"
                                                  url:@"http://app.hirelib.com/website/user/user_resume?user_id=1"
                                          description:@"简历"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    //  NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    //NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                }
                            }];


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
