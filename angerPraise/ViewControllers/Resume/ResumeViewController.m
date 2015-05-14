//
//  ResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ResumeViewController.h"
#import "ResumeScore.h"
#import "PreviewResumeViewController.h"
#import "SMS_MBProgressHUD.h"
#import "ShareViewController.h"


@interface ResumeViewController ()

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1.0f);
    
    _titleMyResumeView = [[UIView alloc]init];
    _titleMyResumeView.frame = CGRectMake(0, 0, WIDTH, 220);
    _titleMyResumeView.backgroundColor = RGBACOLOR(198, 199, 201, 1.f);
    [self.view addSubview:_titleMyResumeView];
    
    _positionNameLabel = [[UILabel alloc]init];
    _positionNameLabel.frame = CGRectMake(0, 30, WIDTH, 40);
    _positionNameLabel.backgroundColor = [UIColor clearColor];
    _positionNameLabel.font =  [UIFont fontWithName:@"Helvetica-BoldOblique" size:18.f];
    _positionNameLabel.textAlignment = NSTextAlignmentCenter;
    [_titleMyResumeView addSubview:_positionNameLabel];
    
    //竞争力
//    _competitionNumberLabel = [[UILabel alloc]init];
//    _competitionNumberLabel.frame = CGRectMake(_positionNameLabel.frame.size.width+15, _positionNameLabel.frame.origin.y, WIDTH-_positionNameLabel.frame.size.width-15, 40);
//    _competitionNumberLabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
//    _competitionNumberLabel.backgroundColor = [UIColor clearColor];
//    [_titleMyResumeView addSubview:_competitionNumberLabel];
    
    _workPlaceLabel = [[UILabel alloc]init];
    _workPlaceLabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
    _workPlaceLabel.frame = CGRectMake(0, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y-5, WIDTH, 25);
    _workPlaceLabel.textAlignment = NSTextAlignmentCenter;
    _workPlaceLabel.backgroundColor = [UIColor clearColor];
    [_titleMyResumeView addSubview:_workPlaceLabel];
    
    //预览简历
    UIButton *previewResumeButton = [[UIButton alloc]init];
    previewResumeButton.frame = CGRectMake(100,_workPlaceLabel.frame.origin.y+_workPlaceLabel.frame.size.height+40, WIDTH-2*100, 35);
    [previewResumeButton setTitle:@"预 览 简 历" forState:UIControlStateNormal];
    [previewResumeButton.layer setMasksToBounds:YES];
    [previewResumeButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [previewResumeButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    previewResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    previewResumeButton.backgroundColor = RGBACOLOR(75, 90, 248, 1.0f);
    [previewResumeButton addTarget:self action:@selector(previewResume) forControlEvents:UIControlEventTouchUpInside];
    [_titleMyResumeView addSubview:previewResumeButton];
    
    _updateTimelabel = [[UILabel alloc]init];
    _updateTimelabel.frame = CGRectMake(0, previewResumeButton.frame.size.height+previewResumeButton.frame.origin.y, WIDTH, 25);
    _updateTimelabel.textAlignment = NSTextAlignmentCenter;
    _updateTimelabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
    _updateTimelabel.backgroundColor = [UIColor clearColor];
    [_titleMyResumeView addSubview:_updateTimelabel];
    
    
    [self getresumeInfo];
}

// 完善资料
-(void)perfectInfo{
    
//    CFUUIDRef puuid = CFUUIDCreate( nil );
//    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );

    
}

//提高竞争力
-(void)improveCompetitiveness{

    ShareViewController *shareVC = [[ShareViewController alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];

}

//获取简历基本信息

-(void)getresumeInfo{

    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ResumeScore getResumeScoer:dic WithBlock:^(ResumeScore *resumeScoer, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        //NSLog(@"%@",resumeScoer);
        _positionNameLabel.text = resumeScoer.user_position;
//        _competitionNumberLabel.text =[[NSString alloc] initWithFormat:@"竞争力: %@",resumeScoer.user_resume_competitiveness];
        
        _workPlaceLabel.text =[@"工作地点: " stringByAppendingString:@"上海-徐汇"];
        
        _updateTimelabel.text =[@"更新时间: " stringByAppendingString:@"04-21"];
        _user_resume_synthesize_grade = resumeScoer.user_resume_synthesize_grade;

        [[NSUserDefaults standardUserDefaults]setObject:resumeScoer.resume_preview_url forKey:@"previewResumeUrl"];
        
        [self getRing];
    }];
}

// 加载圆环 以及其他按钮样式
-(void)getRing{

    CGRect goalBarFrame = CGRectMake((WIDTH-180)/2, _titleMyResumeView.frame.origin.y+_titleMyResumeView.frame.size.height+20, 180, 180);
    KDGoalBar *gb = [[KDGoalBar alloc] initWithFrame:goalBarFrame];
    percentGoalBar = gb;
    [gb setBarColor:RGBACOLOR(75, 90, 248, 1.0f)];
    [percentGoalBar setAllowDragging:YES];
    [percentGoalBar setAllowSwitching:NO];
    int myInt = [_user_resume_synthesize_grade intValue];
    [percentGoalBar setPercent:myInt
                      animated:YES];
    
    //percentGoalBar.customText =@"www";
    
    [self.view addSubview:percentGoalBar];
    
    UIButton *resumeScoreButton = [[UIButton alloc]init];
    resumeScoreButton.frame = CGRectMake(0, _titleMyResumeView.frame.size.height+_titleMyResumeView.frame.origin.y, WIDTH, 200);
    resumeScoreButton.backgroundColor = RGBACOLOR(70, 70, 70, 0.0f);
    [self.view addSubview:resumeScoreButton];
    
    //完善资料
    UIButton *perfectInfoButton = [[UIButton alloc]initWithFrame:CGRectMake(30,resumeScoreButton.frame.origin.y+resumeScoreButton.frame.size.height+10, 50, 60)];
    perfectInfoButton.backgroundColor = [UIColor clearColor];
    [perfectInfoButton setImage:[UIImage imageNamed:@"modifycv"] forState:UIControlStateNormal];
    [perfectInfoButton addTarget:self action:@selector(perfectInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:perfectInfoButton];
    
    //提高竞争力
    UIButton *improveCompetitivenessButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-2*50+20, perfectInfoButton.frame.origin.y, 50, 60)];
    improveCompetitivenessButton.backgroundColor = [UIColor clearColor];
    [improveCompetitivenessButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [improveCompetitivenessButton addTarget:self action:@selector(improveCompetitiveness) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:improveCompetitivenessButton];
    

}

//预览简历
-(void)previewResume{
    
    PreviewResumeViewController *previewResumeVC = [[PreviewResumeViewController alloc]init];
    [self.navigationController pushViewController:previewResumeVC animated:YES];
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
