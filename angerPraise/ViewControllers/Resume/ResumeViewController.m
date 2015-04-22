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
#import "MBProgressHUD.h"
#import "ShareViewController.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(240, 240, 240, 1.0f);
    
    _titleMyResumeView = [[UIView alloc]init];
    _titleMyResumeView.frame = CGRectMake(0, 0, WIDTH, 120);
    _titleMyResumeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleMyResumeView];
    
    _positionNameLabel = [[UILabel alloc]init];
    _positionNameLabel.frame = CGRectMake(15, 20, 200, 40);
    _positionNameLabel.backgroundColor = [UIColor clearColor];
    _positionNameLabel.font =  [UIFont fontWithName:@"Helvetica" size:16.f];
    [_titleMyResumeView addSubview:_positionNameLabel];
    
    //竞争力
    _competitionNumberLabel = [[UILabel alloc]init];
    _competitionNumberLabel.frame = CGRectMake(_positionNameLabel.frame.size.width+15, _positionNameLabel.frame.origin.y, WIDTH-_positionNameLabel.frame.size.width-15, 40);
    _competitionNumberLabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
    _competitionNumberLabel.backgroundColor = [UIColor clearColor];
    [_titleMyResumeView addSubview:_competitionNumberLabel];
    
    _workPlaceLabel = [[UILabel alloc]init];
    _workPlaceLabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
    _workPlaceLabel.frame = CGRectMake(15, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y-10, 200, 40);
    _workPlaceLabel.backgroundColor = [UIColor clearColor];
    
    [_titleMyResumeView addSubview:_workPlaceLabel];
    
    _updateTimelabel = [[UILabel alloc]init];
    _updateTimelabel.frame = CGRectMake(_workPlaceLabel.frame.origin.x, _workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y-5, 200, 40);
    _updateTimelabel.font =  [UIFont fontWithName:@"Helvetica" size:14.f];
    _updateTimelabel.backgroundColor = [UIColor clearColor];
    [_titleMyResumeView addSubview:_updateTimelabel];
    //预览简历
    UIButton *previewResumeButton = [[UIButton alloc]init];
    previewResumeButton.frame = CGRectMake(_updateTimelabel.frame.size.width+_updateTimelabel.frame.origin.x-15, _updateTimelabel.frame.origin.y, 100, 35);
    [previewResumeButton setTitle:@"预览简历" forState:UIControlStateNormal];
    [previewResumeButton setTitleColor:RGBACOLOR(56, 199, 191, 1.0f) forState:UIControlStateNormal];
    previewResumeButton.backgroundColor = [UIColor clearColor];
    [previewResumeButton addTarget:self action:@selector(previewResume) forControlEvents:UIControlEventTouchUpInside];
    [_titleMyResumeView addSubview:previewResumeButton];
    
    //完善资料
    UIButton *perfectInfoButton= [[UIButton alloc]initWithFrame:CGRectMake(30,_titleMyResumeView.frame.origin.y+_titleMyResumeView.frame.size.height+230, self.view.frame.size.width-2*30, 45)];
    [perfectInfoButton.layer setMasksToBounds:YES];
    [perfectInfoButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [perfectInfoButton.layer setBorderWidth:1.0]; //边框宽度
    [perfectInfoButton addTarget:self action:@selector(perfectInfo) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 62, 143, 62, 1 });
    [perfectInfoButton.layer setBorderColor:colorref];//边框颜色
    [perfectInfoButton setTitle:@"完善资料" forState:UIControlStateNormal];
    perfectInfoButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    perfectInfoButton.backgroundColor = RGBACOLOR(0, 232, 221, 1.0f);
    [self.view addSubview:perfectInfoButton];
    
    //提高竞争力
    UIButton *improveCompetitivenessButton= [[UIButton alloc]initWithFrame:CGRectMake(30,perfectInfoButton.frame.origin.y+perfectInfoButton.frame.size.height+30, self.view.frame.size.width-2*30, 45)];
    [improveCompetitivenessButton.layer setMasksToBounds:YES];
    [improveCompetitivenessButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [improveCompetitivenessButton.layer setBorderWidth:1.0]; //边框宽度
    [improveCompetitivenessButton addTarget:self action:@selector(improveCompetitiveness) forControlEvents:UIControlEventTouchUpInside];
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 62, 143, 62, 1 });
    [improveCompetitivenessButton.layer setBorderColor:colorref2];//边框颜色
    [improveCompetitivenessButton setTitle:@"提高竞争力" forState:UIControlStateNormal];
    improveCompetitivenessButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    improveCompetitivenessButton.backgroundColor = RGBACOLOR(56, 199, 191, 1.0f);
    [self.view addSubview:improveCompetitivenessButton];
    
    
    [self getresumeInfo];
}

// 完善资料
-(void)perfectInfo{


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
    
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc]init];
    progressHUD.mode = MBProgressHUDModeDeterminate;
    [progressHUD show:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ResumeScore getResumeScoer:dic WithBlock:^(ResumeScore *resumeScoer, Error *e) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //NSLog(@"%@",resumeScoer);
        _positionNameLabel.text = resumeScoer.user_position;
        _competitionNumberLabel.text =[[NSString alloc] initWithFormat:@"竞争力: %@",resumeScoer.user_resume_competitiveness];
        
        _workPlaceLabel.text =[@"目标地: " stringByAppendingString:@"上海-徐汇"];
        
        _updateTimelabel.text =[@"最近更新: " stringByAppendingString:@"04-21"];
        _user_resume_synthesize_grade = resumeScoer.user_resume_synthesize_grade;

        [[NSUserDefaults standardUserDefaults]setObject:resumeScoer.resume_preview_url forKey:@"previewResumeUrl"];
        
        [self getRing];
    }];

}

// 加载圆环
-(void)getRing{

    CGRect goalBarFrame = CGRectMake((WIDTH-180)/2, _titleMyResumeView.frame.origin.y+_titleMyResumeView.frame.size.height+20, 180, 180);
    KDGoalBar *gb = [[KDGoalBar alloc] initWithFrame:goalBarFrame];
    percentGoalBar = gb;
    [gb setBarColor:RGBACOLOR(56, 199, 191, 1.0f)];
    [percentGoalBar setAllowDragging:YES];
    [percentGoalBar setAllowSwitching:NO];
    int myInt = [_user_resume_synthesize_grade intValue];
    [percentGoalBar setPercent:myInt
                      animated:YES];
    
    //percentGoalBar.customText =@"www";
    
    [self.view addSubview:percentGoalBar];

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
