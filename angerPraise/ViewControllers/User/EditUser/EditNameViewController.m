//
//  EditNameViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/2.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "EditNameViewController.h"
#import "User.h"
#import "ApIClient.h"
#import "UserViewController.h"

@interface EditNameViewController ()

@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
    UILabel *editNameTipLabel = [[UILabel alloc]init];
    editNameTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+20, self.view.frame.size.width-2*35, 35);
    editNameTipLabel.text = @"新昵称";
    editNameTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    editNameTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:editNameTipLabel];
    
    _editNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(editNameTipLabel.frame.origin.x, editNameTipLabel.frame.size.height+editNameTipLabel.frame.origin.y+10,editNameTipLabel.frame.size.width, 40)];
    [_editNameTextField setBorderStyle:UITextBorderStyleLine];
//    _editNameTextField.placeholder = @"";
    _editNameTextField.delegate = self;
    _editNameTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _editNameTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _editNameTextField.text = _editNameString;
    _editNameTextField.keyboardType = UIKeyboardTypeDefault;
    _editNameTextField.returnKeyType = UIReturnKeyDone;
    _editNameTextField.delegate = self;
    _editNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _editNameTextField.layer.borderWidth = 1.0f;
    UIView *retractView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _editNameTextField.leftView = retractView;
    _editNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [_editNameTextField becomeFirstResponder];
    [self.view addSubview:_editNameTextField];
    
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 键盘 return
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self userUpdateNickname];
    return YES;
    
}


-(void)userUpdateNickname{
    
    NSUInteger pLength = 1;
    
    if (_editNameTextField.text.length < pLength) {
        
        [APIClient showMessage:@"亲，新名称不能为空哟～"];

    }else{
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
        
        [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
        [dic setObject:_editNameTextField.text forKey:@"nickname"];
        
        [User userUpdateNickname:dic WithBlock:^(User *user, Error *e) {
            
            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];
                
            }else{
                
                int intRes = [user.res intValue];
                if (intRes == 1) {
                    [APIClient showSuccess:@"昵称修改成功" title:@"成功"];
                    
                    [self doBack];
                }

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
