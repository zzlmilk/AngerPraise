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
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    
    _payRangeArray = [[NSArray alloc]initWithObjects:
                      @"3000以下",@"3000-4999",@"5000-7999",
                      @"8000-9999",@"10000-14999",@"15000-19999",
                      @"20000以上",nil];
    _experienceArray = [[NSArray alloc]initWithObjects:
                        @"应届毕业生",@"0-2年",@"3-5年",@"6-8年",@"10年以上",@"不限",nil];
    
    _educationArray = [[NSArray alloc]initWithObjects:
                   @"中专/职高/技校及以上",@"大专及以上",@"本科及以上",@"硕士及以上",@"博士及以上",nil];
    
    
    UILabel *nameTipLabel = [[UILabel alloc]init];
    nameTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+50, self.view.frame.size.width-2*35, 35);
    nameTipLabel.text = @"你的最高学历是什么？";
    nameTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    nameTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:nameTipLabel];
    
    _educationTextField = [[UITextField alloc]initWithFrame:CGRectMake(nameTipLabel.frame.origin.x, nameTipLabel.frame.size.height+nameTipLabel.frame.origin.y,nameTipLabel.frame.size.width, 40)];
    [_educationTextField setBorderStyle:UITextBorderStyleLine];
    _educationTextField.placeholder = @"--请选择--";
    _educationTextField.delegate = self;
    _educationTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _educationTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _educationTextField.textAlignment = NSTextAlignmentCenter;
    _educationTextField.layer.borderWidth = 1.0f;
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _educationTextField.tag = 111;
    _educationTextField.leftView = nameView;
    _educationTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_educationTextField];
    
    
    UILabel *sexTipLabel = [[UILabel alloc]init];
    sexTipLabel.frame = CGRectMake(_educationTextField.frame.origin.x,_educationTextField.frame.size.height+_educationTextField.frame.origin.y +20, _educationTextField.frame.size.width, 35);
    sexTipLabel.text = @"你有几年工作经验？";
    sexTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    sexTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:sexTipLabel];
    
    _positionTextField = [[UITextField alloc]initWithFrame:CGRectMake(sexTipLabel.frame.origin.x, sexTipLabel.frame.size.height+sexTipLabel.frame.origin.y, sexTipLabel.frame.size.width, 40)];
    _positionTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _positionTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _positionTextField.layer.borderWidth = 1.0f;
    [_positionTextField setBorderStyle:UITextBorderStyleLine];
    _positionTextField.placeholder = @"--请选择--";
    _positionTextField.delegate = self;
    _positionTextField.tag = 112;
    _positionTextField.textAlignment = NSTextAlignmentCenter;
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _positionTextField.leftView = sexView;
    _positionTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_positionTextField];
    
    
    UILabel *payTipLabel = [[UILabel alloc]init];
    payTipLabel.frame = CGRectMake(_positionTextField.frame.origin.x,_positionTextField.frame.size.height+_positionTextField.frame.origin.y +20, _positionTextField.frame.size.width, 35);
    payTipLabel.text = @"你的月薪在什么范围？";
    payTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    payTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:payTipLabel];
    
    _payRangeTextField = [[UITextField alloc]initWithFrame:CGRectMake(payTipLabel.frame.origin.x, payTipLabel.frame.size.height+payTipLabel.frame.origin.y, payTipLabel.frame.size.width, 40)];
    _payRangeTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _payRangeTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _payRangeTextField.layer.borderWidth = 1.0f;
    [_payRangeTextField setBorderStyle:UITextBorderStyleLine];
    _payRangeTextField.placeholder = @"--请选择--";
    _payRangeTextField.delegate = self;
    _payRangeTextField.tag = 113;
    _payRangeTextField.textAlignment = NSTextAlignmentCenter;
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _payRangeTextField.leftView = payView;
    _payRangeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_payRangeTextField];
    

    UIButton *nextStepButton = [[UIButton alloc]init];
    nextStepButton.frame = CGRectMake(90, _payRangeTextField.frame.size.height+_payRangeTextField.frame.origin.y+80, WIDTH - 2*90, 40);
    [nextStepButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [nextStepButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    nextStepButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    nextStepButton.layer.borderWidth = 1.0f;
    [nextStepButton addTarget:self action:@selector(nextStep2) forControlEvents:UIControlEventTouchUpInside];
    nextStepButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nextStepButton];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 下一步
-(void)nextStep2{
    
    if (_positionTextField.text.length>1 && _educationTextField.text.length>1) {
        
        CreatStep3ViewController *creatStep3VC = [[CreatStep3ViewController alloc]init];
        creatStep3VC.positionNameString = _positionTextField.text;
        creatStep3VC.educationString = _educationTextField.text;
        [self.navigationController pushViewController:creatStep3VC animated:YES];
        
    }else{
    
        [APIClient showTextMeggage:@"职位和学历均不能为空" view:self.view];

    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    NSArray *loopArray = [[NSArray alloc]init];
    
    if (textField.tag == 111) {
        loopArray = _educationArray;
        
        [_educationTextField resignFirstResponder];
        
    }else if(textField.tag == 112){
        
        loopArray =_experienceArray;
        [_positionTextField resignFirstResponder];
    
    }else if (textField.tag ==113){
    
        loopArray = _payRangeArray;
        [_payRangeTextField resignFirstResponder];

    }
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(nil, nil)];
    
    for (int i =0; i < loopArray.count; i++) {
        
        NSString *projectList = loopArray[i];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(projectList, nil)
                                  image:nil
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    
                                    
                                    if (textField.tag ==111) {
                                        _educationTextField.text = loopArray[i];
                                        
                                    }else if(textField.tag ==112){
                                        _positionTextField.text = loopArray[i];
                                    
                                    }else if(textField.tag ==113){
                                    _payRangeTextField.text = loopArray[i];
                                    }
                                    
                                }];
        
    }
    
    [actionSheet show];
    
}


#pragma mark -- 隐藏键盘事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_positionTextField resignFirstResponder];
    [_payRangeTextField resignFirstResponder];
    [_educationTextField resignFirstResponder];
    
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
