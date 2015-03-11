//
//  GuideFillViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"

@interface GuideFillViewController : UIViewController<MYIntroductionDelegate,UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *guideImportlWebView;

@property int secondsCountDown;

@property NSTimer *countDownTimer;

@end
