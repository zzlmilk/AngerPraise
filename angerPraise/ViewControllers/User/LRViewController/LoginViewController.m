//
//  LoginViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ImportResumeViewController.h"
#import "NeedDataViewController.h"
#import "ShareViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.navigationController setNavigationBarHidden:YES];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIImageView *inputBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-2*30, 100)];
    [inputBgImageView setImage:[UIImage imageNamed:@"inputbox"]];
    [self.view addSubview:inputBgImageView];
    
    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(inputBgImageView.frame.origin.x+10, inputBgImageView.frame.origin.y, inputBgImageView.frame.size.width-10, inputBgImageView.frame.size.height/2)];
    _phoneNumberTextField.placeholder = @"手机号";
    //[_emailOrPhoneTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_phoneNumberTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(_phoneNumberTextField.frame.origin.x, _phoneNumberTextField.frame.origin.y+_phoneNumberTextField.frame.size.height, _phoneNumberTextField.frame.size.width, _phoneNumberTextField.frame.size.height)];
    _passwordTextField.placeholder = @"  密 码";
    //[_passwordTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_passwordTextField];

    
    
    
    UIButton *LoginButton = [[UIButton alloc]initWithFrame:CGRectMake(inputBgImageView.frame.origin.x, inputBgImageView.frame.origin.y + inputBgImageView.frame.size.height +30, inputBgImageView.frame.size.width, 45)];
    [LoginButton.layer setMasksToBounds:YES];
    [LoginButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [LoginButton.layer setBorderWidth:1.0]; //边框宽度
    [LoginButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [LoginButton.layer setBorderColor:colorref];//边框颜色
    [LoginButton setTitle:@"登录" forState:UIControlStateNormal];
    LoginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    LoginButton.backgroundColor = RGBACOLOR(94, 123, 167, 1.0f);
    [self.view addSubview:LoginButton];
    

}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 用户登录
-(void)userLogin{


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
