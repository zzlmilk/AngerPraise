//
//  CardView.m
//  angerPraise
//
//  Created by 单好坤 on 15/8/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CardView.h"

@implementation CardView

-(id)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];

    
    _userPhotoImageView = [[UIImageView alloc]init];
    [_userPhotoImageView setImage:[UIImage imageNamed:@"Icon"]];
    _userPhotoImageView.userInteractionEnabled = YES;
    _userPhotoImageView.backgroundColor = [UIColor clearColor];
    _userPhotoImageView.frame = CGRectMake((WIDTH-100)/2, 20, 100, 100);
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageView)];
    _userPhotoImageView.layer.masksToBounds = YES;
    _userPhotoImageView.layer.cornerRadius = 50;
//    [_userPhotoImageView addGestureRecognizer:singleTap];
    [self addSubview:_userPhotoImageView];
    
    _userNameButton = [[UIButton alloc]init];
    _userNameButton.frame =CGRectMake(100, _userPhotoImageView.frame.size.height+_userPhotoImageView.frame.origin.y+5, WIDTH-2*100, 35);
    [_userNameButton setTitle:@"Allen Zhu" forState:UIControlStateNormal];
    [_userNameButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [_userNameButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f) forState:UIControlStateHighlighted];
    _userNameButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _userNameButton.backgroundColor = [UIColor clearColor];
    _userNameButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
//    [_userNameButton addTarget:self action:@selector(showEditPersonInfoView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userNameButton];
    
    _hirelibNumberLabel = [[UILabel alloc]init];
    _hirelibNumberLabel.frame = CGRectMake(0, _userNameButton.frame.size.height+_userNameButton.frame.origin.y-5, WIDTH, 20);
    _hirelibNumberLabel.backgroundColor = [UIColor clearColor];
    _hirelibNumberLabel.text = @"hirelib No.000000";
    _hirelibNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_hirelibNumberLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    _hirelibNumberLabel.textColor = RGBACOLOR(82, 82, 82, 1.0f);
    [self addSubview:_hirelibNumberLabel];
    
    _matchPositionLabel = [[UILabel alloc]init];
    _matchPositionLabel.frame = CGRectMake(55, _hirelibNumberLabel.frame.origin.y+_hirelibNumberLabel.frame.size.height+12, WIDTH-2*50-10, 35);
    _matchPositionLabel.backgroundColor = [UIColor clearColor];
    _matchPositionLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _matchPositionLabel.text= @"0";
    _matchPositionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [self addSubview:_matchPositionLabel];
    
    UILabel *matchPositionTitleLabel = [[UILabel alloc]init];
    matchPositionTitleLabel.frame = CGRectMake(40, _matchPositionLabel.frame.origin.y+_matchPositionLabel.frame.size.height-12, WIDTH-2*40, 35);
    matchPositionTitleLabel.backgroundColor = [UIColor clearColor];
    matchPositionTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    matchPositionTitleLabel.text= @"剩余任务";
    matchPositionTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [self addSubview:matchPositionTitleLabel];
    
    _taskLabel = [[UILabel alloc]init];
    _taskLabel.frame =_matchPositionLabel.frame;
    _taskLabel.backgroundColor = [UIColor clearColor];
    _taskLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _taskLabel.text= @"0";
    _taskLabel.textAlignment = NSTextAlignmentRight;
    _taskLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [self addSubview:_taskLabel];
    
    UILabel *taskNumberTitleLabel = [[UILabel alloc]init];
    taskNumberTitleLabel.frame = matchPositionTitleLabel.frame;
    taskNumberTitleLabel.backgroundColor = [UIColor clearColor];
    taskNumberTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    taskNumberTitleLabel.text= @"匹配职位";
    taskNumberTitleLabel.textAlignment = NSTextAlignmentRight;
    taskNumberTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [self addSubview:taskNumberTitleLabel];
    
    _taskButton = [[UIButton alloc]init];
    _taskButton.frame =CGRectMake(10, _matchPositionLabel.frame.origin.y, WIDTH/2-20, 100);
//    [_taskButton addTarget:self action:@selector(lookTask) forControlEvents:UIControlEventTouchUpInside];
    //_taskButton.backgroundColor = RGBACOLOR(190, 231, 214, 0.5);
    _taskButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_taskButton];
    
    
    _positionButton = [[UIButton alloc]init];
    _positionButton.frame = CGRectMake(_taskButton.frame.origin.x+_taskButton.frame.size.width+10, _matchPositionLabel.frame.origin.y, WIDTH/2-10, 100);
    _positionButton.backgroundColor = [UIColor clearColor];
//    [positionButton addTarget:self action:@selector(lookPosition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_positionButton];
    
    return self;
}

@end
