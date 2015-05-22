//
//  MyFriendWebViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFriendWebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *myfriendWebView;

@property(nonatomic,strong)NSString *myFriendUrl;


@end
