//
//  SetNewPasswordViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/26.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "SetNewPasswordViewController.h"
#import "Register.h"
#import "SMS_MBProgressHUD.h"
#import "ApIClient.h"
#import "IndexViewController.h"
#import "User.h"
#import "NoozanAppdelegate.h"



@interface SetNewPasswordViewController ()

@end

@implementation SetNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
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
    
    
    UILabel *newsPasswordTipLabel = [[UILabel alloc]init];
    newsPasswordTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+40, self.view.frame.size.width-2*35, 35);
    newsPasswordTipLabel.text = @"设置新密码";
    newsPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    newsPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:newsPasswordTipLabel];
    
    _newsPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(newsPasswordTipLabel.frame.origin.x, newsPasswordTipLabel.frame.size.height+newsPasswordTipLabel.frame.origin.y,newsPasswordTipLabel.frame.size.width, 40)];
    [_newsPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _newsPasswordTextField.placeholder = @" 字母 / 数字 至少6个字符";
    _newsPasswordTextField.delegate = self;
    _newsPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _newsPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _newsPasswordTextField.tag = 121;
    _newsPasswordTextField.delegate = self;
    _newsPasswordTextField.secureTextEntry = YES;
    _newsPasswordTextField.layer.borderWidth = 1.0f;
    UIView *retractView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _newsPasswordTextField.leftView = retractView;
    _newsPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_newsPasswordTextField];
    
    UILabel *reNewsPasswordTipLabel = [[UILabel alloc]init];
    reNewsPasswordTipLabel.frame = CGRectMake(_newsPasswordTextField.frame.origin.x,_newsPasswordTextField.frame.size.height+_newsPasswordTextField.frame.origin.y +30, _newsPasswordTextField.frame.size.width, 35);
    reNewsPasswordTipLabel.text = @"确认密码";
    reNewsPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    reNewsPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:reNewsPasswordTipLabel];
    
    _reNewsPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(reNewsPasswordTipLabel.frame.origin.x, reNewsPasswordTipLabel.frame.size.height+reNewsPasswordTipLabel.frame.origin.y, reNewsPasswordTipLabel.frame.size.width, 40)];
    _reNewsPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _reNewsPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _reNewsPasswordTextField.tag = 122;
    _reNewsPasswordTextField.delegate = self;
    _reNewsPasswordTextField.secureTextEntry = YES;
    _reNewsPasswordTextField.returnKeyType = UIReturnKeyDone;
    _reNewsPasswordTextField.layer.borderWidth = 1.0f;
    [_reNewsPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _reNewsPasswordTextField.placeholder = @" 再次输入新密码";
    UIView *retractView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _reNewsPasswordTextField.leftView = retractView2;
    _reNewsPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_reNewsPasswordTextField];
    
    UIButton *nextButton = [[UIButton alloc]init];
    nextButton.frame = CGRectMake(90, _reNewsPasswordTextField.frame.size.height+_reNewsPasswordTextField.frame.origin.y+120, WIDTH - 2*90, 40);
    [nextButton setTitle:@"提  交" forState:UIControlStateNormal];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [nextButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    nextButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    nextButton.layer.borderWidth = 1.0f;
    [nextButton addTarget:self action:@selector(submitPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 隐藏键盘事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_newsPasswordTextField resignFirstResponder];
    [_reNewsPasswordTextField resignFirstResponder];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self submitPassword];
    return YES;
    
}

-(void)submitPassword{
    
    if (_newsPasswordTextField.text.length && _reNewsPasswordTextField.text.length) {
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberString forKey:@"phone"];
        [dic setObject:_newsPasswordTextField.text forKey:@"password"];
        [dic setObject:_reNewsPasswordTextField.text forKey:@"repeat_password"];
        
        [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Register setNewPassword:dic WithBlock:^(Register *reg, Error *e) {
            [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
            if (e.info) {
                
                [APIClient showMessage:e.info];
                
            }
            else{
                [APIClient showSuccess:@"新密码设置成功" title:@"成功"];
            }
            
            
            if (reg) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:reg.u.user_token forKey:USER_TOKEN];
                [userDefaults setObject:reg.u.user_id forKey:USER_ID];
                [userDefaults setObject:reg.u.hr_privilege forKey:@"user_type"];                
                [[NoozanAppdelegate getAppDelegate] getMainVC];

            }
            
            
        }];
        
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
