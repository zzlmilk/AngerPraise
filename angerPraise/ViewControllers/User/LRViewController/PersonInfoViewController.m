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
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20,backBtn.frame.size.height+backBtn.frame.origin.y+100,self.view.frame.size.width-2*20, 50)];
    [_userNameTextField setBorderStyle:UITextBorderStyleLine];
    _userNameTextField.background = [UIImage imageNamed:@"baiKuang"];
    _userNameTextField.placeholder = @" 真实姓名";
    [self.view addSubview:_userNameTextField];
    
    _sexTextField = [[UITextField alloc]initWithFrame:CGRectMake(20,_userNameTextField.frame.size.height+_userNameTextField.frame.origin.y+20,self.view.frame.size.width-2*20, 50)];
    [_sexTextField setBorderStyle:UITextBorderStyleLine];
    _sexTextField.background = [UIImage imageNamed:@"baiKuang"];
    _sexTextField.placeholder = @" 1 或 2";
    [self.view addSubview:_sexTextField];
    
    _birthdayTextField = [[UITextField alloc]initWithFrame:CGRectMake(20,_sexTextField.frame.size.height+_sexTextField.frame.origin.y+20,self.view.frame.size.width-2*20, 50)];
    [_birthdayTextField setBorderStyle:UITextBorderStyleLine];
    _birthdayTextField.background = [UIImage imageNamed:@"baiKuang"];
    _birthdayTextField.placeholder = @" 生日";
    [self.view addSubview:_birthdayTextField];
    
    
    UIButton *submitButton = [[UIButton alloc]init];
    submitButton.frame = CGRectMake(20, _birthdayTextField.frame.size.height+_birthdayTextField.frame.origin.y+40, self.view.frame.size.width - 2*20, 45);
    [submitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [submitButton.layer setMasksToBounds:YES];
    [submitButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [submitButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    submitButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [submitButton addTarget:self action:@selector(submitRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    
}


-(void)submitRegister{

    NSString * uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:_phoneNumberString forKey:@"phone"];
    [dic setObject:_newsPasswordString forKey:@"password"];
    [dic setObject:_userNameTextField.text forKey:@"name"];
    [dic setObject:@"1" forKey:@"sex_id"];
    [dic setObject:@"1987-7-8" forKey:@"birthday"];
    [dic setObject:@"ios" forKey:@"device"];
    [dic setObject:uuid forKey:@"device_id"];
    [dic setObject:@"e91eabc2c2f181f4a0c3715a4ec049df" forKey:@"client_id"];
    
    [Register userRegister:dic WithBlock:^(Register *reg, Error *e) {
        
        if (e.info !=nil) {

            [APIClient showInfo:e.info title:@"提示"];
            
        }else if(![reg.user_id isEqual: @""]){
        
            NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
            [userId setObject:reg.user_id forKey:@"userId"];
            
            [APIClient showSuccess:@"注册成功" title:@"成功"];
            
            MainViewController *mainVC = [[MainViewController alloc]init];
            [self.navigationController pushViewController:mainVC animated:YES];
            
        }
        
    }];

}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_userNameTextField resignFirstResponder];

    
}

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
