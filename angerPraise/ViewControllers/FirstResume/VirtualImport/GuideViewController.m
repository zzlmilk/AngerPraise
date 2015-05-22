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
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIImageView *bgView= [[UIImageView alloc]init];
    bgView.frame = CGRectMake(150/2, 0, WIDTH-150, HEIGHT);
    [bgView setImage:[UIImage imageNamed:@"0guide"]];
    [self.view addSubview:bgView];
    
    
    UIButton *virtualButton = [[UIButton alloc]initWithFrame:CGRectMake(100, HEIGHT-140, WIDTH-2*100, 70)];
    [virtualButton.layer setMasksToBounds:YES];
    [virtualButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [virtualButton.layer setBorderWidth:1.0]; //边框宽度
    [virtualButton addTarget:self action:@selector(virtualImport) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 62, 143, 62, 1 });
    [virtualButton.layer setBorderColor:colorref];//边框颜色
    [self.view addSubview:virtualButton];
    
}

#pragma mark -- 返回
-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 虚拟投递
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
