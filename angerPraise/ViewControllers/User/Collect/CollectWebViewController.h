//
//  CollectWebViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectWebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *collectWebView;

@property(nonatomic,strong)NSString *collectUrl;

@end
