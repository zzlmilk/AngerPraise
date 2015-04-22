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

#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UILabel *integrityScoreTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(30, 90, 145, 40)];
    integrityScoreTitleLabel.backgroundColor = [UIColor clearColor];
    integrityScoreTitleLabel.text=@"简历的完整度:";
    integrityScoreTitleLabel.textColor = RGBACOLOR(76, 63, 55, 1.0f);
    [self.view addSubview:integrityScoreTitleLabel];
    
    UILabel *integrityScoreLabel= [[UILabel alloc]initWithFrame:CGRectMake(integrityScoreTitleLabel.frame.size.width+integrityScoreTitleLabel.frame.origin.x, integrityScoreTitleLabel.frame.origin.y, 100, 40)];
    integrityScoreLabel.backgroundColor = [UIColor clearColor];
    integrityScoreLabel.text=@"偏低";
    integrityScoreLabel.textColor = RGBACOLOR(52, 46, 48, 1.0f);
    [integrityScoreLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18]];
    [self.view addSubview:integrityScoreLabel];
    
    
    UILabel *qualityScoreTitleLabel= [[UILabel alloc]initWithFrame:CGRectMake(30, integrityScoreTitleLabel.frame.size.height+integrityScoreTitleLabel.frame.origin.y, 145, 40)];
    qualityScoreTitleLabel.backgroundColor = [UIColor clearColor];
    qualityScoreTitleLabel.text=@"简历的质量度:";
    qualityScoreTitleLabel.textColor = RGBACOLOR(76, 63, 55, 1.0f);
    [self.view addSubview:qualityScoreTitleLabel];
    
    UILabel *qualityScoreLabel= [[UILabel alloc]initWithFrame:CGRectMake(integrityScoreTitleLabel.frame.size.width+integrityScoreTitleLabel.frame.origin.x, qualityScoreTitleLabel.frame.origin.y, 100, 40)];
    qualityScoreLabel.backgroundColor = [UIColor clearColor];
    qualityScoreLabel.text=@"偏低";
    qualityScoreLabel.textColor = RGBACOLOR(52, 46, 48, 1.0f);
    [qualityScoreLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18]];
    [self.view addSubview:qualityScoreLabel];
    
    
    UILabel *guidePerfectLabel= [[UILabel alloc]initWithFrame:CGRectMake(qualityScoreTitleLabel.frame.origin.x, qualityScoreTitleLabel.frame.origin.y+qualityScoreTitleLabel.frame.size.height+20, self.view.frame.size.width - 2*qualityScoreTitleLabel.frame.origin.x, 150)];
    [guidePerfectLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    guidePerfectLabel.backgroundColor = [UIColor clearColor];
    guidePerfectLabel.text=@"由于您简历的完整度分数和质量度分数偏低, 不能更佳有效地帮助你进行简历推广, 我们已经为你'私人定制'出个性问卷帮助你提高简历竞争力,分享后立即生成问卷,朋友对你的问卷进行回答或点评便可提高简历竞争力,好友也可获得现金红包哦！";
    guidePerfectLabel.numberOfLines = 0;
    guidePerfectLabel.textColor = RGBACOLOR(77, 77, 77, 1.0f);
    [self.view addSubview:guidePerfectLabel];
    
    
    
    UIButton *inviteButton = [[UIButton alloc]initWithFrame:CGRectMake(guidePerfectLabel.frame.origin.x, guidePerfectLabel.frame.origin.y + guidePerfectLabel.frame.size.height+100,self.view.frame.size.width-2*guidePerfectLabel.frame.origin.x, 40)];
    [inviteButton.layer setMasksToBounds:YES];
    [inviteButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [inviteButton.layer setBorderWidth:1.0]; //边框宽度
    [inviteButton addTarget:self action:@selector(inviteFriend) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 211, 58, 59, 1 });
    [inviteButton.layer setBorderColor:colorref2];//边框颜色
    [inviteButton setTitle:@"去分享" forState:UIControlStateNormal];
    inviteButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    inviteButton.backgroundColor = RGBACOLOR(56, 199, 191, 1.0f);
    [self.view addSubview:inviteButton];
    
    
}

#pragma mark -- 去分享
-(void)inviteFriend{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"怒赞"
                                                  url:@"http://61.174.13.143/AngerPraiseWebs/weixin/test"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                }
                            }];

    

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
