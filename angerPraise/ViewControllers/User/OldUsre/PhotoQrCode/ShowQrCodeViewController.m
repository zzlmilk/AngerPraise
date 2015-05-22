//
//  ShowQrCodeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/6.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ShowQrCodeViewController.h"
#import "SMS_MBProgressHUD.h"
#import "ApIClient.h"
#import "Sweep.h"
#import "UIImageView+AFNetworking.h"

@interface ShowQrCodeViewController ()

@end

@implementation ShowQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMyQrCode];
    
    self.view.backgroundColor = RGBACOLOR(100, 100, 100, 1.0f);
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    
    UIView *qrView = [[UIView alloc]init];
    qrView.frame = CGRectMake(20, 80, WIDTH-2*20, HEIGHT-80-50);
    qrView.backgroundColor = RGBACOLOR(250, 250, 250, 1.0f);
    qrView.layer.cornerRadius = 5.f;
    [self.view addSubview:qrView];
    
    
    _qrImageView = [[UIImageView alloc]init];
    _qrImageView.frame = CGRectMake((qrView.frame.size.width-180)/2, 100, 180, 180);
    _qrImageView.layer.cornerRadius = 5.f;
    [qrView addSubview:_qrImageView];
    
    
    UILabel *tiplabel = [[UILabel alloc]init];
    tiplabel.frame = CGRectMake(0, _qrImageView.frame.size.height+_qrImageView.frame.origin.y+80, qrView.frame.size.width, 35);
    tiplabel.backgroundColor = [UIColor clearColor];
    tiplabel.text = @"扫一扫上面的二维码图案，查看我的简历";
    tiplabel.textAlignment = NSTextAlignmentCenter;
    tiplabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    tiplabel.textColor = RGBACOLOR(90, 90, 90, 1.0f);
    [qrView addSubview:tiplabel];
    
}


// 查看我的二维码
-(void)getMyQrCode{
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Sweep getUserQrCode:dic WithBlock:^(Sweep *sweep, Error *e) {
       
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (e.info == nil) {
            
            [_qrImageView setImageWithURL:[NSURL URLWithString:sweep.qrCodeUrl]];
            
        }else{

            [APIClient showInfo:e.info title:@"提示"];
            
        }
        
    }];
    
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
