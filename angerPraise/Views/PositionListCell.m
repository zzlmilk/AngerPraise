//
//  PositionListCell.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PositionListCell.h"
#import "Position.h"
#import "ApIClient.h"

@implementation PositionListCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        CGRect rect = [[UIScreen mainScreen] bounds];
        
        UIView *cellView = [[UIView alloc]init];
        cellView.frame = CGRectMake(15, 35, rect.size.width-2*15, [[UIScreen mainScreen] bounds].size.height*0.36);
        cellView.backgroundColor = RGBACOLOR(252, 254, 253, 1.0f);
        cellView.layer.masksToBounds = YES;
        cellView.layer.cornerRadius = 10;
        [self.contentView addSubview:cellView];
        
        _indexButton = [[UIButton alloc]init];
        _indexButton.frame = CGRectMake((rect.size.width-50)/2,8, 50, 50);
        [_indexButton setTitle:@"64%" forState:UIControlStateNormal];
        [_indexButton.layer setMasksToBounds:YES];
        [_indexButton.layer setCornerRadius:25.0]; //设置矩形四个圆角半径
        [_indexButton setTitleColor:RGBACOLOR(0, 204, 252, 1.0f) forState:UIControlStateNormal];
        _indexButton.titleLabel.font = [UIFont fontWithName:hlScoreFont size:22];
        _indexButton.layer.borderWidth = 2;
        _indexButton.layer.cornerRadius=50/2;
        _indexButton.layer.borderColor = RGBACOLOR(58, 57, 63, 1.0f).CGColor;
        _indexButton.titleEdgeInsets = UIEdgeInsetsMake(0, 1,-5, 0);
        
        _indexButton.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_indexButton];
        
        
        
        //职位名称
        _positionNameLabel = [[UILabel alloc]init];
        _positionNameLabel.frame = CGRectMake(15, 40, cellView.frame.size.width-2*15, 35);
        _positionNameLabel.textColor = RGBACOLOR(20, 20, 20, 1.0F);
        _positionNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
        _positionNameLabel.text = @"软件工程师";
        _positionNameLabel.textAlignment = NSTextAlignmentCenter;
        _positionNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_positionNameLabel];

        
        _workPlaceLabel = [[UILabel alloc]init];
        _workPlaceLabel.frame = CGRectMake(0, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y-5, cellView.frame.size.width, 35);
        _workPlaceLabel.text = @"上海－浦东";
        _workPlaceLabel.textAlignment = NSTextAlignmentCenter;
        _workPlaceLabel.backgroundColor = [UIColor clearColor];
        _workPlaceLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
        _workPlaceLabel.textColor = RGBACOLOR(177, 179, 180, 1.0f);
        [cellView addSubview:_workPlaceLabel];
        
        //面试补贴
        _subsidiesInterImageView = [[UIImageView alloc]init];
        _subsidiesInterImageView.frame = CGRectMake(cellView.frame.size.width-76,cellView.frame.size.height-76,76,76);
        _subsidiesInterImageView.backgroundColor = [UIColor clearColor];
        _subsidiesInterImageView.image = [UIImage imageNamed:@"0interviewbonus"];
        [cellView addSubview:_subsidiesInterImageView];
 
        
        //竞争人数
        _competitionNumberUIButton = [[UIButton alloc]init];
        _competitionNumberUIButton.frame = CGRectMake(0,_workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y+15,cellView.frame.size.width, 30);
        [_competitionNumberUIButton setTitle:@"31/126" forState:UIControlStateNormal];
        [_competitionNumberUIButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [_competitionNumberUIButton setImage:[UIImage imageNamed:@"0ranking"] forState:UIControlStateNormal];
        [_competitionNumberUIButton setTitleColor:RGBACOLOR(177, 179, 180, 1.0f) forState:UIControlStateNormal];
        _competitionNumberUIButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _competitionNumberUIButton.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_competitionNumberUIButton];
        
        
        //公司名称
        _companyNameLabel = [[UILabel alloc]init];
        _companyNameLabel.frame = CGRectMake(0, _competitionNumberUIButton.frame.size.height+_competitionNumberUIButton.frame.origin.y+15,cellView.frame.size.width, 35);
        _companyNameLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
        _companyNameLabel.text = @"红丘陵(上海)实业有限公司";
        _companyNameLabel.textAlignment = NSTextAlignmentCenter;
        _companyNameLabel.textColor =RGBACOLOR(177, 179, 180, 1.0f);
        _companyNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_companyNameLabel];
//
//        //工作地点
//        _workPlaceLabel = [[UILabel alloc]init];
//        _workPlaceLabel.frame = CGRectMake(15, _companyNameLabel.frame.size.height+_companyNameLabel.frame.origin.y-5, 110, 35);
//        _workPlaceLabel.backgroundColor = [UIColor clearColor];
//        _workPlaceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        _workPlaceLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
//        [self.contentView addSubview:_workPlaceLabel];
//        
//        //学历
//        _educationLabel = [[UILabel alloc]init];
//        _educationLabel.frame = CGRectMake(_workPlaceLabel.frame.size.width+_workPlaceLabel.frame.origin.x, _workPlaceLabel.frame.origin.y, 50, 35);
//        _educationLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
//        _educationLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        _educationLabel.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_educationLabel];
//        
//        //创建职位时间
//        _creatTimeLabel = [[UILabel alloc]init];
//        _creatTimeLabel.frame = CGRectMake(_companyNameLabel.frame.size.width-15,_companyNameLabel.frame.origin.y+12,60,35);
//        _creatTimeLabel.backgroundColor = [UIColor clearColor];
//        _creatTimeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        [self.contentView addSubview:_creatTimeLabel];
//        
//        //竞争人数
//        UIImageView *competitionNumberImageView = [[UIImageView alloc]init];
//        competitionNumberImageView.frame = CGRectMake(15, _workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y+10, 25, 25);
////        competitionNumberImageView.backgroundColor = [UIColor redColor];
//        competitionNumberImageView.image = [UIImage imageNamed:@"jingzhengli"];
//        [self.contentView addSubview:competitionNumberImageView];
//        
//        _competitionNumberLabel = [[UILabel alloc]init];
//        _competitionNumberLabel.frame =CGRectMake(competitionNumberImageView.frame.origin.x+competitionNumberImageView.frame.size.width+5, competitionNumberImageView.frame.origin.y-5, 70, 35);
//        _competitionNumberLabel.backgroundColor = [UIColor clearColor];
//        _competitionNumberLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        [self.contentView addSubview:_competitionNumberLabel];
//        
//        //排名
//        UIImageView *rankImageView = [[UIImageView alloc]init];
//        rankImageView.frame =CGRectMake(_competitionNumberLabel.frame.size.width+_competitionNumberLabel.frame.origin.x, _competitionNumberLabel.frame.origin.y+5, 25, 25);
////        rankImageView.backgroundColor = [UIColor redColor];
//        rankImageView.image = [UIImage imageNamed:@"paiming"];
//        [self.contentView addSubview:rankImageView];
//        
//        _rankLabel = [[UILabel alloc]init];
//        _rankLabel.frame = CGRectMake(rankImageView.frame.size.width+rankImageView.frame.origin.x, rankImageView.frame.origin.y-5, 70, 35);
//        _rankLabel.backgroundColor = [UIColor clearColor];
//        _rankLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        [self.contentView addSubview:_rankLabel];
//        
//        //匹配度
//        UIImageView *matchNumberImageView = [[UIImageView alloc]init];
//        matchNumberImageView.frame =  CGRectMake(_rankLabel.frame.size.width+_rankLabel.frame.origin.x, _rankLabel.frame.origin.y+5, 25, 25);
//        //matchNumberImageView.backgroundColor = [UIColor redColor];
//        matchNumberImageView.image = [UIImage imageNamed:@"pipeidu"];
//        [self.contentView addSubview:matchNumberImageView];
//        
//        _matchNumberLabel = [[UILabel alloc]init];
//        _matchNumberLabel.frame =CGRectMake(matchNumberImageView.frame.origin.x+matchNumberImageView.frame.size.width, matchNumberImageView.frame.origin.y-5, 70, 35);
//        _matchNumberLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        _matchNumberLabel.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_matchNumberLabel];
        
        
        
    }
    return self;
}


-(void)setPositionList:(Position *)positionList{
    
    NSString *positionNameString = [positionList.positionName stringByReplacingOccurrencesOfString:@" " withString:@""];
    _positionNameLabel.text = positionNameString;
    _companyNameLabel.text = positionList.companyName;
    
    //_workPlaceLabel.text = positionList.workPlace;
    
    _workPlaceLabel.text = [positionList.workPlace stringByAppendingFormat : @"%@ %@ %@" ,@" | ",positionList.education,positionList.creatTime];
    
//    _educationLabel.text = positionList.education;
//    _creatTimeLabel.text = positionList.creatTime;
    
//    _matchNumberLabel.text =[@" 匹配度: " stringByAppendingString:positionList.matchNumber];
    
//    _competitionNumberLabel.text = [positionList.competitionNumber stringByAppendingString:@" 人竞争 "];
    
//    _rankLabel.text = [@"  排名: " stringByAppendingString:positionList.rank];
    
    [_indexButton setTitle:[positionList.matchNumber stringByAppendingString:@"%"] forState:UIControlStateNormal];
    
    NSString *rankCompetitionString = [positionList.rank stringByAppendingFormat : @"%@ %@",@" /",positionList.competitionNumber];
    
    [_competitionNumberUIButton setTitle:rankCompetitionString forState:UIControlStateNormal];
    
    _typeLabel.text = positionList.type;
    
    if ([positionList.subsidiesInterview isEqualToString:@"0"]) {
        
        _subsidiesInterImageView.hidden = YES;
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
