//
//  EditPasswordViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/2.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "EditPasswordViewController.h"

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = self.view.bounds;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT+10);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = FALSE;
    [self.view addSubview:_scrollView];
    
    
    UILabel *oldPasswordTipLabel = [[UILabel alloc]init];
    oldPasswordTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y-10, self.view.frame.size.width-2*35, 35);
    oldPasswordTipLabel.text = @"旧密码";
    oldPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    oldPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:oldPasswordTipLabel];
    
    _oldPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(oldPasswordTipLabel.frame.origin.x, oldPasswordTipLabel.frame.size.height+oldPasswordTipLabel.frame.origin.y,oldPasswordTipLabel.frame.size.width, 40)];
    [_oldPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _oldPasswordTextField.placeholder = @"  输入旧密码";
    _oldPasswordTextField.delegate = self;
    _oldPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _oldPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _oldPasswordTextField.delegate = self;
    _oldPasswordTextField.layer.borderWidth = 1.0f;
    UIView *retractView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _oldPasswordTextField.leftView = retractView;
    _oldPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [_oldPasswordTextField becomeFirstResponder];
    [_scrollView addSubview:_oldPasswordTextField];
    
    
    UILabel *newPasswordTipLabel = [[UILabel alloc]init];
    newPasswordTipLabel.frame = CGRectMake(35, _oldPasswordTextField.frame.size.height+_oldPasswordTextField.frame.origin.y+25, self.view.frame.size.width-2*35, 35);
    newPasswordTipLabel.text = @"新密码";
    newPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    newPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:newPasswordTipLabel];
    
    _editNewPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(newPasswordTipLabel.frame.origin.x, newPasswordTipLabel.frame.size.height+newPasswordTipLabel.frame.origin.y,newPasswordTipLabel.frame.size.width, 40)];
    [_editNewPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _editNewPasswordTextField.placeholder = @"  输入新密码";
    _editNewPasswordTextField.delegate = self;
    _editNewPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _editNewPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _editNewPasswordTextField.delegate = self;
    _editNewPasswordTextField.tag = 222;
    _editNewPasswordTextField.layer.borderWidth = 1.0f;
    UIView *retractView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _editNewPasswordTextField.leftView = retractView1;
    _editNewPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_editNewPasswordTextField];
    
    
    
    UILabel *reNewPasswordTipLabel = [[UILabel alloc]init];
    reNewPasswordTipLabel.frame = CGRectMake(35, _editNewPasswordTextField.frame.size.height+_editNewPasswordTextField.frame.origin.y+25, self.view.frame.size.width-2*35, 35);
    reNewPasswordTipLabel.text = @"确认新密码";
    reNewPasswordTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    reNewPasswordTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_scrollView addSubview:reNewPasswordTipLabel];
    
    _reEditNewPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(reNewPasswordTipLabel.frame.origin.x, reNewPasswordTipLabel.frame.size.height+reNewPasswordTipLabel.frame.origin.y,reNewPasswordTipLabel.frame.size.width, 40)];
    [_reEditNewPasswordTextField setBorderStyle:UITextBorderStyleLine];
    _reEditNewPasswordTextField.placeholder = @"  重新输入新密码";
    _reEditNewPasswordTextField.delegate = self;
    _reEditNewPasswordTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _reEditNewPasswordTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _reEditNewPasswordTextField.delegate = self;
    _reEditNewPasswordTextField.tag = 223;
    _reEditNewPasswordTextField.keyboardType = UIKeyboardTypeDefault;
    _reEditNewPasswordTextField.returnKeyType = UIReturnKeyDone;
    _reEditNewPasswordTextField.layer.borderWidth = 1.0f;
    UIView *retractView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _reEditNewPasswordTextField.leftView = retractView2;
    _reEditNewPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_reEditNewPasswordTextField];
    
    
    UIButton *confirmButton = [[UIButton alloc]init];
    confirmButton.frame = CGRectMake(80,_reEditNewPasswordTextField.frame.origin.y+_reEditNewPasswordTextField.frame.size.height+80, WIDTH-2*80, 40);
    [confirmButton setTitle:@"确 认 修 改" forState:UIControlStateNormal];
    [confirmButton.layer setMasksToBounds:YES];
    [confirmButton.layer setCornerRadius:40/2.f]; //设置矩形四个圆角半径
    [confirmButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    confirmButton.layer.borderWidth = 1.0f;
    confirmButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    confirmButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [confirmButton addTarget:self action:@selector(confirmEdit) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:confirmButton];

    //键盘消失通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)name:UIKeyboardWillHideNotification object:nil];
    
}

//键盘隐藏后处理scrollview的高度，使其还原为本来的高度
-(void)keyboardDidHide:(NSNotification*)notice{
    
    [_scrollView setContentOffset:CGPointMake(0, -40) animated:YES];
    
}

#pragma mark -- 隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_oldPasswordTextField resignFirstResponder];
    [_editNewPasswordTextField resignFirstResponder];
    [_reEditNewPasswordTextField resignFirstResponder];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 确认修改
-(void)confirmEdit{


}

#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag ==222) {
        
        [_scrollView setContentOffset:CGPointMake(0, 5) animated:YES];
        
    }else if(textField.tag ==223){
        
        [_scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
        
    }
    
}

#pragma mark -- 键盘 return
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    return YES;
    
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
