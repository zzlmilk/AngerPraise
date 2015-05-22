//
//  CreatStep3ViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CreatStep3ViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *companyNameTextField;//最近工作的公司名称

@property(nonatomic,strong) UITextField *workTimeTextField;
@property(nonatomic,strong) UITextField *workPalceTextField;


@property(nonatomic,strong)NSArray *workTimeArray;
@property(nonatomic,strong)NSArray *workPlaceArray;

@property(nonatomic,strong)NSString *positionNameString;
@property(nonatomic,strong)NSString *educationString;



@end
