//
//  QAResumeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface QAResumeViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *qaResumeWebView;
@property(nonatomic,strong) NSString *qaResumeUrl;

@end
