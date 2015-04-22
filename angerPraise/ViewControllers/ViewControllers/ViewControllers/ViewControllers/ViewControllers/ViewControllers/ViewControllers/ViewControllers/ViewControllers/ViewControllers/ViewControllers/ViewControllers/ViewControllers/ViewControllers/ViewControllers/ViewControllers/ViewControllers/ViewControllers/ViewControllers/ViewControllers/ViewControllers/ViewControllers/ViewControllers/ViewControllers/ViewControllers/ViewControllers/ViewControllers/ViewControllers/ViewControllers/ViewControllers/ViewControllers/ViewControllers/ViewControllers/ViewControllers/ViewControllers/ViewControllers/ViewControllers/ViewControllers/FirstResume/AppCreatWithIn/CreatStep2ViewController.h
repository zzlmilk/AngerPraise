//
//  CreatStep2ViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CreatStep2ViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *educationTextField;//学历
@property(nonatomic,strong) UITextField *positionTextField;//职位


@property(nonatomic,strong) NSString *userNameString;
@end
