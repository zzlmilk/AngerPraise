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


@interface HomeViewController : BaseViewController<UIWebViewDelegate,PagedFlowViewDataSource,PagedFlowViewDelegate,MBProgressHUDDelegate>
{
NSMutableArray *imageArray;

enum WXScene _scene;
}

- (void) changeScene:(NSInteger)scene;
- (void) sendLinkContentByWeiXin;

- (void) sendLinkContentByMoment;

@property (nonatomic, strong) PagedFlowView *vFlowView;
@property (nonatomic, strong) UIPageControl *hPageControl;

@property (nonatomic, strong) UIButton *hrBtn;
@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIWebView *homeWebView;
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSString *scoreUrlString;

@property(nonatomic,strong)UILabel *tipNumberLabel;

@property(nonatomic,strong)UILabel *scoreLabel;

@property(nonatomic,strong)NSMutableArray *collectionArray;

@property(nonatomic,strong)NSMutableArray *imgArray;
@property(nonatomic,strong)NSMutableArray *commondUrlArray;

@property float waterHeight;

@property(nonatomic,strong)VWWWaterView *waterView;

@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)UILabel *inviteLabel;
@property(nonatomic,strong)UILabel *inviteLabel2;
@property(nonatomic,strong)UIButton *weixinButton;
@property(nonatomic,strong)UIButton *momentButton;



@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;


@end
