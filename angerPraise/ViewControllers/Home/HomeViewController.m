//
//  HomeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeViewController.h"
#import "InfiniteScrollPicker.h"
#import "SMS_MBProgressHUD.h"

#import "CommentFriendCell.h"
#import "CommentFriend.h"
#import "UIImageView+AFNetworking.h"
#import "ApIClient.h"
#import "VWWWaterView.h"
#import "Review.h"

#import "WXApi.h"

#import "WebViewJavascriptBridge.h"
#import "Share.h"

#define F2I  (*((int *)&f))

@interface HomeViewController ()
{
    InfiniteScrollPicker *isp;
}
@property WebViewJavascriptBridge* bridge;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
    _titleView = [[UIView alloc]init];
    _titleView.frame =CGRectMake(0, 0, WIDTH, 50);
    _titleView.backgroundColor = RGBACOLOR(40, 40, 40, 1.0f);
    [self.view addSubview:_titleView];
    
    _hrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hrBtn.frame = CGRectMake((WIDTH-44-10), 0, 44, 44);
    [_hrBtn setImage:[UIImage imageNamed:@"0homepage_hr"] forState:UIControlStateNormal];
    _hrBtn.hidden = YES;
    [_hrBtn addTarget:self action:@selector(hrPrivilege)forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_hrBtn];
    
    
    UIButton *titleButton= [[UIButton alloc]init];
    titleButton.frame = CGRectMake((WIDTH-118/2)/2, 15, 118/2, 38/2);
    [titleButton setTitle:@"怒         赞" forState:UIControlStateNormal];
    [titleButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [titleButton setTitleColor:RGBACOLOR(177, 179, 180, 1.0f) forState:UIControlStateNormal];
    titleButton.backgroundColor = [UIColor clearColor];
    [_titleView addSubview:titleButton];
    
    UIImageView *titleLogoImageView = [[UIImageView alloc]init];
    titleLogoImageView.frame =titleButton.frame;
    titleLogoImageView.image = [UIImage imageNamed:@"0logoathomepage"];
    titleLogoImageView.backgroundColor = [UIColor clearColor];
    [_titleView addSubview:titleLogoImageView];
    
    
    UIView *rolliew = [[UIView alloc]init];
    rolliew.frame = CGRectMake(0, _titleView.frame.size.height+_titleView.frame.origin.y, WIDTH, 80);
    rolliew.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rolliew];
    
    //点评赏银 开始
//    UIImageView *tipImageView = [[UIImageView alloc]init];
//    tipImageView.frame = CGRectMake(5, 15, 45, 45);
//    [tipImageView setImage:[UIImage imageNamed:@"0bonus1"]];
//    [rolliew addSubview:tipImageView];
    
    _waterView = [[VWWWaterView alloc]init];
    _waterView.backgroundColor = [UIColor whiteColor];
    _waterView.frame = CGRectMake(20, 20, 38, 38);
    _waterView.layer.cornerRadius = 38/2.f;
    [_waterView setClipsToBounds:YES];
    [_waterView setCurrentLinePointY:30]; //min 38   max 0
    [rolliew addSubview:_waterView];
    
    _tipNumberLabel = [[UILabel alloc]init];
    _tipNumberLabel.frame = CGRectMake(0, 0, _waterView.frame.size.width, _waterView.frame.size.height);
    _tipNumberLabel.text = @"...";
    _tipNumberLabel.textColor = RGBACOLOR(255, 153, 51, 1.0f);
    _tipNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    _tipNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_waterView addSubview:_tipNumberLabel];
    
    UILabel *tipTextLabel= [[UILabel alloc]init];
    tipTextLabel.frame = CGRectMake(20, _waterView.frame.size.height+_waterView.frame.origin.y, _waterView.frame.size.width+5, 20);
    tipTextLabel.textAlignment = NSTextAlignmentCenter;
    tipTextLabel.text = @"点评赏银";
    tipTextLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
    tipTextLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
    [rolliew addSubview:tipTextLabel];
    //点评赏银 结束

//    imageArray = [[NSMutableArray alloc] initWithObjects:@"exampleCover",@"exampleCover",nil];
    
    _vFlowView = [[PagedFlowView alloc]init];
    _vFlowView.frame = CGRectMake(tipTextLabel.frame.size.width+tipTextLabel.frame.origin.x,0, WIDTH-45-20-45-20, rolliew.frame.size.height);
    _vFlowView.backgroundColor = [UIColor clearColor];
    _vFlowView.delegate = self;
    _vFlowView.dataSource = self;
    _vFlowView.layer.cornerRadius =rolliew.frame.size.height/2;
    [_vFlowView setClipsToBounds:YES];
    _vFlowView.pageControl = _hPageControl;
    _vFlowView.minimumPageAlpha = 0.3;
    _vFlowView.minimumPageScale = 0.8;
    [rolliew addSubview:_vFlowView];
    
    
    //综合评分 开始
    UIImageView *scoreImageView = [[UIImageView alloc]init];
    scoreImageView.frame = CGRectMake(_vFlowView.frame.size.width+_vFlowView.frame.origin.x+5, 20, 38, 38);
    scoreImageView.layer.cornerRadius = 38/2.f;
    [scoreImageView setClipsToBounds:YES];
    scoreImageView.backgroundColor = RGBACOLOR(0, 199, 255, 1.0f);
    [rolliew addSubview:scoreImageView];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.frame = CGRectMake(0, 0, scoreImageView.frame.size.width, scoreImageView.frame.size.height);
    _scoreLabel.text = @"...";
    _scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    [scoreImageView addSubview:_scoreLabel];
    
    UIButton *lookScoreButton = [[UIButton alloc]init];
    lookScoreButton.frame = scoreImageView.frame;
    [lookScoreButton addTarget:self action:@selector(lookScore) forControlEvents:UIControlEventTouchUpInside];
    lookScoreButton.backgroundColor = [UIColor clearColor];
    [rolliew addSubview:lookScoreButton];
    
    
    UILabel *scoreTipLabel= [[UILabel alloc]init];
    scoreTipLabel.frame = CGRectMake(scoreImageView.frame.origin.x, scoreImageView.frame.size.height+scoreImageView.frame.origin.y, scoreImageView.frame.size.width+5, 20);
    scoreTipLabel.textAlignment = NSTextAlignmentCenter;
    scoreTipLabel.text = @"综合评分";
    scoreTipLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
    scoreTipLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
    [rolliew addSubview:scoreTipLabel];
    //综合评分 结束
    
    
    [self getCommentFriendInfo];
    [self isHR];
    
     if (_bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    
    _homeWebView = [[UIWebView alloc] init];
    _homeWebView.frame = CGRectMake(0, rolliew.frame.size.height+rolliew.frame.origin.y,WIDTH, HEIGHT - rolliew.frame.size.height-rolliew.frame.origin.y-60);
    _homeWebView.layer.cornerRadius = 10.f;
    [_homeWebView setClipsToBounds:YES];
    [[_homeWebView layer]setBorderColor:[UIColor blackColor].CGColor];
    [[_homeWebView layer]setBorderWidth:1.0f];
    _homeWebView.delegate = self;
    [_homeWebView setUserInteractionEnabled:YES];
    _homeWebView.scrollView.bounces = NO;
    [self.view addSubview:_homeWebView];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_homeWebView webViewDelegate:self handler:^(NSString *data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        
        //调用接口 获取相关地址和文案
        
        NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
        [dic setObject:data forKey:@"string"];
        
        [Share getShareInfo:dic
                  WithBlock:^(Share *share, Error *e) {
                      
                      if (e.info !=nil) {
                          
                          [APIClient showMessage:e.info];
                          
                      }else{
                          
                          _shareTitle = share.title;
                          _shareContent = share.content;
                          
                          if ([data isEqualToString:@"wechat_invite"]) {
                              
                              [self sendLinkContentByWeiXin];
                              
                          }else if([data isEqualToString:@"pengyouquan_invite"]){
                              
                              [self sendLinkContentByMoment];
                              
                          }else if([data isEqualToString:@"wechat_competitiveness"]){
                              
                              [self sendLinkContentByWeiXin];
                              
                          }else if ([data isEqualToString:@"pengyouquan_competitiveness"]){
                              
                              [self sendLinkContentByMoment];
                              
                          }else if ([data isEqualToString:@"user_review_success"]){
                              
                              [self getCommentFriendInfo];
                              
                          }
                              
                      }
                      
                  }];
        
    }];
    
    
    
}



#pragma mark - 动态计算水位高度
-(void)calWaterHeightWithalreadyNumber:(float)alreadyNumber countNumber:(float)countNumber{

    if (alreadyNumber +countNumber ==0.0) {
        
        [_waterView setCurrentLinePointY:38];
        
    }else{
    
        float minWater= 38; //与水位等高
        //    float maxWater= 0.0f;
        
        _waterHeight = 38 - (alreadyNumber / countNumber *minWater);
        
        [_waterView setCurrentLinePointY:_waterHeight];
        
    }
    
}


#pragma mark - 改变发送通道 微信 or 朋友圈
-(void) changeScene:(NSInteger)scene
{
    _scene = scene;
}


#pragma mark - 通过 微信 发送链接
- (void) sendLinkContentByWeiXin
{
    [self changeScene:WXSceneSession];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = _shareTitle;
    message.description = nil;
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = _shareContent;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}
#pragma mark - 通过 朋友圈 发送链接
- (void) sendLinkContentByMoment
{
    [self changeScene:WXSceneTimeline];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = _shareTitle;
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = _shareContent;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}


#pragma mark - 调用接口 获取数据
-(void)getCommentFriendInfo{
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
//    [dic setObject:@"166" forKey:@"user_id"];
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [CommentFriend getCommentFriendList:dic WithBlock:^(CommentFriend *commentFriend, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
        
            // NSLog(@"%@",commentFriendArray);
            // _tipNumberLabel.text = commentFriend.user_intergral;
            
            _tipNumberLabel.text = [NSString stringWithFormat:@"%@/%@",commentFriend.today_receive_award,commentFriend.today_award_total];
            _scoreLabel.text = commentFriend.synthesize_grade;
            _scoreUrlString = commentFriend.synthesize_grade_url;
            
            _collectionArray = commentFriend.commentFriendArray;
            
            imageArray = [[NSMutableArray alloc]init];
            _commondUrlArray = [[NSMutableArray alloc]init];
            
            //改变水位高度
            float alreadyNumber = [commentFriend.today_receive_award floatValue];
            float countNumber = [commentFriend.today_award_total floatValue];

            [self calWaterHeightWithalreadyNumber:alreadyNumber countNumber:countNumber];
            
            for (int i =0; i<_collectionArray.count; i++) {
                Review *b = [[Review alloc]init];
                b = [_collectionArray objectAtIndex:i];
                
                [imageArray addObject:b.photo_url];
                [_commondUrlArray addObject:b.friend_evluation_url];
            }
            
            [_vFlowView reloadData];
            [self flowView:_vFlowView didScrollToPageAtIndex:0];
        }
    }];
}


-(void)isHR{

    NSUserDefaults *hrPrivilege = [NSUserDefaults standardUserDefaults];
    NSString *hrStringNumber = [NSString stringWithFormat:@"%@",[hrPrivilege objectForKey:@"hrPrivilege"]];
    
    if ([hrStringNumber isEqualToString:@"0"]) {
        
        _hrBtn.hidden = NO;
    }
}

#pragma mark - hr 特权
-(void)hrPrivilege{



}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(58, 58);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    
   // NSLog(@"Scrolled to page # %ld", (long)index);
    
    
    if (_commondUrlArray.count != 0){
    
        NSURL *url=[NSURL URLWithString:[_commondUrlArray objectAtIndex:index]];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        [_homeWebView loadRequest:request];
    }

}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
    
    //NSLog(@"Tapped on page # %ld", (long)index);
    
    NSURL *url=[NSURL URLWithString:[_commondUrlArray objectAtIndex:index]];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_homeWebView loadRequest:request];
    
}

#pragma mark 综合评分
-(void)lookScore{
    
    NSURL *url=[NSURL URLWithString:_scoreUrlString];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_homeWebView loadRequest:request];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    
    return [imageArray count];
    
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 58/2;
        imageView.layer.masksToBounds = YES;
    }

    [imageView setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    return imageView;
}



//网页 刚开始加载
- (void)webViewDidStartLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

//网页 加载完成
- (void)webViewDidFinishLoad:(UIWebView  *)webView{
    
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
