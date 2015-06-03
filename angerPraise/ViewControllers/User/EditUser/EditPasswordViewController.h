//
//  EditPasswordViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/2.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EditPasswordViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITextField *oldPasswordTextField;
@property(nonatomic,strong)UITextField *editNewPasswordTextField;
@property(nonatomic,strong)UITextField *reEditNewPasswordTextField;

@property(nonatomic,strong) UIScrollView *scrollView;


@end
