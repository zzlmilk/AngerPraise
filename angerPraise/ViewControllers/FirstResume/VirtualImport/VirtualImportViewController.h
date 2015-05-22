//
//  VirtualImportViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/3/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MYBlurIntroductionView.h"
#import "BaseViewController.h"

@interface VirtualImportViewController : BaseViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *virtuaImportlWebView;

@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UIButton *importButton;


@end
