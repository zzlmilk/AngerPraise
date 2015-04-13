//
//  CreatStep3ViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CreatStep1ViewController.h"
#import "CreatStep3ViewController.h"
#import "Resume.h"
#import "HomeViewControllers.h"
#import "ApIClient.h"

@interface CreatStep3ViewController ()

@end

@implementation CreatStep3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"应用内创建(1/3)";
    
    _recentCompanyTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-2*30, 40)];
    _recentCompanyTextField.borderStyle = UITextBorderStyleRoundedRect;
    _recentCompanyTextField.placeholder = @"学历";
    _recentCompanyTextField.delegate = self;
    [self.view addSubview:_recentCompanyTextField];
    
    _payRangeTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, _recentCompanyTextField.frame.size.height+_recentCompanyTextField.frame.origin.y+50, self.view.frame.size.width-2*30, 40)];
    _payRangeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _payRangeTextField.placeholder = @"职位";
    _payRangeTextField.delegate = self;
    [self.view addSubview:_payRangeTextField];
    
    UIButton *nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(30, _payRangeTextField.frame.size.height+_payRangeTextField.frame.origin.y+100, self.view.frame.size.width-2*30, 45)];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [nextStepButton.layer setBorderWidth:1.0]; //边框宽度
    [nextStepButton addTarget:self action:@selector(completeCreatResume) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 40, 164, 201, 1 });
    [nextStepButton.layer setBorderColor:colorref2];//边框颜色
    [nextStepButton setTitle:@"创 建" forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    nextStepButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:nextStepButton];
    
    
    
}

#pragma mark -- 完成简历的创建
-(void)completeCreatResume{
    
    NSLog(@"%@",@"取值发送给server");
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    [dic setObject:@"王小二" forKey:@"user_name"];
    [dic setObject:@"男" forKey:@"user_sex"];
    [dic setObject:@"21" forKey:@"user_age"];
    [dic setObject:@"互联网产品经理" forKey:@"position"];
    [dic setObject:@"亚杰信息技术服务有限公司" forKey:@"company_name"];
    [dic setObject:@"2" forKey:@"education_id"];
    [dic setObject:@"2" forKey:@"user_compensation"];//薪资 id
    
    [Resume appCreatedResume:dic WithBlock:^(Resume *resume, Error *e) {
       
        if ([resume.res isEqualToString:@"1"]) {
            
            [APIClient showMessage:@"创建成功"];
            
            HomeViewControllers *homeVC = [[HomeViewControllers alloc]init];
            [self presentViewController:homeVC animated:YES completion:nil];
            
        }else{
            
            [APIClient showMessage:e.info title:@"创建失败"];
            
        }

    }];
    
    
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
