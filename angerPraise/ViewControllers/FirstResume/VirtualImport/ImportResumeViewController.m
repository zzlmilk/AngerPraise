//
//  ImportResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ImportResumeViewController.h"
#import "CreatStep2ViewController.h"
#import "GuideViewController.h"
#import "MainViewController.h"
#import "QAResumeViewController.h"

@interface ImportResumeViewController ()

@end

@implementation ImportResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    //[backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn setEnabled:NO];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
//    UIImageView *setImageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-200)/2, 70, 200, 200)];
//    [setImageView setImage:[UIImage imageNamed:@"ic_recommend_douban"]];
//    [self.view addSubview:setImageView];
    
    UILabel *tip1Label = [[UILabel alloc]init];
    tip1Label.frame =CGRectMake(40, 100, WIDTH-2*40, 25);
    tip1Label.text = @"我们未发现你的个人职业信息";
    tip1Label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    tip1Label.textColor = [UIColor blackColor];
    tip1Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tip1Label];
    
    UILabel *tip2Label = [[UILabel alloc]init];
    tip2Label.frame =CGRectMake(40, tip1Label.frame.size.height+tip1Label.frame.origin.y+10, WIDTH-2*40, 25);
    tip2Label.text = @"我们无法推荐合适的职位信息给你";
    tip2Label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    tip2Label.textColor = [UIColor blackColor];
    tip2Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tip2Label];
    
    UILabel *tip3Label = [[UILabel alloc]init];
    tip3Label.frame =CGRectMake(40, tip2Label.frame.size.height+tip2Label.frame.origin.y+10, WIDTH-2*40, 25);
    tip3Label.text = @"可以通过问答式创建的方式来告诉我们你的职位信息";
    tip3Label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    tip3Label.textColor = [UIColor blackColor];
    tip3Label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tip3Label];
    
    
    
    
    UIButton *virtualButton = [[UIButton alloc]init];
    virtualButton.frame = CGRectMake(80, tip3Label.frame.size.height+tip3Label.frame.origin.y+80, WIDTH - 2*80, 40);
    [virtualButton setTitle:@"虚 拟 投 递" forState:UIControlStateNormal];
    [virtualButton.layer setMasksToBounds:YES];
    [virtualButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [virtualButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    virtualButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    virtualButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    virtualButton.layer.borderWidth = 1.0f;
    [virtualButton addTarget:self action:@selector(guideStatus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:virtualButton];
    
    
    UIButton *guideButton = [[UIButton alloc]init];
    guideButton.frame = CGRectMake(80, virtualButton.frame.size.height+virtualButton.frame.origin.y+40, WIDTH - 2*80, 40);
    [guideButton setTitle:@"问 答 式 创 建" forState:UIControlStateNormal];
    [guideButton.layer setMasksToBounds:YES];
    [guideButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [guideButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    guideButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    guideButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    guideButton.layer.borderWidth = 1.0f;
    [guideButton addTarget:self action:@selector(guideImport) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guideButton];
    
    
    UIButton *skipButton = [[UIButton alloc]init];
    skipButton.frame = CGRectMake(80, guideButton.frame.size.height+guideButton.frame.origin.y+40, WIDTH - 2*80, 40);
    [skipButton setTitle:@"跳 过" forState:UIControlStateNormal];
    [skipButton.layer setMasksToBounds:YES];
    [skipButton.layer setCornerRadius:40/2.0f]; //设置矩形四个圆角半径
    [skipButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    skipButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    skipButton.layer.borderColor = RGBACOLOR(0, 203, 251, 1.0f).CGColor;
    skipButton.layer.borderWidth = 1.0f;
    [skipButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipButton];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 虚拟投放
-(void)guideStatus{
    
    GuideViewController *guidelVC = [[GuideViewController alloc]init];
    [self.navigationController pushViewController:guidelVC animated:YES];
}

#pragma mark -- 问答式创建
-(void)guideImport{

    QAResumeViewController *qaResumeVC = [[QAResumeViewController alloc]init];
    [self.navigationController pushViewController:qaResumeVC animated:YES];
}

#pragma mark -- 跳过
-(void)skip{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainVC animated:YES];

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
