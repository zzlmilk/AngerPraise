//
//  CheckQuestionViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/12.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CheckQuestionViewController.h"
#import "EvaluateListViewController.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface CheckQuestionViewController ()

@end

@implementation CheckQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    self.title = @"评价审核";
    
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-2*30, 40)];
    //describeLabel.backgroundColor = [UIColor yellowColor];
    describeLabel.text = @"  提示: 答对问题才能对好友评价哦!";
    describeLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    describeLabel.textColor = RGBACOLOR(77, 77, 77, 1.0f);
    [self.view addSubview:describeLabel];
    
    
    _companyNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(describeLabel.frame.origin.x+10, describeLabel.frame.origin.y+describeLabel.frame.size.height+70, describeLabel.frame.size.width-10, describeLabel.frame.size.height)];
    _companyNameTextField.placeholder = @"  输入该好友的公司名称";
    _companyNameTextField.background = [UIImage imageNamed:@"baiKuang"];
    [_companyNameTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_companyNameTextField];
    
    
    UILabel * orLabel = [[UILabel alloc]initWithFrame:CGRectMake(_companyNameTextField.frame.origin.x, _companyNameTextField.frame.origin.y+_companyNameTextField.frame.size.height+20, describeLabel.frame.size.width-10, _companyNameTextField.frame.size.height)];
//    orLabel.backgroundColor = [UIColor yellowColor];
    orLabel.text = @"或";
    orLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    orLabel.textColor = RGBACOLOR(34, 86, 124, 1.0f);
    [self.view addSubview:orLabel];
    
    
    _schoolNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(_companyNameTextField.frame.origin.x, orLabel.frame.origin.y+orLabel.frame.size.height+20, orLabel.frame.size.width, orLabel.frame.size.height)];
    _schoolNameTextField.placeholder = @"  输入该好友的毕业院校";
    _schoolNameTextField.background = [UIImage imageNamed:@"baiKuang"];
    [_schoolNameTextField setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:_schoolNameTextField];
    
    
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(_companyNameTextField.frame.origin.x, _schoolNameTextField.frame.origin.y + _schoolNameTextField.frame.size.height +70, _schoolNameTextField.frame.size.width, 40)];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [loginButton.layer setBorderWidth:1.0]; //边框宽度
    [loginButton addTarget:self action:@selector(commitCheckAnswer) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [loginButton.layer setBorderColor:colorref];//边框颜色
    [loginButton setTitle:@"提交" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    loginButton.backgroundColor = RGBACOLOR(94, 123, 167, 1.0f);
    [self.view addSubview:loginButton];
    
}

#pragma mark -- 提交审核答案 对好友进行评价
-(void)commitCheckAnswer{
    EvaluateListViewController *evaluateListVC = [[EvaluateListViewController alloc]init];
    [self.navigationController pushViewController:evaluateListVC animated:YES];
    
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
