//
//  PositionDetailViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/15.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PositionDetailViewController : BaseViewController<UIWebViewDelegate>


@property(nonatomic,strong)UIWebView *positionDetailWebView;
@property(nonatomic,strong) NSString *positionDetailUrl;
@end
