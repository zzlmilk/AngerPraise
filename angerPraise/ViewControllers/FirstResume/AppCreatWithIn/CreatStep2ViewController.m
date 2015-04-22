//
//  CreatStep2ViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CreatStep2ViewController.h"
#import "CreatStep3ViewController.h"
#import "AHKActionSheet.h"
#import "ApIClient.h"


@interface CreatStep2ViewController ()

@end

@implementation CreatStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _educationArray = [[NSArray alloc]initWithObjects:
                   @"中专/职高/技校及以上",@"大专及以上",@"本科及以上",@"硕士及以上",@"博士及以上",nil];
    
    _educationTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 120, self.view.frame.size.width-2*30, 40)];
    _educationTextField.borderStyle = UITextBorderStyleRoundedRect;
    _educationTextField.placeholder = @"学历";
    _educationTextField.delegate = self;
    [self.view addSubview:_educationTextField];
    UIButton *educationButton = [[UIButton alloc]init];
    educationButton.frame = _educationTextField.frame;
    [educationButton addTarget:self action:@selector(chooseEducation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:educationButton];
    
    _positionTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, _educationTextField.frame.size.height+_educationTextField.frame.origin.y+50, self.view.frame.size.width-2*30, 40)];
    _positionTextField.borderStyle = UITextBorderStyleRoundedRect;
    _positionTextField.placeholder = @"职位";
    _positionTextField.delegate = self;
    _positionTextField.text = _userNameString;
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
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    nextStepButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:nextStepButton];
}

#pragma mark -- 隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_positionTextField resignFirstResponder];
}

#pragma mark -- 下一步
-(void)nextStep2{
    
    if (_positionTextField.text.length>1 && _educationTextField.text.length>1) {
        
        CreatStep3ViewController *creatStep3VC = [[CreatStep3ViewController alloc]init];
        creatStep3VC.positionNameString = _positionTextField.text;
        creatStep3VC.educationString = _educationTextField.text;
        [self.navigationController pushViewController:creatStep3VC animated:YES];
        
    }else{
    
        [APIClient showMessage:@"职位和学历均不能为空"];
        
    }
    
}

#pragma mark -- 选择学历
-(void)chooseEducation{

    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(nil, nil)];
    
    for (int i =0; i < _educationArray.count; i++) {
        
        NSString *projectList = _educationArray[i];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(projectList, nil)
                                  image:nil
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    
                                    _educationTextField.text = _educationArray[i];
                                }];
        
    }
    
    [actionSheet show];

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
