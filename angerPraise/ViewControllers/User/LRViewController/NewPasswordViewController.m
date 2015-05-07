
//
//  NewPasswordViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "NewPasswordViewController.h"
#import "PersonInfoViewController.h"
#import "ApIClient.h"

@interface NewPasswordViewController ()

@end

@implementation NewPasswordViewController

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
    
    
    _newsPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, backBtn.frame.size.height+backBtn.frame.origin.y+40, self.view.frame.size.width-2*20, 50)];
    [_newsPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _newsPasswordTextField.background = [UIImage imageNamed:@"baiKuang"];
    _newsPasswordTextField.placeholder = @"请输入新密码";
    [self.view addSubview:_newsPasswordTextField];
    
    
    _reNewsPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _newsPasswordTextField.frame.size.height+_newsPasswordTextField.frame.origin.y+20, self.view.frame.size.width-2*20, 50)];
    [_reNewsPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _reNewsPasswordTextField.background = [UIImage imageNamed:@"baiKuang"];
    _reNewsPasswordTextField.placeholder = @" 重新输入新密码";
    [self.view addSubview:_reNewsPasswordTextField];
    
    
    UIButton *nextButton = [[UIButton alloc]init];
    nextButton.frame = CGRectMake(20, _reNewsPasswordTextField.frame.size.height+_reNewsPasswordTextField.frame.origin.y+130, self.view.frame.size.width - 2*20, 45);
    [nextButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [nextButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    nextButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    
    
}

-(void)next{
    
    
    
    if ([_newsPasswordTextField.text isEqual:@""]) {
        

        [APIClient showMessage:@"新密码不能为空"];
        
    }else {
    
        PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc]init];
        personInfoVC.phoneNumberString = _phoneNumberString;
        personInfoVC.newsPasswordString = _newsPasswordTextField.text;
        
        [self.navigationController pushViewController:personInfoVC animated:YES];
        
    }
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_newsPasswordTextField resignFirstResponder];
    [_reNewsPasswordTextField resignFirstResponder];
    
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
