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
#import "MainViewController.h"
#import "ApIClient.h"
#import "AHKActionSheet.h"

@interface CreatStep3ViewController ()

@end

@implementation CreatStep3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _payRangeArray = [[NSArray alloc]initWithObjects:
                       @"3000以下",@"3000-4999",@"5000-7999",
                      @"8000-9999",@"10000-14999",@"15000-19999",
                      @"20000以上",nil];
    
    _recentCompanyTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-2*30, 40)];
    _recentCompanyTextField.borderStyle = UITextBorderStyleRoundedRect;
    _recentCompanyTextField.placeholder = @"最近工作的公司名称";
    _recentCompanyTextField.delegate = self;
    [self.view addSubview:_recentCompanyTextField];
    
    _payRangeTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, _recentCompanyTextField.frame.size.height+_recentCompanyTextField.frame.origin.y+50, self.view.frame.size.width-2*30, 40)];
    _payRangeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _payRangeTextField.placeholder = @"薪资范围";
    _payRangeTextField.delegate = self;
    [self.view addSubview:_payRangeTextField];
    UIButton *payRangeButton = [[UIButton alloc]init];
    payRangeButton.frame = _payRangeTextField.frame;
    [payRangeButton addTarget:self action:@selector(choosePayRange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payRangeButton];
    
    
    UIButton *nextStepButton = [[UIButton alloc]initWithFrame:CGRectMake(30, _payRangeTextField.frame.size.height+_payRangeTextField.frame.origin.y+100, self.view.frame.size.width-2*30, 45)];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [nextStepButton.layer setBorderWidth:1.0]; //边框宽度
    [nextStepButton addTarget:self action:@selector(completeCreatResume) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 40, 164, 201, 1 });
    [nextStepButton.layer setBorderColor:colorref2];//边框颜色
    [nextStepButton setTitle:@"创 建" forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    nextStepButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:nextStepButton];
    
    
    
}

#pragma mark -- 选择薪资范围
-(void)choosePayRange{

    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(nil, nil)];
    
    for (int i =0; i < _payRangeArray.count; i++) {
        
        NSString *projectList = _payRangeArray[i];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(projectList, nil)
                                  image:nil
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    
                                    _payRangeTextField.text = _payRangeArray[i];
                                }];
        
    }
    
    [actionSheet show];
    
}

#pragma mark -- 判断 公司 和 薪资 是否为空
-(void)completeCreatResume{
    
    if (_payRangeTextField.text.length>1 && _recentCompanyTextField.text.length>1) {
        
        [self createResume];
        
    }else{
        
//        [APIClient showMessage:@"公司名称和薪资范围不能为空"];
        [APIClient showInfo:nil title:@"公司名称和薪资范围不能为空"];
        
    }
    
}

#pragma mark -- 完成简历的创建
-(void)createResume{

   // NSLog(@"%@",@"取值发送给server");
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    [dic setObject:@"王小二" forKey:@"user_name"];
    [dic setObject:@"男" forKey:@"user_sex"];
    [dic setObject:@"21" forKey:@"user_age"];
    [dic setObject:_positionNameString forKey:@"position"];
    [dic setObject:_recentCompanyTextField.text forKey:@"company_name"];
    [dic setObject:@"2" forKey:@"education_id"];
    [dic setObject:@"2" forKey:@"user_compensation"];//薪资 id
    
    [Resume appCreatedResume:dic WithBlock:^(Resume *resume, Error *e) {
        
        if ([resume.res isEqualToString:@"1"]) {
            
            [APIClient showMessage:@"创建成功"];
            
            MainViewController *mainVC = [[MainViewController alloc]init];
            [self presentViewController:mainVC animated:YES completion:nil];
            
        }else{
            
            [APIClient showMessage:e.info title:@"创建失败"];
            
        }
        
    }];

}

#pragma mark -- 隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_recentCompanyTextField resignFirstResponder];
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
