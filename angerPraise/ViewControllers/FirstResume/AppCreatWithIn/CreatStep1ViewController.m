//
//  GuideFillViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CreatStep1ViewController.h"
#import "ShareViewController.h"
#import "ApIClient.h"
#import "CreatStep2ViewController.h"


@interface CreatStep1ViewController ()

@end

@implementation CreatStep1ViewController

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
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-2*30, 40)];
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.placeholder = @"姓名";
    _userNameTextField.delegate = self;
    [self.view addSubview:_userNameTextField];
    
    
    UIButton *nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 200+140, self.view.frame.size.width-2*30, 45)];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [nextStepButton.layer setBorderWidth:1.0]; //边框宽度
    [nextStepButton addTarget:self action:@selector(nextStepa) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 40, 164, 201, 1 });
    [nextStepButton.layer setBorderColor:colorref2];//边框颜色
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    nextStepButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:nextStepButton];
    
}


#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 下一步
-(void)nextStepa{

    CreatStep2ViewController *creatStep2VC = [[CreatStep2ViewController alloc]init];

    [self.navigationController pushViewController:creatStep2VC animated:YES];
    
}

#pragma mark -- 点击return 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userNameTextField resignFirstResponder];
    
    return YES;
}
#pragma mark -- 点击空白 隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_userNameTextField resignFirstResponder];
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
