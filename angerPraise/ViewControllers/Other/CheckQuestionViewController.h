//
//  CheckQuestionViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/3/12.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckQuestionViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField *companyNameTextField;
@property(nonatomic ,strong)UITextField *schoolNameTextField;

@end