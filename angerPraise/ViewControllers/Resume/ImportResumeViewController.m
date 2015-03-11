//
//  ImportResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ImportResumeViewController.h"
#import "VirtualImportViewController.h"
#import "GuideFillViewController.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ImportResumeViewController ()

@end

@implementation ImportResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"导入简历";
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    
    UIButton *virtualButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-2*30, 45)];
    [virtualButton.layer setMasksToBounds:YES];
    [virtualButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [virtualButton.layer setBorderWidth:1.0]; //边框宽度
    [virtualButton addTarget:self action:@selector(virtualImport) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 62, 143, 62, 1 });
    [virtualButton.layer setBorderColor:colorref];//边框颜色
    [virtualButton setTitle:@"虚拟投放" forState:UIControlStateNormal];
    virtualButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    virtualButton.backgroundColor = RGBACOLOR(70, 155, 70, 1.0f);
    [self.view addSubview:virtualButton];

    
    UIButton *guideButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 200+140, self.view.frame.size.width-2*30, 45)];
    [guideButton.layer setMasksToBounds:YES];
    [guideButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [guideButton.layer setBorderWidth:1.0]; //边框宽度
    [guideButton addTarget:self action:@selector(guideImport) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 40, 164, 201, 1 });
    [guideButton.layer setBorderColor:colorref2];//边框颜色
    [guideButton setTitle:@"引导填写" forState:UIControlStateNormal];
    guideButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    guideButton.backgroundColor = RGBACOLOR(72, 184, 218, 1.0f);
    [self.view addSubview:guideButton];

}

#pragma mark -- 虚拟投放
-(void)virtualImport{
    VirtualImportViewController *virtualVC = [[VirtualImportViewController alloc]init];
    [self.navigationController pushViewController:virtualVC animated:YES];
}

#pragma mark -- 引导填写
-(void)guideImport{

    GuideFillViewController *guideVC = [[GuideFillViewController alloc]init];
    [self.navigationController pushViewController:guideVC animated:YES];

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
