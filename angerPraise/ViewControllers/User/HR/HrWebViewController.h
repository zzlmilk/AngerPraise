//
//  HRWebViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HrWebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *hrWebView;

@property(nonatomic,strong)NSString *hrUrl;


@end
