//
//  ForgetPasswordViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/26.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ApIClient.h"
#import "Register.h"
#import "SetNewPasswordViewController.h"
#import "SMS_MBProgressHUD.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"0index_bg"]];
    
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
    
    
    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 110, WIDTH-2*20, 40)];
    [_phoneNumberTextField setBorderStyle:UITextBorderStyleNone];
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.tag = 103;
    _phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    _phoneNumberTextField.delegate =self;
    [_phoneNumberTextField becomeFirstResponder];
    _phoneNumberTextField.textColor = [UIColor whiteColor];
    //    _phoneNumberTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    //    _phoneNumberTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:_phoneNumberTextField];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame =CGRectMake(_phoneNumberTextField.frame.origin.x, _phoneNumberTextField.frame.size.height+_phoneNumberTextField.frame.origin.y, _phoneNumberTextField.frame.size.width, 0.3);
    lineLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabel];
    
    _phonePlaceholderLabel = [[UILabel alloc]init];
    _phonePlaceholderLabel.frame = _phoneNumberTextField.frame;
    _phonePlaceholderLabel.text = @"手 机 号 码";
    _phonePlaceholderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _phonePlaceholderLabel.textColor = [UIColor grayColor];
    _phonePlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phonePlaceholderLabel];
    
    
    _getCaptchaButton = [[UIButton alloc]initWithFrame:CGRectMake(60,_phonePlaceholderLabel.frame.origin.y+_phonePlaceholderLabel.frame.size.height+40,WIDTH-2*60,40)];
    [_getCaptchaButton.layer setMasksToBounds:YES];
    [_getCaptchaButton.layer setCornerRadius:40/2.f]; //设置矩形四个圆角半径
    [_getCaptchaButton.layer setBorderWidth:1.0]; //边框宽度
    _getCaptchaButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_getCaptchaButton setTitle:@"获 取 验 证 码" forState:UIControlStateNormal];
    [_getCaptchaButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    _getCaptchaButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_getCaptchaButton addTarget:self action:@selector(getCaptcha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCaptchaButton];
    
    
    _captchaTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _getCaptchaButton.frame.size.height+_getCaptchaButton.frame.origin.y+40, _phoneNumberTextField.frame.size.width, 40)];
    _captchaTextField.keyboardType = UIKeyboardTypeDefault;
    _captchaTextField.returnKeyType = UIReturnKeyDone;
    [_captchaTextField setBorderStyle:UITextBorderStyleNone];
    _captchaTextField.tag = 104;
    _captchaTextField.textAlignment = NSTextAlignmentCenter;
    _captchaTextField.delegate =self;
    _captchaTextField.textColor = [UIColor whiteColor];
    //    _captchaTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    //    _captchaTextField.layer.borderWidth = 1.0f;
    _captchaTextField.secureTextEntry = YES;
    [self.view addSubview:_captchaTextField];
    
    UILabel *lineLabel2 = [[UILabel alloc]init];
    lineLabel2.frame =CGRectMake(_captchaTextField.frame.origin.x, _captchaTextField.frame.size.height+_captchaTextField.frame.origin.y, _captchaTextField.frame.size.width, 0.3);
    lineLabel2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabel2];
    
    
    _captchaPlaceholderLabel = [[UILabel alloc]init];
    _captchaPlaceholderLabel.frame = _captchaTextField.frame;
    _captchaPlaceholderLabel.text = @"请 输 入 验 证 码";
    _captchaPlaceholderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _captchaPlaceholderLabel.textColor = [UIColor grayColor];
    _captchaPlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_captchaPlaceholderLabel];
    
    
    _validationButton= [[UIButton alloc]initWithFrame:CGRectMake(30,_captchaTextField.frame.origin.y+_captchaTextField.frame.size.height+80,WIDTH-2*30,45)];
    [_validationButton.layer setMasksToBounds:YES];
    [_validationButton.layer setCornerRadius:45/2.f]; //设置矩形四个圆角半径
    //[_userRegisterButton.layer setBorderWidth:1.0]; //边框宽度
    //    _userRegisterButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [_validationButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [_validationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _validationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [_validationButton setTitleColor:btnNormalColor forState:UIControlStateNormal];
    [_validationButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    
    [_validationButton setEnabled:NO];
    _validationButton.backgroundColor = RGBACOLOR(255, 255, 255, 0.6f);
    [_validationButton addTarget:self action:@selector(captchaNextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validationButton];
    
}

#pragma mark -- 键盘隐藏事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_phoneNumberTextField resignFirstResponder];
    [_captchaTextField resignFirstResponder];
    
    if ([_phoneNumberTextField.text isEqual: @""]) {
        
        _phonePlaceholderLabel.text = @"手 机 号 码";
        
    }
    if ([_captchaTextField.text isEqual: @""]){
        
        _captchaPlaceholderLabel.text = @"请 输 入 验 证 码";
    }
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 用户登录 TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag ==103) {
        
        _phonePlaceholderLabel.text = @"";
        
    }
    if(textField.tag ==104){
        
        _captchaPlaceholderLabel.text = @"";
        
        [_validationButton setEnabled:YES];
        _validationButton.backgroundColor = [UIColor whiteColor];
        
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self captchaNextStep];
    return YES;
    
}

#pragma mark -- 获取初始密码
-(void)getCaptcha{
    
    NSUInteger pLength = 11;
    
    if (_phoneNumberTextField.text.length != pLength) {
        
        [APIClient showMessage:@"亲，我们认不出您的手机号码哟~"];
        
        
    }else{
        
        [self sendCaptcha];
        
        __block int timeout=60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    _getCaptchaButton.userInteractionEnabled = YES;
                    [_getCaptchaButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
                    [_getCaptchaButton setTitle:@"重 新 获 取" forState:UIControlStateNormal];
                    [_getCaptchaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    _getCaptchaButton.layer.borderColor = [[UIColor whiteColor] CGColor];
                    
                });
            }else{
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [_getCaptchaButton setTitle:[NSString stringWithFormat:@"%@ 秒",strTime] forState:UIControlStateNormal];
                    
                    _getCaptchaButton.userInteractionEnabled = NO;
                    [_getCaptchaButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    _getCaptchaButton.layer.borderColor = [[UIColor grayColor] CGColor];
                    
                    
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
        
    }
    
}

-(void)sendCaptcha{

    if (_phoneNumberTextField.text.length) {
     
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
        
        [Register getCaptcha:dic WithBlock:^(Register *reg, Error *e) {

            if (e.info) {
                
                [APIClient showMessage:e.info];
            }
            
            NSString *resString = [NSString stringWithFormat:@"%@",reg.res];
            
            if ([resString isEqualToString:@"1"]) {
                
                [APIClient showMessage:@"验证码已发送，请注意查收~"];

            }
        }];
        
    }
    
}

#pragma mark -- 验证初始密码
-(void)captchaNextStep{
    
    
    if (_captchaTextField.text.length) {
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
        [dic setObject:_captchaTextField.text forKey:@"password"];
        
        [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Register checkPhone:dic WithBlock:^(Register *reg, Error *e) {
            [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];

            if (e.info) {
                
                [APIClient showMessage:e.info];
                
            }
            
            NSString *resString = [NSString stringWithFormat:@"%@",reg.res];

            if ([resString isEqualToString:@"1"]) {
             
                SetNewPasswordViewController *setNewPassword = [[SetNewPasswordViewController alloc]init];
                setNewPassword.phoneNumberString = _phoneNumberTextField.text;
                [self.navigationController pushViewController:setNewPassword animated:YES];
                
            }
            
        }];
        
        
        
    }else{
    
        [APIClient showMessage:@"验证码不能为空哟~"];
    }
    
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
