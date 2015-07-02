//
//  IsHrViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/29.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "IsOrNoHrViewController.h"
#import "guideHrViewController.h"

@interface IsOrNoHrViewController ()

@end

@implementation IsOrNoHrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *amHrButton = [[UIButton alloc]init];
    amHrButton.frame = CGRectMake(100,350, WIDTH-2*100, 35);
    [amHrButton setTitle:@"我 是 HR" forState:UIControlStateNormal];
    [amHrButton.layer setMasksToBounds:YES];
    [amHrButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [amHrButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    amHrButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    amHrButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [amHrButton addTarget:self action:@selector(amHr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:amHrButton];
    
    
    UIButton *noHrButton = [[UIButton alloc]init];
    noHrButton.frame = CGRectMake(100,amHrButton.frame.size.height+amHrButton.frame.origin.y+30, WIDTH-2*100, 35);
    [noHrButton setTitle:@"不 是 HR" forState:UIControlStateNormal];
    [noHrButton.layer setMasksToBounds:YES];
    [noHrButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [noHrButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    noHrButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    noHrButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [noHrButton addTarget:self action:@selector(noHr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noHrButton];
    
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 是HR 引导开启HR特权
-(void)amHr{

    guideHrViewController *guideHrVC = [[guideHrViewController alloc]init];
    [self.navigationController pushViewController:guideHrVC animated:YES];
}

// 不是HR 暂时关闭HR特权 入口
-(void)noHr{
    
    
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
