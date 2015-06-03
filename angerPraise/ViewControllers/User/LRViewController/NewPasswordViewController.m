
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
#import "Register.h"
#import "MainViewController.h"

@interface NewPasswordViewController ()

@end

@implementation NewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = self.view.bounds;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT+10);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UILabel *newsPasswordTipLabel = [[UILabel alloc]init];
    newsPasswordTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y, self.view.frame.size.width-2*35, 35);
    newsPasswordTipLabel.text = @"设置新密码";
    newsPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    newsPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:newsPasswordTipLabel];
    
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
    [_scrollView addSubview:_newsPasswordTextField];
    
    
    UILabel *reNewsPasswordTipLabel = [[UILabel alloc]init];
    reNewsPasswordTipLabel.frame = CGRectMake(_newsPasswordTextField.frame.origin.x,_newsPasswordTextField.frame.size.height+_newsPasswordTextField.frame.origin.y +30, _newsPasswordTextField.frame.size.width, 35);
    reNewsPasswordTipLabel.text = @"确认密码";
    reNewsPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    reNewsPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:reNewsPasswordTipLabel];
    
    _reNewsPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(reNewsPasswordTipLabel.frame.origin.x, reNewsPasswordTipLabel.frame.size.height+reNewsPasswordTipLabel.frame.origin.y, reNewsPasswordTipLabel.frame.size.width, 40)];
    _reNewsPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _reNewsPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _reNewsPasswordTextField.tag = 122;
    _reNewsPasswordTextField.delegate = self;
    _reNewsPasswordTextField.secureTextEntry = YES;
    _reNewsPasswordTextField.layer.borderWidth = 1.0f;
    [_reNewsPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _reNewsPasswordTextField.placeholder = @" 再次输入新密码";
    UIView *retractView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _reNewsPasswordTextField.leftView = retractView2;
    _reNewsPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_reNewsPasswordTextField];
    
    
    UILabel *nameTipLabel = [[UILabel alloc]init];
    nameTipLabel.frame = CGRectMake(_reNewsPasswordTextField.frame.origin.x,_reNewsPasswordTextField.frame.size.height+_reNewsPasswordTextField.frame.origin.y +30, _reNewsPasswordTextField.frame.size.width, 35);
    nameTipLabel.text = @"填写姓名 / 昵称";
    nameTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    nameTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:nameTipLabel];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTipLabel.frame.origin.x, nameTipLabel.frame.size.height+nameTipLabel.frame.origin.y, nameTipLabel.frame.size.width, 40)];
    _userNameTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _userNameTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _userNameTextField.tag = 123;
    _userNameTextField.delegate = self;
    _userNameTextField.layer.borderWidth = 1.0f;
    [_userNameTextField setBorderStyle:UITextBorderStyleLine];
    _userNameTextField.placeholder = @" 请输入姓名或昵称";
    UIView *retractView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _userNameTextField.returnKeyType = UIReturnKeyDone;
    _userNameTextField.leftView = retractView3;
    _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_userNameTextField];
    

    
    UIButton *nextButton = [[UIButton alloc]init];
    nextButton.frame = CGRectMake(90, _userNameTextField.frame.size.height+_userNameTextField.frame.origin.y+80, WIDTH - 2*90, 40);
    [nextButton setTitle:@"提  交" forState:UIControlStateNormal];
    [nextButton.layer setMasksToBounds:YES];
    [nextButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [nextButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    nextButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    nextButton.layer.borderWidth = 1.0f;
    [nextButton addTarget:self action:@selector(nextSetp) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextButton];
    
    //键盘消失通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)name:UIKeyboardWillHideNotification object:nil];
}


//键盘隐藏后处理scrollview的高度，使其还原为本来的高度
-(void)keyboardDidHide:(NSNotification*)notice{
    
    [_scrollView setContentOffset:CGPointMake(0, -40) animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self nextSetp];
    return YES;
    
}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag ==122) {
        
        [_scrollView setContentOffset:CGPointMake(0, 20) animated:YES];

    }else if(textField.tag ==123){
        
        [_scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
        
    }
    
}


#pragma mark -- 下一步
-(void)nextSetp{
    
    NSUInteger pLength = 1;
    
    if (_newsPasswordTextField.text.length < pLength &&_reNewsPasswordTextField.text.length < pLength) {
        

        [APIClient showMessage:@"密码不能为空"];
        
    }else{
        
        if ([_newsPasswordTextField.text isEqualToString:_reNewsPasswordTextField.text]) {
            
            [self sendDateForServer];
            
        }else{
        
            [APIClient showMessage:@"两次密码不一致,请重新输入!"];
        }

    }
    
}


#pragma mark -- 注册 提交 调用接口
-(void)sendDateForServer{
    
    //        NSString * uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
    [dic setObject:_newsPasswordTextField.text forKey:@"password"];
    [dic setObject:_userNameTextField.text forKey:@"name"];
    
    //        [dic setObject:@"ios" forKey:@"device"];
    //        [dic setObject:uuid forKey:@"device_id"];
    //        [dic setObject:@"e91eabc2c2f181f4a0c3715a4ec049df" forKey:@"client_id"];
    
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



#pragma mark -- 隐藏键盘事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_newsPasswordTextField resignFirstResponder];
    [_reNewsPasswordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    
}

#pragma mark -- 返回
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
