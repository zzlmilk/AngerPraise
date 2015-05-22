//
//  PersonInfoViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PersonInfoViewController : BaseViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UITextField *userNameTextField;
@property(nonatomic,strong) UITextField *sexTextField;
@property(nonatomic,strong) UITextField *birthdayTextField;


@property NSString *phoneNumberString;
@property NSString *newsPasswordString;
@property NSArray *sexArray;

@property NSString *sexId;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)UIPickerView *pickerView;

@end
