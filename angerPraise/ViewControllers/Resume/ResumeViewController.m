//
//  ResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ResumeViewController.h"
#import "Resume.h"
#import "PreviewResumeViewController.h"
#import "SMS_MBProgressHUD.h"
#import "ApIClient.h"
#import "ImportResumeViewController.h"
#import "QAResumeViewController.h"
#import "PerfectResumeViewController.h"
#import "WXApi.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =RGBACOLOR(20, 20, 20, 1.0f);
    
    _titleMyResumeView = [[UIView alloc]init];
    _titleMyResumeView.frame = CGRectMake(0, 0, WIDTH, HEIGHT*0.5);
    _titleMyResumeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleMyResumeView];
    
    // 有简历的View
    _resumeView = [[UIView alloc]init];
    _resumeView.frame = CGRectMake(0, _titleMyResumeView.frame.size.height, WIDTH, HEIGHT-_titleMyResumeView.frame.size.height);
    _resumeView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    _resumeView.hidden = YES;
    [self.view addSubview:_resumeView];
    
    //没有简历的View
    _noResumeView = [[UIView alloc]init];
    _noResumeView.frame = CGRectMake(0, _titleMyResumeView.frame.size.height, WIDTH, HEIGHT-_titleMyResumeView.frame.size.height);
    _noResumeView.backgroundColor = RGBACOLOR(20, 20, 20, 20);
    [self.view addSubview:_noResumeView];
    
    
    UILabel *positionTitleLabel = [[UILabel alloc]init];
    positionTitleLabel.frame = CGRectMake(10, 25, WIDTH*0.55, 15);
    positionTitleLabel.text = @"职位信息";
    positionTitleLabel.textColor = hl_gary;
    positionTitleLabel.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    positionTitleLabel.backgroundColor = [UIColor clearColor];
    [_resumeView addSubview:positionTitleLabel];
    
    _positionNameLabel = [[UILabel alloc]init];
    _positionNameLabel.frame = CGRectMake(10, positionTitleLabel.frame.size.height+positionTitleLabel.frame.origin.y-2, positionTitleLabel.frame.size.width, 20);
    _positionNameLabel.backgroundColor = [UIColor clearColor];
    _positionNameLabel.font =  [UIFont fontWithName:@"Helvetica-BoldOblique" size:16.f];
    _positionNameLabel.textColor = [UIColor whiteColor];
    _positionNameLabel.text = @"软件工程师";
    [_resumeView addSubview:_positionNameLabel];
    
    
    UILabel *hopePositionTitleLabel = [[UILabel alloc]init];
    hopePositionTitleLabel.frame = CGRectMake(10, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y+20, WIDTH*0.55, 15);
    hopePositionTitleLabel.text = @"目标职位";
    hopePositionTitleLabel.textColor = hl_gary;
    hopePositionTitleLabel.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    hopePositionTitleLabel.backgroundColor = [UIColor clearColor];
    [_resumeView addSubview:hopePositionTitleLabel];
    
    _hopePositionNameLabel = [[UILabel alloc]init];
    _hopePositionNameLabel.frame = CGRectMake(10, hopePositionTitleLabel.frame.size.height+hopePositionTitleLabel.frame.origin.y-2, hopePositionTitleLabel.frame.size.width, 20);
    _hopePositionNameLabel.backgroundColor = [UIColor clearColor];
    _hopePositionNameLabel.font =  [UIFont fontWithName:@"Helvetica" size:16.f];
    _hopePositionNameLabel.textColor = [UIColor whiteColor];
    _hopePositionNameLabel.text = @"软件工程师";
    [_resumeView addSubview:_hopePositionNameLabel];
    
    
    UILabel *hopeMoneyTitleLabel = [[UILabel alloc]init];
    hopeMoneyTitleLabel.frame = CGRectMake(10, _hopePositionNameLabel.frame.size.height+_hopePositionNameLabel.frame.origin.y+20, WIDTH*0.55, 15);
    hopeMoneyTitleLabel.text = @"期望薪资";
    hopeMoneyTitleLabel.textColor = hl_gary;
    hopeMoneyTitleLabel.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    hopeMoneyTitleLabel.backgroundColor = [UIColor clearColor];
    [_resumeView addSubview:hopeMoneyTitleLabel];
    
    _hopeMoneyNameLabel = [[UILabel alloc]init];
    _hopeMoneyNameLabel.frame = CGRectMake(10, hopeMoneyTitleLabel.frame.size.height+hopeMoneyTitleLabel.frame.origin.y-2, hopeMoneyTitleLabel.frame.size.width, 25);
    _hopeMoneyNameLabel.backgroundColor = [UIColor clearColor];
    _hopeMoneyNameLabel.font =  [UIFont fontWithName:@"Helvetica" size:16.f];
    _hopeMoneyNameLabel.text = @"1000K/年";
    _hopeMoneyNameLabel.textColor = [UIColor whiteColor];
    [_resumeView addSubview:_hopeMoneyNameLabel];
    
    
    _updateTimelabel = [[UILabel alloc]init];
    _updateTimelabel.frame = CGRectMake(10, _hopeMoneyNameLabel.frame.size.height+_hopeMoneyNameLabel.frame.origin.y+35, _hopeMoneyNameLabel.frame.size.width, 15);
    _updateTimelabel.textColor = hl_gary;
    _updateTimelabel.font =  [UIFont fontWithName:@"Helvetica" size:11.f];
    _updateTimelabel.text = @" 更新时间 2015-7-6";
    [_resumeView addSubview:_updateTimelabel];
    
    
    //完善简历
    _perfectResumeButton = [[UIButton alloc]init];
    _perfectResumeButton.frame = CGRectMake(_positionNameLabel.frame.size.width+_positionNameLabel.frame.origin.x,positionTitleLabel.frame.origin.y, WIDTH-_positionNameLabel.frame.size.width-_positionNameLabel.frame.origin.x-10, 35);
    [_perfectResumeButton.layer setMasksToBounds:YES];
    [_perfectResumeButton.layer setCornerRadius:35/2.f]; //设置矩形四个圆角半径
    [_perfectResumeButton.layer setBorderWidth:1.0]; //边框宽度
    _perfectResumeButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [_perfectResumeButton setTitle:@"  完善简历" forState:UIControlStateNormal];
    [_perfectResumeButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [_perfectResumeButton setImage:[UIImage imageNamed:@"0pencil"] forState:UIControlStateNormal];
    [_perfectResumeButton setTitleColor:hl_gary forState:UIControlStateHighlighted];
    _perfectResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    _perfectResumeButton.backgroundColor = [UIColor clearColor];
    [_perfectResumeButton addTarget:self action:@selector(perfectResume) forControlEvents:UIControlEventTouchUpInside];
    [_resumeView addSubview:_perfectResumeButton];
    
    
    //预览简历
    _previewResumeButton = [[UIButton alloc]init];
    _previewResumeButton.frame = CGRectMake(_perfectResumeButton.frame.origin.x,_perfectResumeButton.frame.origin.y+_perfectResumeButton.frame.size.height+70, _perfectResumeButton.frame.size.width, 35);
    [_previewResumeButton.layer setMasksToBounds:YES];
    [_previewResumeButton.layer setCornerRadius:35/2.f]; //设置矩形四个圆角半径
    [_previewResumeButton.layer setBorderWidth:1.0]; //边框宽度
    _previewResumeButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [_previewResumeButton setTitle:@"  预览简历" forState:UIControlStateNormal];
    [_previewResumeButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [_previewResumeButton setImage:[UIImage imageNamed:@"0preview"] forState:UIControlStateNormal];
    [_previewResumeButton setTitleColor:hl_gary forState:UIControlStateHighlighted];
    _previewResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    _previewResumeButton.backgroundColor = [UIColor clearColor];
    [_previewResumeButton addTarget:self action:@selector(previewResume) forControlEvents:UIControlEventTouchUpInside];
    [_resumeView addSubview:_previewResumeButton];
    
    
    //没有简历的View
    UILabel *describeLabel1= [[UILabel alloc]init];
    describeLabel1.frame = CGRectMake(0, 30, WIDTH, 15);
    describeLabel1.text = @"您目前还没有简历哦,";
    describeLabel1.textColor = hl_gary;
    describeLabel1.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    describeLabel1.textAlignment = NSTextAlignmentCenter;
    [_noResumeView addSubview:describeLabel1];
    
    UILabel *describeLabel2= [[UILabel alloc]init];
    describeLabel2.frame = CGRectMake(0, describeLabel1.frame.size.height+describeLabel1.frame.origin.y, WIDTH, 15);
    describeLabel2.text = @"快快创建个人简历吧!";
    describeLabel2.textColor = hl_gary;
    describeLabel2.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    describeLabel2.textAlignment = NSTextAlignmentCenter;
    [_noResumeView addSubview:describeLabel2];
    
    UILabel *describeLabel3= [[UILabel alloc]init];
    describeLabel3.frame = CGRectMake(0, describeLabel2.frame.size.height+describeLabel2.frame.origin.y, WIDTH, 15);
    describeLabel3.text = @"您将获得更好的职位!";
    describeLabel3.textColor = hl_gary;
    describeLabel3.font =[UIFont fontWithName:@"Helvetica" size:11.f];
    describeLabel3.textAlignment = NSTextAlignmentCenter;
    [_noResumeView addSubview:describeLabel3];
    
    UIButton *creatResumeButton= [[UIButton alloc]initWithFrame:CGRectMake(60,describeLabel3.frame.origin.y+describeLabel3.frame.size.height+38,WIDTH-2*60,38)];
    [creatResumeButton.layer setMasksToBounds:YES];
    [creatResumeButton.layer setCornerRadius:38/2.f]; //设置矩形四个圆角半径
    [creatResumeButton.layer setBorderWidth:1.0]; //边框宽度
    creatResumeButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [creatResumeButton setTitle:@"   创 建 简 历" forState:UIControlStateNormal];
    [creatResumeButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [creatResumeButton setImage:[UIImage imageNamed:@"0pencil"] forState:UIControlStateNormal];
    [creatResumeButton setTitleColor:btnNormalColor forState:UIControlStateHighlighted];
    creatResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    creatResumeButton.backgroundColor = [UIColor clearColor];
    [creatResumeButton addTarget:self action:@selector(creatResume) forControlEvents:UIControlEventTouchUpInside];
    [_noResumeView addSubview:creatResumeButton];
    
    [self getRing];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


//获取简历基本信息
-(void)loadData{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [Resume getResumeScoer:dic WithBlock:^(Resume *resume, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];

        if (e.info!=nil) {
            
            [APIClient showInfo:e.info title:@"提示"];
            
        }
        
        if(resume.user_position !=nil){
            
            _positionNameLabel.text = resume.user_position;
            
            _hopeMoneyNameLabel.text = resume.compensation_name;
            
            _hopePositionNameLabel.text = resume.objective_functions;
            
            _updateTimelabel.text = [@"更新时间: " stringByAppendingString:resume.resume_update_time];
            _user_resume_synthesize_grade = resume.user_resume_synthesize_grade;
            
            _resumeStatus = resume.resume_status;
        }
        
        if (resume.resume_status) {// 有简历
            
            _noResumeView.hidden = YES;
            _resumeView.hidden= NO;
        }
        
        int myInt = [_user_resume_synthesize_grade intValue];
        [percentGoalBar setPercent:myInt animated:YES];
        
    }];
}


// 加载圆环 以及其他按钮样式
-(void)getRing{

    CGRect goalBarFrame = CGRectMake((WIDTH-310/2)/2, 30, 310/2+1, 310/2);
    KDGoalBar *gb = [[KDGoalBar alloc] initWithFrame:goalBarFrame];
    percentGoalBar = gb;
    [gb setBarColor:RGBACOLOR(0, 203, 251, 1.0f)];
    gb.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"0score_bg1"]];
    [percentGoalBar setAllowDragging:YES];
    [percentGoalBar setAllowSwitching:NO];
    int myInt = [_user_resume_synthesize_grade intValue];
    [percentGoalBar setPercent:myInt animated:YES];
    
    [self.view addSubview:percentGoalBar];
    //给综合评分添加按钮事件
    UIButton *resumeScoreButton = [[UIButton alloc]init];
    resumeScoreButton.frame = goalBarFrame;
    resumeScoreButton.backgroundColor = [UIColor clearColor];
    [resumeScoreButton addTarget:self action:@selector(lookResumeScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeScoreButton];
    
    
    _shareResumeButton= [[UIButton alloc]initWithFrame:CGRectMake(60,goalBarFrame.origin.y+goalBarFrame.size.height+28,WIDTH-2*60,35)];
    [_shareResumeButton.layer setMasksToBounds:YES];
    [_shareResumeButton.layer setCornerRadius:35/2.f]; //设置矩形四个圆角半径
    [_shareResumeButton.layer setBorderWidth:1.0]; //边框宽度
    _shareResumeButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [_shareResumeButton setTitle:@"   分 享 简 历" forState:UIControlStateNormal];
    [_shareResumeButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [_shareResumeButton setImage:[UIImage imageNamed:@"0share"] forState:UIControlStateNormal];
    [_shareResumeButton setTitleColor:btnNormalColor forState:UIControlStateHighlighted];
//    _shareResumeButton.enabled = NO;
    _shareResumeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    _shareResumeButton.backgroundColor = [UIColor clearColor];
    [_shareResumeButton addTarget:self action:@selector(shareResume) forControlEvents:UIControlEventTouchUpInside];
    [_titleMyResumeView addSubview:_shareResumeButton];
    
}

//完善简历
-(void)perfectResume{
    
    PerfectResumeViewController *perfectResumeVC = [[PerfectResumeViewController alloc]init];
    [self.navigationController pushViewController:perfectResumeVC animated:YES];
}

//预览简历
-(void)previewResume{
    
    PreviewResumeViewController *previewResumeVC = [[PreviewResumeViewController alloc]init];
    [self.navigationController pushViewController:previewResumeVC animated:YES];
}

//创建简历
-(void)creatResume{
    
    QAResumeViewController *qAResumeVC = [[QAResumeViewController alloc]init];
    [self.navigationController pushViewController:qAResumeVC animated:YES];
}

#pragma mark - 改变发送通道 微信 or 朋友圈
-(void) changeScene:(NSInteger)scene
{
    _scene = scene;
}

//分享简历
#pragma mark - 通过 微信 发送链接
-(void)shareResume{
    
    if (_resumeStatus) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];
        
        [Resume previewResume:dic WithBlock:^(Resume *resume, Error *e) {
            
            if (e.info !=nil) {
                
                [APIClient showMessage:e.info];
                
            }
            if (resume.resume_preview_url) {
                
                [self shareResumeByWeiXin:resume.resume_preview_url];
            }
        }];

        
    }else{
    
        [APIClient showMessage:@"没有发现你的简历信息，赶快创建简历吧~"];
    }
    
}

-(void)shareResumeByWeiXin:(NSString *)url{

    [self changeScene:WXSceneSession];
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"怒赞简历";
    message.description = nil;
    [message setThumbImage:[UIImage imageNamed:@"Icon"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    message.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];

    
}
//提示用户 分享View
-(void)lookResumeScore{

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
