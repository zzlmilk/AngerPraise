//
//  PerfectViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/7/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface PerfectResumeViewController : BaseViewController<UIWebViewDelegate>


@property(nonatomic,strong)UIWebView *perfectResumeWebView;
@property(nonatomic,strong) NSString *perfectResumeUrl;

@end
