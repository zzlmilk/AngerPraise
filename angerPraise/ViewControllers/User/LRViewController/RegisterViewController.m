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

#import "NewPasswordViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    
//    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, WIDTH-2*20, 50)];
//    [_phoneNumberTextField setBorderStyle:UITextBorderStyleLine];
//    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
//    _phoneNumberTextField.background = [UIImage imageNamed:@"baiKuang"];
//    _phoneNumberTextField.placeholder = @" 手机号";
//    [self.view addSubview:_phoneNumberTextField];
    
    
    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 130, 200, 50)];
    [_phoneNumberTextField setBorderStyle:UITextBorderStyleLine];
    _phoneNumberTextField.background = [UIImage imageNamed:@"baiKuang"];
    _phoneNumberTextField.placeholder = @" 手机号码";
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneNumberTextField];
    
    _getStarPasswordButton = [[UIButton alloc]initWithFrame:CGRectMake(_phoneNumberTextField.frame.size.width+_phoneNumberTextField.frame.origin.x+5,_phoneNumberTextField.frame.origin.y,self.view.frame.size.width-_phoneNumberTextField.frame.size.width-2*20,50)];
    [_getStarPasswordButton.layer setMasksToBounds:YES];
    [_getStarPasswordButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_getStarPasswordButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace1,(CGFloat[]){ 211, 58, 59, 1 });
    [_getStarPasswordButton.layer setBorderColor:colorref2];//边框颜色
    [_getStarPasswordButton setTitle:@"获取密码" forState:UIControlStateNormal];
    _getStarPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [_getStarPasswordButton addTarget:self action:@selector(getInitPassword) forControlEvents:UIControlEventTouchUpInside];
    _getStarPasswordButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [self.view addSubview:_getStarPasswordButton];
    
    
    _captchaTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _phoneNumberTextField.frame.size.height+_phoneNumberTextField.frame.origin.y+20, _phoneNumberTextField.frame.size.width, 50)];
    _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_captchaTextField setBorderStyle:UITextBorderStyleLine];
    _captchaTextField.background = [UIImage imageNamed:@"baiKuang"];
    _captchaTextField.placeholder = @" 初始密码";
    [self.view addSubview:_captchaTextField];
    
    
//    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _captchaTextField.frame.size.height+_captchaTextField.frame.origin.y+20, self.view.frame.size.width-2*20, 50)];
//    [_passwordTextField setBorderStyle:UITextBorderStyleLine];
//    _passwordTextField.background = [UIImage imageNamed:@"baiKuang"];
//    _passwordTextField.placeholder = @" 密码";
//    [self.view addSubview:_passwordTextField];
//    
//    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _passwordTextField.frame.size.height+_passwordTextField.frame.origin.y+5, _passwordTextField.frame.size.width, 30)];
//    passwordLabel.text = @"需要包含字母数字, 至少8个字符, 区分大小写";
//    passwordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    passwordLabel.textColor = RGBACOLOR(189, 190, 184, 1.0f);
//    [self.view addSubview:passwordLabel];
//    
//    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, _captchaTextField.frame.size.height+passwordLabel.frame.origin.y-5, self.view.frame.size.width-2*20, 50)];
//    [_userNameTextField setBorderStyle:UITextBorderStyleLine];
//    _userNameTextField.background = [UIImage imageNamed:@"baiKuang"];
//    _userNameTextField.placeholder = @" 用户名";
//    [self.view addSubview:_userNameTextField];
//    
//    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _userNameTextField.frame.size.height+_userNameTextField.frame.origin.y+5, _userNameTextField.frame.size.width, 30)];
//    userNameLabel.text = @"不多于14个英文字母或7个汉字";
//    userNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
//    userNameLabel.textColor = RGBACOLOR(189, 190, 184, 1.0f);
//    [self.view addSubview:userNameLabel];
    
    
    UIButton *isInitPasswordButton = [[UIButton alloc]init];
    isInitPasswordButton.frame = CGRectMake(20, _captchaTextField.frame.size.height+_captchaTextField.frame.origin.y+130, self.view.frame.size.width - 2*20, 45);
    [isInitPasswordButton setTitle:@"注 册" forState:UIControlStateNormal];
    [isInitPasswordButton.layer setMasksToBounds:YES];
    [isInitPasswordButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [isInitPasswordButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    isInitPasswordButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    isInitPasswordButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [isInitPasswordButton addTarget:self action:@selector(isInitPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isInitPasswordButton];
    
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_phoneNumberTextField resignFirstResponder];
    [_captchaTextField resignFirstResponder];
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获取初始密码
-(void)getInitPassword{
    
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
                _getStarPasswordButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
                [_getStarPasswordButton setTitle:@"重新获取" forState:UIControlStateNormal];
                
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [_getStarPasswordButton setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
    
                _getStarPasswordButton.userInteractionEnabled = NO;
                _getStarPasswordButton.backgroundColor = [UIColor grayColor];
                
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);

}

//获取初始密码
-(void)reGetInitPassword{

        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
    
        [InitPassword getInitPassword:dic WithBlock:^(InitPassword *initPassword, Error *e) {
    
            //NSLog(@"%@",initPassword);
    
            if (initPassword.password !=nil) {
    
                [APIClient showMessage:@"初始密码已发送,请注意查收"];
            }
            
        }];
    
}

//验证初始密码
-(void)isInitPassword{
    
    
//    NewPasswordViewController *newPasswordVC =[[NewPasswordViewController alloc]init];
//    newPasswordVC.phoneNumberString = _phoneNumberTextField.text;
//    [self.navigationController pushViewController:newPasswordVC animated:YES];
    
    if ([_phoneNumberTextField.text isEqual:@""]) {
        
        [APIClient showMessage:@"手机号码不能为空"];
        
    }else{
    
            NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
            [dic setObject:_phoneNumberTextField.text forKey:@"phone"];
            [dic setObject:_captchaTextField.text forKey:@"password"];
        
            [InitPassword isInitPassword:dic WithBlock:^(InitPassword *initPassword, Error *e) {
        
                if (e.info !=nil) {
                    
                    [APIClient showMessage:e.info title:@"提示"];
                    
                }else if ([initPassword.validation_inital isEqualToString:@"1"] ) {
        
                    //跳转页面
                    //[APIClient showSuccess:@"等待页面跳转" title:@"验证成功"];
        
                    NewPasswordViewController *newPasswordVC =[[NewPasswordViewController alloc]init];
                    newPasswordVC.phoneNumberString = _phoneNumberTextField.text;
                    [self.navigationController pushViewController:newPasswordVC animated:YES];
                    
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
