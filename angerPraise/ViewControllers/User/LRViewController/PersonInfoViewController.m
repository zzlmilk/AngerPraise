//
//  PersonInfoViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "Register.h"
#import "ApIClient.h"
#import "MainViewController.h"
#import "ImportResumeViewController.h"


@interface PersonInfoViewController ()


@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    UILabel *nameTipLabel = [[UILabel alloc]init];
    nameTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+50, self.view.frame.size.width-2*35, 35);
    nameTipLabel.text = @"真实姓名";
    nameTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    nameTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:nameTipLabel];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTipLabel.frame.origin.x, nameTipLabel.frame.size.height+nameTipLabel.frame.origin.y,nameTipLabel.frame.size.width, 40)];
    [_userNameTextField setBorderStyle:UITextBorderStyleLine];
    _userNameTextField.placeholder = @" ";
    _userNameTextField.delegate = self;
    _userNameTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _userNameTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _userNameTextField.textAlignment = NSTextAlignmentCenter;
    _userNameTextField.layer.borderWidth = 1.0f;
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _userNameTextField.leftView = nameView;
    _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_userNameTextField];
    
    
    UILabel *sexTipLabel = [[UILabel alloc]init];
    sexTipLabel.frame = CGRectMake(_userNameTextField.frame.origin.x,_userNameTextField.frame.size.height+_userNameTextField.frame.origin.y +20, _userNameTextField.frame.size.width, 35);
    sexTipLabel.text = @"性别";
    sexTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    sexTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:sexTipLabel];
    
    _sexTextField = [[UITextField alloc]initWithFrame:CGRectMake(sexTipLabel.frame.origin.x, sexTipLabel.frame.size.height+sexTipLabel.frame.origin.y, sexTipLabel.frame.size.width, 40)];
    _sexTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _sexTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _sexTextField.layer.borderWidth = 1.0f;
    [_sexTextField setBorderStyle:UITextBorderStyleLine];
    _sexTextField.placeholder = @"--请选择--";
    _sexTextField.delegate = self;
    _sexTextField.tag = 105;
    _sexTextField.textAlignment = NSTextAlignmentCenter;
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _sexTextField.leftView = sexView;
    _sexTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_sexTextField];

    
    UILabel *birthdayTipLabel = [[UILabel alloc]init];
    birthdayTipLabel.frame = CGRectMake(_sexTextField.frame.origin.x,_sexTextField.frame.size.height+_sexTextField.frame.origin.y+20, _sexTextField.frame.size.width, 35);
    birthdayTipLabel.text = @"生日";
    birthdayTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    birthdayTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:birthdayTipLabel];
    
    _birthdayTextField = [[UITextField alloc]initWithFrame:CGRectMake(birthdayTipLabel.frame.origin.x, birthdayTipLabel.frame.size.height+birthdayTipLabel.frame.origin.y, birthdayTipLabel.frame.size.width, 40)];
    _birthdayTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _birthdayTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _birthdayTextField.delegate = self;
    _birthdayTextField.tag = 106;
    _birthdayTextField.layer.borderWidth = 1.0f;
    [_birthdayTextField setBorderStyle:UITextBorderStyleLine];
    _birthdayTextField.placeholder = @"--请选择--";
    UIView *birthdayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _birthdayTextField.textAlignment = NSTextAlignmentCenter;
    _birthdayTextField.leftView = birthdayView;
    _birthdayTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_birthdayTextField];
    
    
    UIButton *submitButton = [[UIButton alloc]init];
    submitButton.frame = CGRectMake(90, _birthdayTextField.frame.size.height+_birthdayTextField.frame.origin.y+80, WIDTH - 2*90, 40);
    [submitButton setTitle:@"提  交" forState:UIControlStateNormal];
    [submitButton.layer setMasksToBounds:YES];
    [submitButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [submitButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    submitButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    submitButton.layer.borderWidth = 1.0f;
    [submitButton addTarget:self action:@selector(submitRegister) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:submitButton];

    
    //日期选择器
    NSDate *currentTime  = [NSDate date];
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 200)];
    _datePicker.backgroundColor = RGBACOLOR(250, 250, 250, 1.0f);
    // [datePicker   setTimeZone:[NSTimeZone defaultTimeZone]];
    // [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    // 设置当前显示
    _datePicker.hidden = YES;
    [_datePicker setDate:currentTime animated:YES];
    // 设置显示最大时间（
    [_datePicker setMaximumDate:currentTime];
    // 显示模式
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    // 回调的方法由于UIDatePicker 是UIControl的子类 ,可以在UIControl类的通知结构中挂接一个委托
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    
    
    //性别选择
    _sexArray = [NSArray arrayWithObjects:@"男",@"女",@"保密", nil];
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.backgroundColor =  RGBACOLOR(250, 250, 250, 1.0f);
    _pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定                                                                                                                           义高度了，一般默认是无法修改其216像素的高度
    _pickerView.dataSource = self;   //这个不用说了瑟
    _pickerView.delegate = self;       //这个不用说了瑟
    _pickerView.frame = CGRectMake(0, HEIGHT-160, WIDTH, 160);
    _pickerView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
    _pickerView.hidden = YES;
    
    [self.view addSubview:_pickerView];
}

#pragma mark -

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;     //这个picker里的组键数
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _sexArray.count;  //数组个数
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return WIDTH;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40.0;
    
}

#pragma mark -

#pragma mark UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
        UILabel *myView = nil;
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
        
        myView.text = [_sexArray objectAtIndex:row];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
    
    _sexTextField.text = myView.text;
    
    
    return myView;
    
}


#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField.tag ==106) {
        
        [_birthdayTextField resignFirstResponder];
        _datePicker.hidden = NO;
        
    }
    if(textField.tag ==105){
        
        [_sexTextField resignFirstResponder];
        _pickerView.hidden = NO;
        
    }
    
}

-(void)datePickerValueChanged:(id)sender{

 //   NSDate *selected = [_datePicker date];
    //NSLog(@"date: %@", selected);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _birthdayTextField.text = [dateFormatter stringFromDate:[_datePicker date]];
}


#pragma mark -- 注册 信息验证
-(void)submitRegister{
    
    if ([_userNameTextField.text isEqualToString:@""]) {
        
        [APIClient showTextMeggage:@"姓名不能为空" view: self.view];
        
    }
    if([_birthdayTextField.text isEqualToString:@""]){
        
        [APIClient showTextMeggage:@"请选择生日" view: self.view];

    }else{
    
        if([_sexTextField.text isEqualToString:@"男"]){
            
            _sexId = @"1";
            
        }
        if ([_sexTextField.text isEqualToString:@"女"]){
            
            _sexId = @"2";
            
        }
        if ([_sexTextField.text isEqualToString:@"保密"]){
            
            _sexId = @"3";
            
        }
        
        [self sendDateForServer];
        
    }
    
}

#pragma mark -- 注册 提交 调用接口   已废弃
-(void)sendDateForServer{

    //        NSString * uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:_phoneNumberString forKey:@"phone"];
    [dic setObject:_newsPasswordString forKey:@"password"];
    [dic setObject:_userNameTextField.text forKey:@"name"];
    [dic setObject:_sexId forKey:@"sex_id"];
    [dic setObject:_birthdayTextField.text forKey:@"birthday"];
    //        [dic setObject:@"ios" forKey:@"device"];
    //        [dic setObject:uuid forKey:@"device_id"];
    //        [dic setObject:@"e91eabc2c2f181f4a0c3715a4ec049df" forKey:@"client_id"];
    
//    [Register userRegister:dic WithBlock:^(Register *reg, Error *e) {
//        
//        if (e.info !=nil) {
//            
//            [APIClient showInfo:e.info title:@"提示"];
//            
//        }else if(![reg.user_id isEqual: @""]){
//            
//            NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
//            [userId setObject:reg.user_id forKey:@"userId"];
//            
//            [APIClient showSuccess:@"注册成功" title:@"成功"];
//            
//            ImportResumeViewController *importResumeVC = [[ImportResumeViewController alloc]init];
//            [self.navigationController pushViewController:importResumeVC animated:YES];
//            
//        }
//        
//    }];
    

}
#pragma mark -- 隐藏键盘事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_userNameTextField resignFirstResponder];
    [_sexTextField resignFirstResponder];
    [_birthdayTextField resignFirstResponder];
    _datePicker.hidden = YES;
    _pickerView.hidden = YES;
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
