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
#import "MarkViewController.h"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    
//    [self.navigationController setNavigationBarHidden:YES];
    self.title = @"登录";
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-2*30, 50)];
    //describeLabel.backgroundColor = [UIColor yellowColor];
    describeLabel.text = @"登录HireLib, 享受个性化推荐!";
    describeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    describeLabel.textColor = RGBACOLOR(211, 96, 84, 1.0f);
    [self.view addSubview:describeLabel];
    
    UIImageView *inputBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, describeLabel.frame.size.height+describeLabel.frame.origin.y+20, self.view.frame.size.width-2*30, 100)];
    [inputBgImageView setImage:[UIImage imageNamed:@"inputbox"]];
    [self.view addSubview:inputBgImageView];
    
    _emailOrPhoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(inputBgImageView.frame.origin.x+10, inputBgImageView.frame.origin.y, inputBgImageView.frame.size.width-10, inputBgImageView.frame.size.height/2)];
    _emailOrPhoneTextField.placeholder = @"  邮箱 / 手机号";
    //[_emailOrPhoneTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_emailOrPhoneTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(_emailOrPhoneTextField.frame.origin.x, _emailOrPhoneTextField.frame.origin.y+_emailOrPhoneTextField.frame.size.height, _emailOrPhoneTextField.frame.size.width, _emailOrPhoneTextField.frame.size.height)];
    _passwordTextField.placeholder = @"  密 码";
    //[_passwordTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_passwordTextField];
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(inputBgImageView.frame.origin.x, inputBgImageView.frame.origin.y + inputBgImageView.frame.size.height +30, inputBgImageView.frame.size.width, 45)];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [loginButton.layer setBorderWidth:1.0]; //边框宽度
    [loginButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [loginButton.layer setBorderColor:colorref];//边框颜色
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    loginButton.backgroundColor = RGBACOLOR(235, 75, 66, 1.0f);
    [self.view addSubview:loginButton];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(loginButton.frame.origin.x-15, loginButton.frame.origin.y+loginButton.frame.size.height+40, self.view.frame.size.width - 2*loginButton.frame.origin.x+30, 1)];
    lineLabel.backgroundColor = RGBACOLOR(206, 207, 202, 1.0f);
    [self.view addSubview:lineLabel];
    
    UIButton *weiboLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(40, lineLabel.frame.origin.y+lineLabel.frame.size.height, 80, 80)];
    weiboLoginButton.backgroundColor = [UIColor clearColor];
    [weiboLoginButton setImage:[UIImage imageNamed:@"ic_recommend_weibo"] forState:UIControlStateNormal];
    [self.view addSubview:weiboLoginButton];
    
    UILabel *weiboLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(weiboLoginButton.frame.origin.x, weiboLoginButton.frame.origin.y+weiboLoginButton.frame.size.height-15, weiboLoginButton.frame.size.width, 30)];
    weiboLoginLabel.backgroundColor =[ UIColor clearColor];
    weiboLoginLabel.text = @"微博登录";
    weiboLoginLabel.textAlignment = NSTextAlignmentCenter;
    weiboLoginLabel.textColor = RGBACOLOR(163, 163, 158, 1.0f);
    weiboLoginLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [self.view addSubview:weiboLoginLabel];
    
    
    UIButton *weixinLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(weiboLoginButton.frame.origin.x+160, lineLabel.frame.origin.y+lineLabel.frame.size.height, 80, 80)];
    weixinLoginButton.backgroundColor = [UIColor clearColor];
    [weixinLoginButton setImage:[UIImage imageNamed:@"ic_recommend_weixin"] forState:UIControlStateNormal];
    [self.view addSubview:weixinLoginButton];
    
    UILabel *weixinLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(weixinLoginButton.frame.origin.x, weixinLoginButton.frame.origin.y+weixinLoginButton.frame.size.height-15, weixinLoginButton.frame.size.width, 30)];
    weixinLoginLabel.backgroundColor =[ UIColor clearColor];
    weixinLoginLabel.text = @"微信登录";
    weixinLoginLabel.textAlignment = NSTextAlignmentCenter;
    weixinLoginLabel.textColor = RGBACOLOR(163, 163, 158, 1.0f);
    weixinLoginLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [self.view addSubview:weixinLoginLabel];
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-70,self.view.frame.size.width,70)];
    registerButton.backgroundColor =[ UIColor clearColor];
    [registerButton addTarget:self action:@selector(skipRegister) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册HireLib账号" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [registerButton setTitleColor:RGBACOLOR(211, 96, 84, 1.0f)forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
}

#pragma mark -- 从登录跳转到注册
-(void)skipRegister{

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
   //[self presentViewController:registerVC animated:YES completion:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark -- 用户登录
-(void)userLogin{
    
//    ImportResumeViewController *importResumeVC = [[ImportResumeViewController alloc]init];
    
    MarkViewController *markVC = [[MarkViewController alloc]init];
    
    [self.navigationController pushViewController:markVC animated:YES];
    
    
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
