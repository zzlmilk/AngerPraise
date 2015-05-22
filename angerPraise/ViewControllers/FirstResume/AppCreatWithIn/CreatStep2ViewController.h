//
//  CreatStep2ViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CreatStep2ViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UITextField *educationTextField;//学历
@property(nonatomic,strong) UITextField *positionTextField;//职位

@property(nonatomic,strong) UITextField *payRangeTextField;//薪资范围

@property(nonatomic,strong)NSArray *payRangeArray;

@property(nonatomic,strong) NSString *userNameString;

@property(nonatomic,strong)NSArray *educationArray;
@property(nonatomic,strong)NSArray *experienceArray;

@end
