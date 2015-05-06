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


@interface IndexViewController ()

@end

@implementation IndexViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-2*30, 50)];
    //describeLabel.backgroundColor = [UIColor yellowColor];
    describeLabel.text = @"登录HireLib, 享受个性化推荐!";
    describeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    describeLabel.textColor = RGBACOLOR(94, 123, 167, 1.0f);
    [self.view addSubview:describeLabel];
    
    UIImageView *inputBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, describeLabel.frame.size.height+describeLabel.frame.origin.y+20, self.view.frame.size.width-2*30, 100)];
    [inputBgImageView setImage:[UIImage imageNamed:@"image1"]];
    [self.view addSubview:inputBgImageView];
    
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(inputBgImageView.frame.origin.x, inputBgImageView.frame.origin.y + inputBgImageView.frame.size.height +130, inputBgImageView.frame.size.width, 45)];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [registerButton.layer setBorderWidth:1.0]; //边框宽度
    [registerButton addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [registerButton.layer setBorderColor:colorref];//边框颜色
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    registerButton.backgroundColor = RGBACOLOR(94, 123, 167, 1.0f);
    [self.view addSubview:registerButton];
    
    
    UIButton *LoginButton = [[UIButton alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-70,self.view.frame.size.width,70)];
    LoginButton.backgroundColor =[ UIColor clearColor];
    [LoginButton addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginButton setTitle:@"已有HireLib账号 登录" forState:UIControlStateNormal];
    LoginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [LoginButton setTitleColor:RGBACOLOR(94, 123, 167, 1.0f)forState:UIControlStateNormal];
    [self.view addSubview:LoginButton];
    
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


#pragma mark -- 邀请好友
-(void)getAddressBookFriends{


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
