//
//  ForgetPasswordViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/26.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface ForgetPasswordViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *phoneNumberTextField;
@property(nonatomic,strong) UITextField *captchaTextField;

@property(nonatomic,strong) UIButton *getCaptchaButton;


@property(nonatomic,strong) UILabel *captchaPlaceholderLabel;
@property(nonatomic,strong) UILabel *phonePlaceholderLabel;

@property(nonatomic,strong) UIButton *validationButton;

@property __block int timeout;
@end
