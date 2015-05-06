//
//  MyDynamicViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyDynamicViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *myDynamicWebView;


@end
