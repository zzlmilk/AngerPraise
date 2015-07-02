//
//  RegisterViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "RegisterViewController.h"
#import "InitPassword.h"
#import "ApIClient.h"
#import "LoginViewController.h"
#import "NewPasswordViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.frame = CGRectMake(20, _phoneNumberTextField.frame.size.height+_phoneNumberTextField.frame.origin.y, _phoneNumberTextField.frame.size.width, 20);
    tipLabel.hidden = YES;
    tipLabel.text = @"通过手机号码可以帮助你找到你的51job简历";
    tipLabel.textColor = RGBACOLOR(150, 150, 150, 1.0f);
    tipLabel.font =[UIFont fontWithName:@"Helvetica" size:11];
    [self.view addSubview:tipLabel];
    
    _getStarPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(60,tipLabel.frame.origin.y+tipLabel.frame.size.height+40,WIDTH-2*60,40)];
    [_getStarPasswordButton.layer setMasksToBounds:YES];
    [_getStarPasswordButton.layer setCornerRadius:40/2.f]; //设置矩形四个圆角半径
    [_getStarPasswordButton.layer setBorderWidth:1.0]; //边框宽度
    _getStarPasswordButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [_getStarPasswordButton setTitle:@"获 取 初 始 密 码" forState:UIControlStateNormal];
    [_getStarPasswordButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    _getStarPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_getStarPasswordButton addTarget:self action:@selector(getInitPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getStarPasswordButton];
    
    
    _captchaTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _getStarPasswordButton.frame.size.height+_getStarPasswordButton.frame.origin.y+40, _phoneNumberTextField.frame.size.width, 40)];
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
    
    
    _passwordPlaceholderLabel = [[UILabel alloc]init];
    _passwordPlaceholderLabel.frame = _captchaTextField.frame;
    _passwordPlaceholderLabel.text = @"请 输 入 初 始 密 码";
    _passwordPlaceholderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _passwordPlaceholderLabel.textColor = [UIColor grayColor];
    _passwordPlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_passwordPlaceholderLabel];
    
    
    _userRegisterButton= [[UIButton alloc]initWithFrame:CGRectMake(30,_captchaTextField.frame.origin.y+_captchaTextField.frame.size.height+80,WIDTH-2*30,45)];
    [_userRegisterButton.layer setMasksToBounds:YES];
    [_userRegisterButton.layer setCornerRadius:45/2.f]; //设置矩形四个圆角半径
    //[_userRegisterButton.layer setBorderWidth:1.0]; //边框宽度
//    _userRegisterButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [_userRegisterButton setTitle:@"提  交" forState:UIControlStateNormal];
    [_userRegisterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _userRegisterButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [_userRegisterButton setTitleColor:btnNormalColor forState:UIControlStateNormal];
    [_userRegisterButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    
    [_userRegisterButton setEnabled:NO];
    _userRegisterButton.backgroundColor = RGBACOLOR(255, 255, 255, 0.6f);
    [_userRegisterButton addTarget:self action:@selector(isInitPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userRegisterButton];
 
    
}


#pragma mark -- 键盘隐藏事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_phoneNumberTextField resignFirstResponder];
    [_captchaTextField resignFirstResponder];
    
    if ([_phoneNumberTextField.text isEqual: @""]) {
        
        _phonePlaceholderLabel.text = @"手 机 号 码";
        
    }
    if ([_captchaTextField.text isEqual: @""]){
        
        _passwordPlaceholderLabel.text = @"请 输 入 初 始 密 码";
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
        
        _passwordPlaceholderLabel.text = @"";
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self isInitPassword];
    return YES;
    
}

//获取初始密码
-(void)getInitPassword{
    
    NSUInteger pLength = 11;
    
    if (_phoneNumberTextField.text.length != pLength) {
        
        [APIClient showMessage:@"亲，我们认不出您的手机号码哟！"];
        
        
    }else{
        
//        _passwordPlaceholderLabel.hidden = NO;
//        _captchaTextField.hidden = NO;

        [_userRegisterButton setEnabled:YES];
        _userRegisterButton.backgroundColor = [UIColor whiteColor];
        
        [self reGetInitPassword];
        
        __block int timeout=60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    _getStarPasswordButton.userInteractionEnabled = YES;
                    [_getStarPasswordButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
                    [_getStarPasswordButton setTitle:@"重 新 获 取" forState:UIControlStateNormal];
                    [_getStarPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    _getStarPasswordButton.layer.borderColor = [[UIColor whiteColor] CGColor];
                    
                });
            }else{
                //            int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [_getStarPasswordButton setTitle:[NSString stringWithFormat:@"%@ 秒",strTime] forState:UIControlStateNormal];
                    
                    _getStarPasswordButton.userInteractionEnabled = NO;
                    [_getStarPasswordButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    _getStarPasswordButton.layer.borderColor = [[UIColor grayColor] CGColor];

                    
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
        
    }
    
}

//获取初始密码
-(void)reGetInitPassword{

     NSUInteger pLength = 11;
    
    if (_phoneNumberTextField.text.length != pLength) {
        
        [APIClient showMessage:@"手机号码格式不正确"];
    }else{
    
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
        
        [InitPassword getInitPassword:dic WithBlock:^(InitPassword *initPassword, Error *e) {
            
            //NSLog(@"%@",initPassword);
            
            if (e.info !=nil) {
                
                [APIClient showMessage:e.info];
            }else{
                
                [APIClient showMessage:@"怒赞码已发射成功～"];
                NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
                [token setObject:initPassword.token forKey:@"token"];
                
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [loginVC sendDeviceInfo];
            
            }
            
        }];

        
    }
}




//验证初始密码
-(void)isInitPassword{
    
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
            [dic setObject:_captchaTextField.text forKey:@"password"];
        
            [InitPassword isInitPassword:dic WithBlock:^(InitPassword *initPassword, Error *e) {
        
                if (e.info !=nil) {
                    
                    [APIClient showMessage:e.info title:@"提示"];
                    
                }
                if ([initPassword.validation_inital isEqualToString:@"1"] ) {
        
                    //跳转页面
                    //[APIClient showSuccess:@"等待页面跳转" title:@"验证成功"];
        
                    NewPasswordViewController *newPasswordVC =[[NewPasswordViewController alloc]init];
                    newPasswordVC.phoneNumberString = _phoneNumberTextField.text;
                    [self.navigationController pushViewController:newPasswordVC animated:YES];
                    
                }
            }];

    
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
