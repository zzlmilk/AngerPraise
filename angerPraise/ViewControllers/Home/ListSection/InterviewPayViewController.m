//
//  InterviewPayViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "InterviewPayViewController.h"
#import "InterviewPayWebViewController.h"

@interface InterviewPayViewController ()

@end

@implementation InterviewPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"13"]];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *interviewPayButton = [[UIButton alloc]init];
    interviewPayButton.frame = CGRectMake(0, 150, WIDTH, 35);
    [interviewPayButton addTarget:self action:@selector(interviewPay) forControlEvents:UIControlEventTouchUpInside];
    interviewPayButton.backgroundColor =  RGBACOLOR(75, 90, 248, 0.5f);
    [self.view addSubview:interviewPayButton];
    
}

-(void)interviewPay{

    InterviewPayWebViewController *InterviewPayWebVC = [[InterviewPayWebViewController alloc]init];
    [self.navigationController pushViewController:InterviewPayWebVC animated:YES];
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
