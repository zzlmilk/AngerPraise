//
//  MarkViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "MarkViewController.h"
#import "NeedDataViewController.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface MarkViewController ()

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    self.title = @"系统评分";
    
    UILabel *integrityScoreTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(30, 90, 100, 40)];
    integrityScoreTitleLabel.backgroundColor = [UIColor clearColor];
    integrityScoreTitleLabel.text=@"完整度分数:";
    integrityScoreTitleLabel.textColor = RGBACOLOR(76, 63, 55, 1.0f);
    [self.view addSubview:integrityScoreTitleLabel];
    
    UILabel *integrityScoreLabel= [[UILabel alloc]initWithFrame:CGRectMake(integrityScoreTitleLabel.frame.size.width+integrityScoreTitleLabel.frame.origin.x, integrityScoreTitleLabel.frame.origin.y, 100, 40)];
    integrityScoreLabel.backgroundColor = [UIColor clearColor];
    integrityScoreLabel.text=@"65";
    integrityScoreLabel.textColor = RGBACOLOR(52, 46, 48, 1.0f);
    [integrityScoreLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18]];
    [self.view addSubview:integrityScoreLabel];
    
    
    UILabel *qualityScoreTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(30, integrityScoreTitleLabel.frame.size.height+integrityScoreTitleLabel.frame.origin.y, 100, 40)];
    qualityScoreTitleLabel.backgroundColor = [UIColor clearColor];
    qualityScoreTitleLabel.text=@"质量度分数:";
    qualityScoreTitleLabel.textColor = RGBACOLOR(76, 63, 55, 1.0f);
    [self.view addSubview:qualityScoreTitleLabel];
    
    UILabel *qualityScoreLabel= [[UILabel alloc]initWithFrame:CGRectMake(integrityScoreTitleLabel.frame.size.width+integrityScoreTitleLabel.frame.origin.x, qualityScoreTitleLabel.frame.origin.y, 100, 40)];
    qualityScoreLabel.backgroundColor = [UIColor clearColor];
    qualityScoreLabel.text=@"52";
    qualityScoreLabel.textColor = RGBACOLOR(52, 46, 48, 1.0f);
    [qualityScoreLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18]];
    [self.view addSubview:qualityScoreLabel];
    
    
    UILabel *guidePerfectLabel= [[UILabel alloc]initWithFrame:CGRectMake(qualityScoreTitleLabel.frame.origin.x, qualityScoreTitleLabel.frame.origin.y+qualityScoreTitleLabel.frame.size.height+20, self.view.frame.size.width - 2*qualityScoreTitleLabel.frame.origin.x, 120)];
    [guidePerfectLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    guidePerfectLabel.backgroundColor = [UIColor clearColor];
    guidePerfectLabel.text=@"由于您简历的完整度分数和质量度分数偏低, 不能更佳有效地帮助你进行简历推广, 请进一步完善资料并邀请好友进行评价来获取更高的分数";
    guidePerfectLabel.numberOfLines = 0;
    guidePerfectLabel.textColor = RGBACOLOR(77, 77, 77, 1.0f);
    [self.view addSubview:guidePerfectLabel];
    
    
    UIButton *perfectButton = [[UIButton alloc]initWithFrame:CGRectMake(guidePerfectLabel.frame.origin.x, guidePerfectLabel.frame.origin.y + guidePerfectLabel.frame.size.height+45,self.view.frame.size.width-2*guidePerfectLabel.frame.origin.x, 40)];
    [perfectButton.layer setMasksToBounds:YES];
    [perfectButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [perfectButton.layer setBorderWidth:1.0]; //边框宽度
    [perfectButton addTarget:self action:@selector(perfectData) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 211, 58, 59, 1 });
    [perfectButton.layer setBorderColor:colorref];//边框颜色
    [perfectButton setTitle:@"完善资料" forState:UIControlStateNormal];
    perfectButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    perfectButton.backgroundColor = RGBACOLOR(235, 75, 66, 1.0f);
    [self.view addSubview:perfectButton];
    
    
    
    UIButton *inviteButton = [[UIButton alloc]initWithFrame:CGRectMake(perfectButton.frame.origin.x, perfectButton.frame.origin.y + perfectButton.frame.size.height+30,self.view.frame.size.width-2*perfectButton.frame.origin.x, 40)];
    [inviteButton.layer setMasksToBounds:YES];
    [inviteButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [inviteButton.layer setBorderWidth:1.0]; //边框宽度
    [inviteButton addTarget:self action:@selector(perfectData) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 211, 58, 59, 1 });
    [inviteButton.layer setBorderColor:colorref2];//边框颜色
    [inviteButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    inviteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    inviteButton.backgroundColor = RGBACOLOR(235, 75, 66, 1.0f);
    [self.view addSubview:inviteButton];
    
    
}

#pragma mark -- 用户登录
-(void)perfectData{

    NeedDataViewController *needData = [[NeedDataViewController alloc]init];
    [self.navigationController pushViewController:needData animated:YES];
    
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
