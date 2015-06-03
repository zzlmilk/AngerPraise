//
//  MarkViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ShareViewController.h"
#import "NeedDataViewController.h"
#import "UserViewController.h"


@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UILabel *guidePerfectLabel= [[UILabel alloc]initWithFrame:CGRectMake(30,90,WIDTH-2*30, 100)];
    [guidePerfectLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    guidePerfectLabel.backgroundColor = [UIColor clearColor];
    guidePerfectLabel.text=@"分享给朋友或朋友圈，邀请他们对自己分享的问卷点评可以提高竞争力和综合评分!";
    guidePerfectLabel.numberOfLines = 0;
    guidePerfectLabel.textAlignment = NSTextAlignmentCenter;
    guidePerfectLabel.textColor = RGBACOLOR(77, 77, 77, 1.0f);
    [self.view addSubview:guidePerfectLabel];
    
    
    UILabel *introduceLabel= [[UILabel alloc]initWithFrame:CGRectMake(80,guidePerfectLabel.frame.origin.y+guidePerfectLabel.frame.size.height-20,WIDTH-2*80, 100)];
    [introduceLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    introduceLabel.backgroundColor = [UIColor clearColor];
    introduceLabel.text=@"我们会给出专业的问卷评测,可以邀请好友来点评";
    introduceLabel.numberOfLines = 0;
    introduceLabel.textAlignment = NSTextAlignmentCenter;
    introduceLabel.textColor = RGBACOLOR(135, 135, 135, 1.0f);
    [self.view addSubview:introduceLabel];
    
    UIButton *inviteButton = [[UIButton alloc]init];
    inviteButton.frame = CGRectMake(introduceLabel.frame.origin.x, introduceLabel.frame.origin.y + introduceLabel.frame.size.height+100,WIDTH-2*introduceLabel.frame.origin.x, 40);
    [inviteButton setTitle:@"去 分 享" forState:UIControlStateNormal];
    [inviteButton.layer setMasksToBounds:YES];
    [inviteButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inviteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    inviteButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [inviteButton addTarget:self action:@selector(inviteFriend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inviteButton];
    
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 去分享
-(void)inviteFriend{

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
