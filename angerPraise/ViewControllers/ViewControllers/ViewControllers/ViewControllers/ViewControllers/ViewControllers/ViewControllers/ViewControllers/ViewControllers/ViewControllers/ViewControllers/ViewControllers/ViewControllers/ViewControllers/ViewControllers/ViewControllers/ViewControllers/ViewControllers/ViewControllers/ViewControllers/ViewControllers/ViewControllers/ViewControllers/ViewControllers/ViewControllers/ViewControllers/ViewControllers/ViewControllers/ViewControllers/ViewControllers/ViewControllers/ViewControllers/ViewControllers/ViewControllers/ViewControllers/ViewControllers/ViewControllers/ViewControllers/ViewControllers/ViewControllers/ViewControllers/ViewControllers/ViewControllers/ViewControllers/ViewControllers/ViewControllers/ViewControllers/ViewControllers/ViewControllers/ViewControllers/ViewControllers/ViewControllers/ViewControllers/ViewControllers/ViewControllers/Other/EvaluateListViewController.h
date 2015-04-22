//
//  EvaluateListViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/3/12.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EvaluateListViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *evaluateListWebView;

@end
