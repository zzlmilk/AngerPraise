//
//  guideHrViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/29.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "guideHrViewController.h"

@interface guideHrViewController ()

@end

@implementation guideHrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton *noHrButton = [[UIButton alloc]init];
    noHrButton.frame = CGRectMake(100,430, WIDTH-2*100, 35);
    [noHrButton setTitle:@"知 道 了" forState:UIControlStateNormal];
    [noHrButton.layer setMasksToBounds:YES];
    [noHrButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [noHrButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    noHrButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    noHrButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [noHrButton addTarget:self action:@selector(iKonw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noHrButton];
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)iKonw{

    
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
