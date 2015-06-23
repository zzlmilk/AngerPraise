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

#import "UIView+i7Rotate360.h"

#import "IndexViewController.h"
#import "Home.h"
#import "WalletWebViewController.h"


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
    
    _isString = 0;
    _addPage = 0;
    
    self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
    _titleView = [[UIView alloc]init];
    _titleView.frame =CGRectMake(0, 0, WIDTH, 50);
    _titleView.backgroundColor = RGBACOLOR(40, 40, 40, 1.0f);
    [self.view addSubview:_titleView];
    
    _hrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _hrBtn.frame = CGRectMake((WIDTH-44), 0, 44, 44);
    [_hrBtn setImage:[UIImage imageNamed:@"0homepage_hr"] forState:UIControlStateNormal];
    _hrBtn.backgroundColor = [UIColor clearColor];
    [_hrBtn addTarget:self action:@selector(isUserType)forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_hrBtn];

    
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _singleTap.cancelsTouchesInView = NO;
    _singleTap.enabled = NO;
    [self.navigationController.navigationBar addGestureRecognizer:_singleTap];

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
    _tipNumberLabel.text = @"0/25";
    _tipNumberLabel.textColor = hl_blue;
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
    _scoreImageView = [[UIImageView alloc]init];
    _scoreImageView.frame = CGRectMake(_vFlowView.frame.size.width+_vFlowView.frame.origin.x+5, 20, 38, 38);
    _scoreImageView.layer.cornerRadius = 38/2.f;
    [_scoreImageView setClipsToBounds:YES];
//    scoreImageView.backgroundColor = RGBACOLOR(0, 199, 255, 1.0f);
    [_scoreImageView setImage:[UIImage imageNamed:@"0blue_circle"]];
    [rolliew addSubview:_scoreImageView];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.frame = CGRectMake(0, 0, _scoreImageView.frame.size.width, _scoreImageView.frame.size.height);
    _scoreLabel.text = @"0/25";
    _scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    [_scoreImageView addSubview:_scoreLabel];
    
    UIButton *lookScoreButton = [[UIButton alloc]init];
    lookScoreButton.frame = _scoreImageView.frame;
    [lookScoreButton addTarget:self action:@selector(lookScore) forControlEvents:UIControlEventTouchUpInside];
    lookScoreButton.backgroundColor = [UIColor clearColor];
    [rolliew addSubview:lookScoreButton];
    
    
    UILabel *scoreTipLabel= [[UILabel alloc]init];
    scoreTipLabel.frame = CGRectMake(_scoreImageView.frame.origin.x, _scoreImageView.frame.size.height+_scoreImageView.frame.origin.y, _scoreImageView.frame.size.width+5, 20);
    scoreTipLabel.textAlignment = NSTextAlignmentCenter;
    scoreTipLabel.text = @"综合评分";
    scoreTipLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
    scoreTipLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
    [rolliew addSubview:scoreTipLabel];
    //综合评分 结束
    
     if (_bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    
    _homeWebView = [[UIWebView alloc] init];
    _homeWebView.frame = CGRectMake(10, rolliew.frame.size.height+rolliew.frame.origin.y,WIDTH-2*10, HEIGHT - rolliew.frame.size.height-rolliew.frame.origin.y-60);
    _homeWebView.layer.cornerRadius = 10.f;
    [_homeWebView setClipsToBounds:YES];
    [[_homeWebView layer]setBorderColor:[UIColor blackColor].CGColor];
    [[_homeWebView layer]setBorderWidth:1.0f];
    _homeWebView.tag = 1001;
    _homeWebView.delegate = self;
    _homeWebView.scrollView.delegate = self;
//    [_homeWebView setUserInteractionEnabled:YES];
    _homeWebView.scrollView.bounces = NO;
    [self hideScroll];
    [self.view addSubview:_homeWebView];
    
    //webview  添加手势
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizerRight.delegate = self;
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_homeWebView addGestureRecognizer:recognizerRight];
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizerLeft.delegate = self;
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_homeWebView addGestureRecognizer:recognizerLeft];
    
    
    
    
    _maskView = [[UIView alloc]init];
    _maskView.frame = self.view.frame;
    _maskView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
    _maskView.hidden = YES;
    [self.view addSubview:_maskView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_maskView addGestureRecognizer:tapGestureRecognizer];
    
    
    UIView *whiteBgView = [[UIView alloc]init];
    whiteBgView.frame = CGRectMake(35, 180, WIDTH-2*35,HEIGHT*0.458);//将高度固定
    whiteBgView.backgroundColor =[UIColor whiteColor];
    [_maskView addSubview:whiteBgView];
    
    UIView *textView = [[UIView alloc]init];
    textView.frame = CGRectMake(2,2,whiteBgView.frame.size.width-2*2,140);
    textView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0F);
    [whiteBgView addSubview:textView];
    
    _weixinButton = [[UIButton alloc]init];
    _weixinButton.frame = CGRectMake(40, textView.frame.size.height+textView.frame.origin.y+40, 40, 40);
    _weixinButton.backgroundColor = [UIColor clearColor];
    [_weixinButton setImage:[UIImage imageNamed:@"0wechat3"] forState:UIControlStateNormal];
    [whiteBgView addSubview:_weixinButton];
    
    _momentButton = [[UIButton alloc]init];
    _momentButton.frame = CGRectMake(whiteBgView.frame.size.width-_weixinButton.frame.size.width-_weixinButton.frame.origin.x, textView.frame.size.height+textView.frame.origin.y+40, 40, 40);
    [_momentButton setImage:[UIImage imageNamed:@"0moment"] forState:UIControlStateNormal];
    _momentButton.backgroundColor = [UIColor clearColor];
    [whiteBgView addSubview:_momentButton];
    
    
    [self getCommentFriendInfo];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_homeWebView webViewDelegate:self handler:^(NSString *data, WVJBResponseCallback responseCallback) {
        //NSLog(@"ObjC received message from JS: %@", data);
        if ([data isEqualToString:@"pay"]) {
            
            [self getMyPayUrlString];
            
        }
        if ([data isEqualToString:@"wechat_invite"]) {
            
            [self weiXinShare:data];
            
        }
        if([data isEqualToString:@"pengyouquan_invite"]){
            
            [self weiXinShare:data];
            
        }
        if([data isEqualToString:@"wechat_competitiveness"]){
            
            [self weiXinShare:data];
            
        }
        if ([data isEqualToString:@"pengyouquan_competitiveness"]){
            
            [self weiXinShare:data];
            
        }
        if ([data isEqualToString:@"user_review_success"]){
            
            [self revirewSuccess];
            
        }
        if ([data isEqualToString:@"hr_intview_success"]){
            
            [self hrPrivilege];
            
        }
        if ([data isEqualToString:@"next_user_review"]){
            
            [self webViewNextOne];
            
        }
        
    }];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}

#pragma mark -  webview 手势
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        //NSLog(@"swipe left");
        
        //执行程序
        [self webViewNextOne];
        
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        //NSLog(@"swipe right");
        
        //执行程序
        [self webViewPreviousOne];
    }
}


-(void)hideMaskView{

    _maskView.hidden = YES;
}

#pragma mark -  隐藏webview 滚动条
-(void)hideScroll{

    for (UIView *_aView in [_homeWebView subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            //右侧的滚动条
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            
            //下侧的滚动条
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
        }
    }
    
}
#pragma mark -  禁止webview上下 左右滚动滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x > 0) {
        scrollView.contentOffset = CGPointMake(0, point.y);
    }
    
    if(point.y>0){
    
        scrollView.contentOffset = CGPointMake(0, point.x);
        
    }
}

#pragma mark -  微信分享   提高竞争力/邀请好友
-(void)weiXinShare:(NSString *)data{
    
    //调用接口 获取相关地址和文案
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
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
                          
                      }
                      if([data isEqualToString:@"pengyouquan_invite"]){
                          
                          [self sendLinkContentByMoment];
                          
                      }
                      if([data isEqualToString:@"wechat_competitiveness"]){
                          
                          [self sendLinkContentByWeiXin];
                          
                      }
                      if ([data isEqualToString:@"pengyouquan_competitiveness"]){
                          
                          [self sendLinkContentByMoment];
                          
                      }

                  }
              }];

}

#pragma mark - 点击我的钱包 获取钱包的url

-(void)getMyPayUrlString{

    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    
    [Home getMyPayUrlString:dic WithBlock:^(Home *home, Error *e) {
        
        if (home.payUrlString) {
            
            WalletWebViewController * walletWebVC = [[WalletWebViewController alloc]init];
            walletWebVC.walletUrl = home.payUrlString;
            
            [self.navigationController pushViewController:walletWebVC animated:YES];
        }
        
    }];
    
}


#pragma mark -  点评成功后 重新获取更新金币和综合评分
-(void)revirewSuccess{

    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    
    [CommentFriend reviewSuccess:dic WithBlock:^(CommentFriend *commentFriend, Error *e) {
        
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
            
            _tipNumberLabel.text = [NSString stringWithFormat:@"%@/%@",commentFriend.today_receive_award,commentFriend.today_award_total];
            
            _scoreLabel.text = commentFriend.synthesize_grade;
            _scoreUrlString = commentFriend.synthesize_grade_url;
            //改变水位高度
            float alreadyNumber = [commentFriend.today_receive_award floatValue];
            float countNumber = [commentFriend.today_award_total floatValue];
            
            [self calWaterHeightWithalreadyNumber:alreadyNumber countNumber:countNumber];
            
        }
        
    }];
    
    
}


#pragma mark - 调用Hr特权接口
-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    CGPoint point= [sender locationInView:self.view];
    
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    if (point.x >(WIDTH-45) && point.y<45) {
        
        [self isUserType];
        
    }
    
}


#pragma mark - 判断用户属性
-(void)isHR{
    
    NSUserDefaults *hrPrivilege = [NSUserDefaults standardUserDefaults];
    NSString *hrStringNumber = [NSString stringWithFormat:@"%@",[hrPrivilege objectForKey:@"hrPrivilege"]];
    
    if ([hrStringNumber isEqualToString:@"0"]) { //不是hr
        
        _hrBtn.hidden = YES;
        
    }
    if([hrStringNumber isEqualToString:@"1"]){ //是 HR
        
        _singleTap.enabled = YES;
        
        
    }
    
}

#pragma mark -  hr接口和 普通用户进行切换调用
-(void)isUserType{
    
    //如果 hr剩余任务 大于0 则可以点击 hr按钮 进入hr特权 嗲用switch 否则 提示 暂时没有HR任务
    
    if (_intInterviewNumber >0) {
        
        switch (_isString) {
            case 0:
            {
                [self hrPrivilege];
                _isString = 1;
            }
                break;
            case 1:
            {
                [self getCommentFriendInfo];
                _isString = 0;
            }
                break;
                
            default:
                break;
        }
        
    }else{
        
        [APIClient showMessage:@"暂时没有HR任务哦～"];
        
    }
    
}

#pragma mark - 调用接口 获取 首页接口数据 普通用户
-(void)getCommentFriendInfo{
    
    [self isHR];
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];

    [CommentFriend getCommentFriendList:dic WithBlock:^(CommentFriend *commentFriend, Error *e) {
        
        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (e.info !=nil) {
            
            NSString *codeString = [NSString stringWithFormat:@"%@",e.code];
            
            if ([codeString isEqualToString:@"104"]) {// 服务端token不存在
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:e.info
                                                                message:@"请重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];

            }else{
                
            [APIClient showMessage:e.info];
                
            }
            
        }else{
            
            _intInterviewNumber = [commentFriend.interview_number intValue];
            
            if (_intInterviewNumber > 0) { // hr 有未读状态
                
                [_hrBtn setImage:[UIImage imageNamed:@"0homepage_hr2"] forState:UIControlStateNormal];
            }
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
#pragma marks -- UIAlertViewDelegate --
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        
        NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
        [token removeObjectForKey:@"token"];
        
        NSUserDefaults *hrPrivilege = [NSUserDefaults standardUserDefaults];
        [hrPrivilege removeObjectForKey:@"hrPrivilege"];
        
        IndexViewController *indexVC= [[IndexViewController alloc]init];
        [self.navigationController pushViewController:indexVC animated:YES];
        
    }
}



#pragma mark - hr 特权
-(void)hrPrivilege{
    
    [_hrBtn setImage:[UIImage imageNamed:@"0homepage_hr"] forState:UIControlStateNormal];
    
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [CommentFriend getHrReviewInfo:dic WithBlock:^(CommentFriend *commentFriend, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
            
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

#pragma mark - 综合评分翻转动画
- (void)actionRotation
{
    [self performSelector:@selector(headPhotoAnimation) withObject:nil afterDelay:0.7];
    
}

#pragma mark - 综合评分翻转动画
- (void)headPhotoAnimation
{
    [_scoreImageView rotate360WithDuration:2.0 repeatCount:1 timingMode:i7Rotate360TimingModeLinear];
    _scoreImageView.animationDuration = 2.0;
    _scoreImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"0blue_circle"],
                                      [UIImage imageNamed:@"0blue_add"],[UIImage imageNamed:@"0blue_add"],
                                      [UIImage imageNamed:@"0blue_add"],[UIImage imageNamed:@"0blue_add"],
                                      [UIImage imageNamed:@"0blue_circle"], nil];
    _scoreImageView.animationRepeatCount = 1;
    [_scoreImageView startAnimating];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 点击 下一个(暂不点评)
-(void)webViewNextOne{

    // NSLog(@"%ld",(long)_vFlowView.currentPageIndex+1);
    //[_vFlowView scrollToPage:_vFlowView.currentPageIndex+1];
    //    self flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index
    
    if (_addPage == _collectionArray.count-1) {
        
        [APIClient showMessage:@"已经是最后一位啦!"];
        
    }else{
        
        _addPage = _addPage+1;
        [_vFlowView scrollToPage:_addPage];
        
        [self flowView:_vFlowView didScrollToPageAtIndex:_addPage];
    }
    
}
#pragma mark - 点击 上一个(暂不点评)
-(void)webViewPreviousOne{
    
    // NSLog(@"%ld",(long)_vFlowView.currentPageIndex+1);
    //[_vFlowView scrollToPage:_vFlowView.currentPageIndex+1];
    //    self flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index
    
    if (_addPage ==0) {
        
        [APIClient showMessage:@"已经是第一位啦!"];

    }else{
        
        _addPage = _addPage-1;
        
        [_vFlowView scrollToPage:_addPage];
        
        [self flowView:_vFlowView didScrollToPageAtIndex:_addPage];
    }


    
}



#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(58, 58);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    
   //NSLog(@"Scrolled to page # %ld", (long)index);
    
    _addPage = (int)index;
    
    if (_commondUrlArray.count != 0 && _addPage <_collectionArray.count){
        
        NSURL *url=[NSURL URLWithString:[_commondUrlArray objectAtIndex:index]];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        [_homeWebView loadRequest:request];
    }
}

//- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
//    
//    index = _addPage;
//    
//    NSLog(@"Tapped on page # %ld", (long)index);
//    
//    NSURL *url=[NSURL URLWithString:[_commondUrlArray objectAtIndex:index]];
//    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
//    [_homeWebView loadRequest:request];
//    
//}

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

    [imageView setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
    
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
