//
//  CommentFriendWebViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CommentFriendWebViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *commentFriendWebView;

@property(nonatomic,strong)NSString *commentFriendUrl;

@end
