//
//  RegisterViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"手机注册";

    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, 200, 50)];
    [_phoneNumberTextField setBorderStyle:UITextBorderStyleLine];
    _phoneNumberTextField.background = [UIImage imageNamed:@"baiKuang"];
    _phoneNumberTextField.placeholder = @" 手机号";
    [self.view addSubview:_phoneNumberTextField];
    
    UIButton *getCaptchaButton = [[UIButton alloc]initWithFrame:CGRectMake(_phoneNumberTextField.frame.size.width+_phoneNumberTextField.frame.origin.x+5,_phoneNumberTextField.frame.origin.y,self.view.frame.size.width-_phoneNumberTextField.frame.size.width-2*20,50)];
    [getCaptchaButton.layer setMasksToBounds:YES];
    [getCaptchaButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [getCaptchaButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace1,(CGFloat[]){ 211, 58, 59, 1 });
    [getCaptchaButton.layer setBorderColor:colorref2];//边框颜色
    [getCaptchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCaptchaButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    getCaptchaButton.backgroundColor = RGBACOLOR(94, 123, 167, 1.0f);;
    [self.view addSubview:getCaptchaButton];
    
    
    _captchaTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _phoneNumberTextField.frame.size.height+_phoneNumberTextField.frame.origin.y+20, 150, 50)];
    [_captchaTextField setBorderStyle:UITextBorderStyleLine];
    _captchaTextField.background = [UIImage imageNamed:@"baiKuang"];
    _captchaTextField.placeholder = @" 验证码";
    [self.view addSubview:_captchaTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _captchaTextField.frame.size.height+_captchaTextField.frame.origin.y+20, self.view.frame.size.width-2*20, 50)];
    [_passwordTextField setBorderStyle:UITextBorderStyleLine];
    _passwordTextField.background = [UIImage imageNamed:@"baiKuang"];
    _passwordTextField.placeholder = @" 密码";
    [self.view addSubview:_passwordTextField];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _passwordTextField.frame.size.height+_passwordTextField.frame.origin.y+5, _passwordTextField.frame.size.width, 30)];
    passwordLabel.text = @"需要包含字母数字, 至少8个字符, 区分大小写";
    passwordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    passwordLabel.textColor = RGBACOLOR(189, 190, 184, 1.0f);
    [self.view addSubview:passwordLabel];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _captchaTextField.frame.size.height+passwordLabel.frame.origin.y-5, self.view.frame.size.width-2*20, 50)];
    [_userNameTextField setBorderStyle:UITextBorderStyleLine];
    _userNameTextField.background = [UIImage imageNamed:@"baiKuang"];
    _userNameTextField.placeholder = @" 用户名";
    [self.view addSubview:_userNameTextField];
    
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _userNameTextField.frame.size.height+_userNameTextField.frame.origin.y+5, _userNameTextField.frame.size.width, 30)];
    userNameLabel.text = @"不多于14个英文字母或7个汉字";
    userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    userNameLabel.textColor = RGBACOLOR(189, 190, 184, 1.0f);
    [self.view addSubview:userNameLabel];
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(20, userNameLabel.frame.size.height+userNameLabel.frame.origin.y+30, self.view.frame.size.width - 2*20, 45)];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [registerButton.layer setBorderColor:colorref];//边框颜色
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    registerButton.backgroundColor = RGBACOLOR(94, 123, 167, 1.0f);
    [self.view addSubview:registerButton];
    
    
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
