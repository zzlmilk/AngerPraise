//
//  PreviewResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/17.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PreviewResumeViewController.h"
#import "SMS_MBProgressHUD.h"
#import "WXApi.h"


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
    _previewResumeWebView.scrollView.bounces = NO;
    
    NSURL *url =[NSURL URLWithString:_resumePreviewUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_previewResumeWebView loadRequest:request];
    [_previewResumeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_previewResumeWebView];
    
    _shareView = [[UIView alloc]init];
    _shareView.frame = CGRectMake(0, 0, WIDTH, 160);
    _shareView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
    _shareView.hidden = YES;
    [self.view addSubview:_shareView];
    
    UILabel *shanreLabel = [[UILabel alloc]init];
    shanreLabel.frame = CGRectMake(0, 0, WIDTH, 45);
    shanreLabel.backgroundColor = RGBACOLOR(0, 0, 0, 0.8);
    shanreLabel.textColor = RGBACOLOR(252, 254, 253, 1.0f);
    shanreLabel.text = @"     分享简历";
    [_shareView addSubview:shanreLabel];
    
    UIButton *weixinButton = [[UIButton alloc]init];
    weixinButton.frame = CGRectMake(0, shanreLabel.frame.size.height+shanreLabel.frame.origin.y, WIDTH, 55);
    weixinButton.backgroundColor = [UIColor clearColor];
    [weixinButton setTitle:@" 微 信" forState:UIControlStateNormal];
    [weixinButton setImage:[UIImage imageNamed:@"0wechat1"] forState:UIControlStateNormal];
    [weixinButton setImage:[UIImage imageNamed:@"0wechat2"] forState:UIControlStateHighlighted];
    [weixinButton addTarget:self action:@selector(sendLinkContent) forControlEvents:UIControlEventTouchUpInside];
    weixinButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [weixinButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(WIDTH/2-50), 0, 50)];
    [weixinButton setImageEdgeInsets:UIEdgeInsetsMake(0, -(WIDTH/2+30), 0, 0)];
    
    [_shareView addSubview:weixinButton];
    
    UILabel *lineLabel= [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(0, weixinButton.frame.size.height+weixinButton.frame.origin.y, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(252, 254, 253, 1.0f);
    [_shareView addSubview:lineLabel];
    
    UIButton *emailButton = [[UIButton alloc]init];
    emailButton.frame = CGRectMake(0, lineLabel.frame.size.height+lineLabel.frame.origin.y, WIDTH, 55);
    [emailButton setTitle:@" 邮 件" forState:UIControlStateNormal];
    [emailButton setImage:[UIImage imageNamed:@"0email1"] forState:UIControlStateNormal];
    [emailButton setImage:[UIImage imageNamed:@"0email2"] forState:UIControlStateHighlighted];
    [emailButton addTarget:self action:@selector(sendResumeByEmail) forControlEvents:UIControlEventTouchUpInside];

    [emailButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(WIDTH/2-50), 0, 50)];
    [emailButton setImageEdgeInsets:UIEdgeInsetsMake(0, -(WIDTH/2+30), 0, 0)];
    emailButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    emailButton.backgroundColor = [UIColor clearColor];
    [_shareView addSubview:emailButton];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [tapGestureRecognizer setDelegate:self];
    [_previewResumeWebView.scrollView addGestureRecognizer:tapGestureRecognizer];
    
    
}

-(void) changeScene:(NSInteger)scene
{
    _scene = scene;
}

#pragma mark -- 通过微信分享简历
- (void) sendLinkContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"个人简历";
    message.description = @"快快查看我的怒赞简历哦～";
    [message setThumbImage:[UIImage imageNamed:@"0logooutapp"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = _resumePreviewUrl;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}

#pragma mark -- 通过邮件分享简历
-(void)sendResumeByEmail{

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"怒赞简历"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"example@email.com"];
    
    [picker setToRecipients:toRecipients];
    
    // Attach an image to the email
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@""];
    
    [picker setMessageBody:_resumePreviewUrl
                isHTML:YES];
    
    // Fill out the email body text

    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark -- 取消邮件分享
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- 隐藏键盘
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    _shareBtn.hidden = NO;
    _backBtn.hidden = NO;
    _shareView.hidden = YES;
  
    return YES;
}



#pragma mark -- 点击分享
-(void)shareResume{
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [_shareView.layer addAnimation:animation forKey:nil];

    _backBtn.hidden = YES;
    _shareView.hidden = NO;
}

-(void)doBack{
    
    if (_previewResumeWebView.canGoBack)
    {
        [_previewResumeWebView goBack];
        
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
