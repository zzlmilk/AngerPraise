//
//  HomeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PagedFlowView.h"
#import "WXApiObject.h"
#import "SMS_MBProgressHUD.h"
#import "VWWWaterView.h"
#import "HomeTitleView.h"
#import "User.h"

// view
#import "SynthesizeView.h"

@interface HomeViewController : BaseViewController<UIWebViewDelegate,PagedFlowViewDataSource,PagedFlowViewDelegate,MBProgressHUDDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    NSMutableArray *imageArray;
    
    HomeTitleView *homeTitleView;

    enum WXScene _scene;
}

@property (nonatomic, strong)SynthesizeView *synthesizeView;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) PagedFlowView *vFlowView;
@property (nonatomic, strong) UIPageControl *hPageControl;

@property (nonatomic, strong) UIButton *hrBtn;
@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *scoreImageView;

@property(nonatomic,strong)UIWebView *homeWebView;
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSString *scoreUrlString;

@property(nonatomic,strong)UILabel *tipNumberLabel;

@property(nonatomic,strong)UILabel *scoreLabel;

@property(nonatomic,strong)NSMutableArray *collectionArray;

@property(nonatomic,strong)NSMutableArray *imgArray;
@property(nonatomic,strong)NSMutableArray *commondUrlArray;

@property(nonatomic,strong)UITapGestureRecognizer* singleTap;

@property float waterHeight;

@property(nonatomic,strong)VWWWaterView *waterView;

@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UILabel *inviteLabel;
@property(nonatomic,strong)UILabel *inviteLabel2;
@property(nonatomic,strong)UIButton *weixinButton;
@property(nonatomic,strong)UIButton *momentButton;

@property  int isString;

@property int intInterviewNumber;
@property int addPage;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;

@property(nonatomic,strong)NSString *payUrlString;

- (void) changeScene:(NSInteger)scene;
- (void) sendLinkContentByWeiXin;

- (void) sendLinkContentByMoment;

//获取点可评用户信息
-(void)loadData;


@end
