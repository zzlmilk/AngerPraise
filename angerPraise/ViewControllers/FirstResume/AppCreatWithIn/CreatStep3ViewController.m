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
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _workPlaceArray = [[NSArray alloc]initWithObjects:
                       @"北京",@"上海",@"广州",
                      @"深圳",nil];
    _workTimeArray = [[NSArray alloc]initWithObjects:
                       @"白班",@"晚班",@"翻班",nil];
    
    
    UILabel *companyTipLabel = [[UILabel alloc]init];
    companyTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+50, self.view.frame.size.width-2*35, 35);
    companyTipLabel.text = @"最近工作过的公司名称？";
    companyTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    companyTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:companyTipLabel];
    
    
    
    _companyNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(companyTipLabel.frame.origin.x, companyTipLabel.frame.size.height+companyTipLabel.frame.origin.y,companyTipLabel.frame.size.width, 40)];
    [_companyNameTextField setBorderStyle:UITextBorderStyleLine];
    _companyNameTextField.placeholder = @"请输入公司名称";
    //_companyNameTextField.delegate = self;
    _companyNameTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _companyNameTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _companyNameTextField.textAlignment = NSTextAlignmentCenter;
    _companyNameTextField.layer.borderWidth = 1.0f;
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _companyNameTextField.tag = 115;
    _companyNameTextField.leftView = nameView;
    _companyNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_companyNameTextField];
    
    
    UILabel *timeTipLabel = [[UILabel alloc]init];
    timeTipLabel.frame = CGRectMake(_companyNameTextField.frame.origin.x,_companyNameTextField.frame.size.height+_companyNameTextField.frame.origin.y +20, _companyNameTextField.frame.size.width, 35);
    timeTipLabel.text = @"你有几年工作经验？";
    timeTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    timeTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:timeTipLabel];
    
    _workTimeTextField = [[UITextField alloc]initWithFrame:CGRectMake(timeTipLabel.frame.origin.x, timeTipLabel.frame.size.height+timeTipLabel.frame.origin.y, timeTipLabel.frame.size.width, 40)];
    _workTimeTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _workTimeTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _workTimeTextField.layer.borderWidth = 1.0f;
    [_workTimeTextField setBorderStyle:UITextBorderStyleLine];
    _workTimeTextField.placeholder = @"--请选择--";
    _workTimeTextField.delegate = self;
    _workTimeTextField.tag = 116;
    _workTimeTextField.textAlignment = NSTextAlignmentCenter;
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _workTimeTextField.leftView = sexView;
    _workTimeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_workTimeTextField];
    
    
    UILabel *placeTipLabel = [[UILabel alloc]init];
    placeTipLabel.frame = CGRectMake(_workTimeTextField.frame.origin.x,_workTimeTextField.frame.size.height+_workTimeTextField.frame.origin.y +20, _workTimeTextField.frame.size.width, 35);
    placeTipLabel.text = @"你的月薪在什么范围？";
    placeTipLabel.font =[UIFont fontWithName:@"Helvetica" size:15];
    placeTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [self.view addSubview:placeTipLabel];
    
    _workPalceTextField = [[UITextField alloc]initWithFrame:CGRectMake(placeTipLabel.frame.origin.x, placeTipLabel.frame.size.height+placeTipLabel.frame.origin.y, placeTipLabel.frame.size.width, 40)];
    _workPalceTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _workPalceTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _workPalceTextField.layer.borderWidth = 1.0f;
    [_workPalceTextField setBorderStyle:UITextBorderStyleLine];
    _workPalceTextField.placeholder = @"--请选择--";
    _workPalceTextField.delegate = self;
    _workPalceTextField.tag = 117;
    _workPalceTextField.textAlignment = NSTextAlignmentCenter;
    UIView *payView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _workPalceTextField.leftView = payView;
    _workPalceTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_workPalceTextField];
    
    
    UIButton *nextStepButton = [[UIButton alloc]init];
    nextStepButton.frame = CGRectMake(90, _workPalceTextField.frame.size.height+_workPalceTextField.frame.origin.y+80, WIDTH - 2*90, 40);
    [nextStepButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextStepButton.layer setMasksToBounds:YES];
    [nextStepButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [nextStepButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    nextStepButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    nextStepButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    nextStepButton.layer.borderWidth = 1.0f;
    [nextStepButton addTarget:self action:@selector(completeCreatResume) forControlEvents:UIControlEventTouchUpInside];
    nextStepButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nextStepButton];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSArray *loopArray = [[NSArray alloc]init];
    
    if(textField.tag == 116){

        loopArray =_workTimeArray;
        [_workTimeTextField resignFirstResponder];
        
    }else if (textField.tag ==117){
        
        loopArray = _workPlaceArray;
        [_workPalceTextField resignFirstResponder];
        
    }
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(nil, nil)];
    
    for (int i =0; i < loopArray.count; i++) {
        
        NSString *projectList = loopArray[i];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(projectList, nil)
                                  image:nil
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    
                                        if(textField.tag ==116){
                                        _workTimeTextField.text = loopArray[i];
                                        
                                    }else if(textField.tag ==117){
                                        _workPalceTextField.text = loopArray[i];
                                    }
                                    
                                }];
        
    }
    
    [actionSheet show];
    
}



#pragma mark -- 判断 公司 和 薪资 是否为空
-(void)completeCreatResume{
    
    if (_companyNameTextField.text.length>1) {
        
        [self createResume];
        
    }else{
        
//        [APIClient showMessage:@"公司名称和薪资范围不能为空"];
        [APIClient showInfo:nil title:@"公司名称"];
        
    }
    
}

#pragma mark -- 完成简历的创建
-(void)createResume{

   // NSLog(@"%@",@"取值发送给server");
    
    [APIClient showSuccess:@"简历创建成功" title:@"成功"];
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self presentViewController:mainVC animated:YES completion:nil];


//    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
//
//    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
//    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
//    [dic setObject:@"王小二" forKey:@"user_name"];
//    [dic setObject:@"男" forKey:@"user_sex"];
//    [dic setObject:@"21" forKey:@"user_age"];
//    [dic setObject:_positionNameString forKey:@"position"];
//    [dic setObject:_companyNameTextField.text forKey:@"company_name"];
//    [dic setObject:@"2" forKey:@"education_id"];
//    [dic setObject:@"2" forKey:@"user_compensation"];//薪资 id
//    
//    [Resume appCreatedResume:dic WithBlock:^(Resume *resume, Error *e) {
//        
//        if ([resume.res isEqualToString:@"1"]) {
//            
//            [APIClient showMessage:@"创建成功"];
//            
//            MainViewController *mainVC = [[MainViewController alloc]init];
//            [self presentViewController:mainVC animated:YES completion:nil];
//            
//        }else{
//            
//            [APIClient showMessage:e.info title:@"创建失败"];
//            
//        }
//        
//    }];

}

#pragma mark -- 隐藏键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_companyNameTextField resignFirstResponder];
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
