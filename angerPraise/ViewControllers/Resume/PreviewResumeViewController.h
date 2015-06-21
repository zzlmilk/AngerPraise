//
//  PreviewResumeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/17.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>
#import "WXApiObject.h"


@interface PreviewResumeViewController :BaseViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate>
{
    enum WXScene _scene;
}

- (void) changeScene:(NSInteger)scene;
- (void) sendLinkContent;

@property(nonatomic,strong)UIWebView *previewResumeWebView;

@property(nonatomic,strong)NSString *resumePreviewUrl;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,strong) UIView *shareView;


@end
