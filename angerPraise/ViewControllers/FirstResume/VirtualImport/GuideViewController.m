//
//  GuideViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "GuideViewController.h"
#import "VirtualImportViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *virtualButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, self.view.frame.size.width-2*30, 45)];
    [virtualButton.layer setMasksToBounds:YES];
    [virtualButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [virtualButton.layer setBorderWidth:1.0]; //边框宽度
    [virtualButton addTarget:self action:@selector(virtualImport) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 62, 143, 62, 1 });
    [virtualButton.layer setBorderColor:colorref];//边框颜色
    [virtualButton setTitle:@"下一步" forState:UIControlStateNormal];
    virtualButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    virtualButton.backgroundColor =  RGBACOLOR(68, 229, 220, 1.0f);
    [self.view addSubview:virtualButton];
    
}

#pragma mark -- 虚拟投放
-(void)virtualImport{
    
    VirtualImportViewController *virtualVC = [[VirtualImportViewController alloc]init];
    [self.navigationController pushViewController:virtualVC animated:YES];
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
