//
//  RegisterViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property(nonatomic,strong) UITextField *phoneNumberTextField;
@property(nonatomic,strong) UITextField *captchaTextField;
@property(nonatomic,strong) UITextField *passwordTextField;


@end
