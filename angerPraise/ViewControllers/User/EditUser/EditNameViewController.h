//
//  EditNameViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/2.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EditViewController.h"
#import "UserViewController.h"

@interface EditNameViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *editNameTextField;
@property(nonatomic,strong)NSString *editNameString;

@property(nonatomic,strong)EditViewController *editVC;
@property(nonatomic,strong)UserViewController *userVC;


@end
