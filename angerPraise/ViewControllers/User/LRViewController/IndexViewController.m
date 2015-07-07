//
//  IndexViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/22.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "IndexViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "NewPasswordViewController.h"
#import "ForgetPasswordViewController.h"

//#import "TKRoundedView.h"

@interface IndexViewController ()

@end

@implementation IndexViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
   
    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 44, 44);
//    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
//    backBtn.hidden =YES;
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"0index_bg"]];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-162/2)/2, 70, 162/2, 207/2)];
    [logoImageView setImage:[UIImage imageNamed:@"0index_logo"]];
    [self.view addSubview:logoImageView];
    
    
//    UILabel *iconLabel = [[UILabel alloc]init];
//    iconLabel.frame =CGRectMake(0, logoImageView.frame.size.height+logoImageView.frame.origin.y, WIDTH, 30);
//    iconLabel.text = @"怒     赞";
//    iconLabel.textAlignment = NSTextAlignmentCenter;
//    iconLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
//    iconLabel.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:iconLabel];
    
    
   UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(30,logoImageView.frame.origin.y+logoImageView.frame.size.height+120,WIDTH-2*30,45)];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:45/2.f]; //设置矩形四个圆角半径
//    [loginButton.layer setBorderWidth:1.0]; //边框宽度
//    loginButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [loginButton setTitle:@"登    入" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateNormal];
    [loginButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateHighlighted];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(30,loginButton.frame.origin.y+loginButton.frame.size.height+50,WIDTH-2*30,45)];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:45/2.f]; //设置矩形四个圆角半径
//    [registerButton.layer setBorderWidth:1.0]; //边框宽度
//    registerButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [registerButton setTitle:@"创 建 账 户" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [registerButton setTitleColor:btnNormalColor forState:UIControlStateNormal];
    [registerButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    registerButton.backgroundColor = [UIColor whiteColor];
    [registerButton addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    
    UIButton *forgetPasswordButton = [[UIButton alloc]init];
    forgetPasswordButton.frame = CGRectMake(20, registerButton.frame.origin.y+registerButton.frame.size.height+20,WIDTH-2*20-20,30);
    forgetPasswordButton.backgroundColor = [UIColor clearColor];
    [forgetPasswordButton setTitle:@"忘 记 密 码 ？" forState:UIControlStateNormal];
    forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgetPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    [forgetPasswordButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [forgetPasswordButton setTitleColor:RGBACOLOR(200, 200, 200, 1.0f) forState:UIControlStateHighlighted];
    [self.view addSubview:forgetPasswordButton];
    
    
}

#pragma mark -- 去登录
-(void)goLogin{
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}


#pragma mark -- 去注册
-(void)goRegister{
    
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark -- 忘记密码
-(void)forgetPassword{
    
    ForgetPasswordViewController *forgetPasswordVC = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
    
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