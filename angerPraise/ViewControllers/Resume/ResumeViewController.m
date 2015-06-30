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
#import "ApIClient.h"
#import "ResumeScoreViewController.h"
#import "ImportResumeViewController.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =RGBACOLOR(20, 20, 20, 1.0f);
    
    _titleMyResumeView = [[UIView alloc]init];
    _titleMyResumeView.frame = CGRectMake(0, 0, WIDTH, HEIGHT*0.4);
    _titleMyResumeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleMyResumeView];
    
    _positionNameLabel = [[UILabel alloc]init];
    _positionNameLabel.frame = CGRectMake(0, 30, WIDTH, 40);
    _positionNameLabel.backgroundColor = [UIColor clearColor];
    _positionNameLabel.font =  [UIFont fontWithName:@"Helvetica-BoldOblique" size:18.f];
    _positionNameLabel.textAlignment = NSTextAlignmentCenter;
    [_titleMyResumeView addSubview:_positionNameLabel];
    
    _workPlaceLabel = [[UILabel alloc]init];
    _workPlaceLabel.font =  [UIFont fontWithName:@"Helvetica" size:12.f];
    _workPlaceLabel.frame = CGRectMake(0, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y-5, WIDTH, 25);
    _workPlaceLabel.textAlignment = NSTextAlignmentCenter;
    _workPlaceLabel.textColor = RGBACOLOR(177, 179, 180, 1.0f);
    _workPlaceLabel.backgroundColor = [UIColor clearColor];
    [_titleMyResumeView addSubview:_workPlaceLabel];
    
    //预览简历
    _previewResumeButton = [[UIButton alloc]init];
    _previewResumeButton.frame = CGRectMake(80,_workPlaceLabel.frame.origin.y+_workPlaceLabel.frame.size.height+40, WIDTH-2*80, 40);
    [_previewResumeButton setTitle:@"预 览 简 历" forState:UIControlStateNormal];
    [_previewResumeButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateHighlighted];
    [_previewResumeButton.layer setMasksToBounds:YES];
    [_previewResumeButton.layer setCornerRadius:40/2.f]; //设置矩形四个圆角半径
    [_previewResumeButton setTitleColor:RGBACOLOR(0, 203, 251, 1.0f) forState:UIControlStateNormal];
    _previewResumeButton.layer.borderWidth = 1.0f;
    _previewResumeButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    _previewResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    [_previewResumeButton addTarget:self action:@selector(previewResume) forControlEvents:UIControlEventTouchUpInside];
    [_titleMyResumeView addSubview:_previewResumeButton];
    
    _updateTimelabel = [[UILabel alloc]init];
    _updateTimelabel.frame = CGRectMake(0, _previewResumeButton.frame.size.height+_previewResumeButton.frame.origin.y, WIDTH, 25);
    _updateTimelabel.textAlignment = NSTextAlignmentCenter;
    _updateTimelabel.font =  [UIFont fontWithName:@"Helvetica" size:12.f];
    _updateTimelabel.backgroundColor = [UIColor clearColor];
    _updateTimelabel.textColor = RGBACOLOR(177, 179, 180, 1.0f);
    [_titleMyResumeView addSubview:_updateTimelabel];
    
    
    [self getresumeInfo];
    
}


//获取简历基本信息
-(void)getresumeInfo{

    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ResumeScore getResumeScoer:dic WithBlock:^(ResumeScore *resumeScoer, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        int errorCode = [e.code intValue];
        if (errorCode ==40004) {
            
            [APIClient showInfo:e.info title:@"提示"];
            ImportResumeViewController *importResumeVC = [[ImportResumeViewController alloc]init];
            [self.navigationController pushViewController:importResumeVC animated:YES];
            
        }
        if(resumeScoer.user_position !=nil){
            
            //NSLog(@"%@",resumeScoer);
            _positionNameLabel.text = resumeScoer.user_position;
            //        _competitionNumberLabel.text =[[NSString alloc] initWithFormat:@"竞争力: %@",resumeScoer.user_resume_competitiveness];
            
            _workPlaceLabel.text =[@"工作地点: " stringByAppendingString:resumeScoer.live];
            
            _updateTimelabel.text =[@"更新时间: " stringByAppendingString:resumeScoer.resume_update_time];
            _user_resume_synthesize_grade = resumeScoer.user_resume_synthesize_grade;
            
            _resume_preview_url = resumeScoer.resume_preview_url;
            
            [self getRing];

        }
            
    }];
}

// 加载圆环 以及其他按钮样式
-(void)getRing{

    CGRect goalBarFrame = CGRectMake((WIDTH-418/2)/2, _titleMyResumeView.frame.origin.y+_titleMyResumeView.frame.size.height+35, 418/2+1, 418/2);
    KDGoalBar *gb = [[KDGoalBar alloc] initWithFrame:goalBarFrame];
    percentGoalBar = gb;
    [gb setBarColor:RGBACOLOR(0, 203, 251, 1.0f)];
    gb.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"0score_bg"]];
    [percentGoalBar setAllowDragging:YES];
    [percentGoalBar setAllowSwitching:NO];
    int myInt = [_user_resume_synthesize_grade intValue];
    [percentGoalBar setPercent:myInt
                      animated:YES];
    
    //percentGoalBar.customText =@"www";
    
    [self.view addSubview:percentGoalBar];
    
    UIButton *resumeScoreButton = [[UIButton alloc]init];
    resumeScoreButton.frame = goalBarFrame;
    //resumeScoreButton.backgroundColor = [UIColor yellowColor];
   // [resumeScoreButton addTarget:self action:@selector(lookResumeScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeScoreButton];
    
//    //完善资料
//    UIButton *perfectInfoButton = [[UIButton alloc]initWithFrame:CGRectMake(30,resumeScoreButton.frame.origin.y+resumeScoreButton.frame.size.height+10, 50, 60)];
//    perfectInfoButton.backgroundColor = [UIColor clearColor];
//    [perfectInfoButton setImage:[UIImage imageNamed:@"modifycv"] forState:UIControlStateNormal];
//    [perfectInfoButton addTarget:self action:@selector(perfectInfo) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:perfectInfoButton];
//    
//    //提高竞争力
//    UIButton *improveCompetitivenessButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-2*50+20, perfectInfoButton.frame.origin.y, 50, 60)];
//    improveCompetitivenessButton.backgroundColor = [UIColor clearColor];
//    [improveCompetitivenessButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [improveCompetitivenessButton addTarget:self action:@selector(improveCompetitiveness) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:improveCompetitivenessButton];
    

}


//预览简历
-(void)previewResume{
    
    PreviewResumeViewController *previewResumeVC = [[PreviewResumeViewController alloc]init];
    previewResumeVC.resumePreviewUrl = _resume_preview_url;
    [self.navigationController pushViewController:previewResumeVC animated:YES];
}

// 查看简历综合评分
//-(void)lookResumeScore{
//
//    ResumeScoreViewController *resumeScoreVC = [[ResumeScoreViewController alloc]init];
//    [self.navigationController pushViewController:resumeScoreVC animated:YES];
//    
//}


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
