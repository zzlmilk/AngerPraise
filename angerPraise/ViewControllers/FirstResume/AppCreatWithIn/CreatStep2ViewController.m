//
//  CreatStep2ViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CreatStep2ViewController.h"
#import "CreatStep3ViewController.h"

@interface CreatStep2ViewController ()

@end

@implementation CreatStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"应用内创建(2/3)";
    
    _educationTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-2*30, 40)];
    _educationTextField.borderStyle = UITextBorderStyleRoundedRect;
    _educationTextField.placeholder = @"学历";
    _educationTextField.delegate = self;
    [self.view addSubview:_educationTextField];
    
    _positionTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, _educationTextField.frame.size.height+_educationTextField.frame.origin.y+50, self.view.frame.size.width-2*30, 40)];
    _positionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _positionTextField.placeholder = @"职位";
    _positionTextField.delegate = self;
    [self.view addSubview:_positionTextField];
    
    UIButton *nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(30, _positionTextField.frame.size.height+_positionTextField.frame.origin.y+100, self.view.frame.size.width-2*30, 45)];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [nextStepButton.layer setBorderWidth:1.0]; //边框宽度
    [nextStepButton addTarget:self action:@selector(nextStep2) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 40, 164, 201, 1 });
    [nextStepButton.layer setBorderColor:colorref2];//边框颜色
    [nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    nextStepButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:nextStepButton];
}

#pragma mark -- 下一步
-(void)nextStep2{
    
    CreatStep3ViewController *creatStep3VC = [[CreatStep3ViewController alloc]init];
    [self.navigationController pushViewController:creatStep3VC animated:YES];
    
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
