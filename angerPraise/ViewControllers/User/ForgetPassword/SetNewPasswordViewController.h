//
//  SetNewPasswordViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/26.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface SetNewPasswordViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *newsPasswordTextField;
@property(nonatomic,strong) UITextField *reNewsPasswordTextField;

@property NSString *phoneNumberString;

@end
