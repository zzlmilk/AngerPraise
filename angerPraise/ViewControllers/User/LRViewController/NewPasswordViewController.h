//
//  NewPasswordViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NewPasswordViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) UITextField *newsPasswordTextField;
@property(nonatomic,strong) UITextField *reNewsPasswordTextField;
@property(nonatomic,strong) UITextField *userNameTextField;

@property NSString *phoneNumberString;

@end
