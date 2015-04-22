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

@property(nonatomic,strong) UITextField *recentCompanyTextField;//最近工作的公司名称
@property(nonatomic,strong) UITextField *payRangeTextField;//薪资范围


@end
