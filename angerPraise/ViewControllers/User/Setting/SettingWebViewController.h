//
//  SettingWebViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface SettingWebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *settingWebView;
@property(nonatomic,strong) NSString *settingDetailUrl;

@end
