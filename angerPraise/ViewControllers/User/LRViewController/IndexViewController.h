//
//  IndexViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface IndexViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *phoneNumberTextField;
@property(nonatomic,strong) UITextField *passwordTextField;

@end
