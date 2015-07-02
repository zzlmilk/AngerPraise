//
//  ResumeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ResumeScore.h"
#import "KDGoalBar.h"
#import "MainViewController.h"
#import "WXApiObject.h"

@interface ResumeViewController :UIViewController<TabBarItemSelectDelegate>{
    KDGoalBar *percentGoalBar;
    
    enum WXScene _scene;

}

@property(nonatomic,strong)UIView *titleMyResumeView;
@property(nonatomic,strong)UIView *resumeView;
@property(nonatomic,strong)UIView *noResumeView;


@property(nonatomic,strong)UILabel *positionNameLabel;
@property(nonatomic,strong)UILabel *hopePositionNameLabel;
@property(nonatomic,strong)UILabel *hopeMoneyNameLabel;
@property(nonatomic,strong)UILabel *updateTimelabel;
@property(nonatomic,strong)UIButton *previewResumeButton;
@property(nonatomic,strong)UIButton *perfectResumeButton;

@property(nonatomic,strong)NSString *user_resume_synthesize_grade;



//以下即将废弃

@property(nonatomic,strong)UILabel *workPlaceLabel;
@property(nonatomic,strong)UILabel *competitionNumberLabel;

@property(nonatomic,strong)NSString *resume_perfect_url;
@property(nonatomic,strong)NSString *resume_preview_url;
@property(nonatomic,strong)NSString *user_photo_url;
// 综合评分

-(void)loadData;


@end
