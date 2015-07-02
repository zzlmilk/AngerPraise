//
//  LoginViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "LoginViewController.h"
#import "ApIClient.h"
#import "SMS_MBProgressHUD.h"
#import "User.h"
#import "MainViewController.h"
#import "NoozanAppdelegate.h"
#import "HomeViewController.h"

@interface LoginViewController ()

@end



@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"0index_bg"]];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-162/2)/2, 50, 162/2, 207/2)];
    [logoImageView setImage:[UIImage imageNamed:@"0index_logo"]];
    [self.view addSubview:logoImageView];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, logoImageView.frame.size.height+logoImageView.frame.origin.y+80, WIDTH-2*20, 40)];
    [_phoneNumberTextField setBorderStyle:UITextBorderStyleNone];
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.tag = 101;
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

    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _phoneNumberTextField.frame.origin.y+_phoneNumberTextField.frame.size.height+30, WIDTH-2*20, 40)];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    _passwordTextField.returnKeyType = UIReturnKeyDone;//    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.tag = 102;
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.delegate =self;
    _passwordTextField.textColor = [UIColor whiteColor];
    //    _phoneNumberTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    //    _phoneNumberTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:_passwordTextField];
    
    UILabel *lineLabel2 = [[UILabel alloc]init];
    lineLabel2.frame =CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.size.height+_passwordTextField.frame.origin.y, _passwordTextField.frame.size.width, 0.3);
    lineLabel2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabel2];
    
    _passwordPlaceholderLabel = [[UILabel alloc]init];
    _passwordPlaceholderLabel.frame = _passwordTextField.frame;
    _passwordPlaceholderLabel.text = @"密 码";
    _passwordPlaceholderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _passwordPlaceholderLabel.textColor = [UIColor grayColor];
    _passwordPlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_passwordPlaceholderLabel];
    
    UIButton *userLoginButton= [[UIButton alloc]initWithFrame:CGRectMake(30,_passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+50,WIDTH-2*30,45)];
    [userLoginButton.layer setMasksToBounds:YES];
    [userLoginButton.layer setCornerRadius:45/2.f]; //设置矩形四个圆角半径
    //[_userRegisterButton.layer setBorderWidth:1.0]; //边框宽度
    //    _userRegisterButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [userLoginButton setTitle:@"登    入" forState:UIControlStateNormal];
    [userLoginButton setTitleColor:btnNormalColor forState:UIControlStateNormal];
    [userLoginButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    userLoginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    userLoginButton.backgroundColor = [UIColor whiteColor];
    [userLoginButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userLoginButton];    

}



#pragma mark -- 键盘return 事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self userLogin];
    
    [_passwordTextField resignFirstResponder];
    
    return YES;
    
}


#pragma mark -- 返回
-(void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 隐藏键盘事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_phoneNumberTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    if ([_phoneNumberTextField.text isEqual: @""]) {
        
        _phonePlaceholderLabel.text = @"手 机 号 码";
    }
    if ([_passwordTextField.text isEqual: @""]){
    
        _passwordPlaceholderLabel.text = @"密 码";
    }
    
}

#pragma mark -- 用户登录 TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag ==101) {
        
        _phonePlaceholderLabel.text = @"";
    }else if(textField.tag ==102){
        
        _passwordPlaceholderLabel.text = @"";
        
    }
    
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 0 );
}


-(void)loadUserLoginData:(NSMutableDictionary *)dicData{
    
    //home 中需要调用登录获取相关信息
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [User userLogin:dicData WithBlock:^(User *user, Error *e) {
        
    [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        if (e.info !=nil) {
            [APIClient showInfo:e.info title:@"提示"];
        }
        else {
    
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:user.user_token forKey:USER_TOKEN];
            [userDefaults setObject:user.user_id forKey:USER_ID];
            [userDefaults setObject:user.hr_privilege forKey:@"user_type"];
        
            //注册成功发送设备
            [self sendDeviceInfo];
            
            MainViewController *mainVC = [[MainViewController alloc]init];
            [self.navigationController pushViewController:mainVC animated:YES];
            //[[NoozanAppdelegate getAppDelegate] getMainVC];
            
        }
    }];
    

}

#pragma mark -- 用户登录
-(void)userLogin{
    
     NSUInteger pLength = 11;
    if (_phoneNumberTextField.text.length !=pLength) {
        [APIClient showMessage:@"手机号码格式不正确"];
    }else if (_passwordTextField.text == nil){
        [APIClient showMessage:@"密码不能为空"];
    }else{
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
        [dic setObject:_passwordTextField.text forKey:@"password"];
        [self loadUserLoginData:dic];
        }
}

#pragma mark -- 发送 token 和 deviceToken 及设备信息
-(void)sendDeviceInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *deviceTokenString = [userDefaults objectForKey:USER_DEVIECTOKEN];
    
        NSString* deviceName = [[UIDevice currentDevice] systemName];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[userDefaults objectForKey:USER_TOKEN]
                forKey:@"token"];
        [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

        [dic setObject:@"1" forKey:@"dict_device_id"];
        [dic setObject:deviceName forKey:@"device_name"];
        
        if (deviceTokenString!=nil) {
            
            [dic setObject:deviceTokenString forKey:@"device_id"];
            
        }else{
        
            [dic setObject:@"0" forKey:@"device_id"];

        }
        
        [User sendDeviceInfo:dic WithBlock:^(User *user, Error *e) {
            
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
