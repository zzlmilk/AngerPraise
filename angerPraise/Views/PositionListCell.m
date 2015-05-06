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

        //职位名称
        _positionNameLabel = [[UILabel alloc]init];
        _positionNameLabel.frame = CGRectMake(15, 10, self.frame.size.width-100, 35);
        _positionIdLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
        _positionNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_positionNameLabel];
        
        //面试补贴
        _subsidiesInterImageView = [[UIImageView alloc]init];
        _subsidiesInterImageView.frame = CGRectMake(self.frame.size.width-80,_positionNameLabel.frame.origin.y,100,28);
        //        competitionNumberImageView.backgroundColor = [UIColor redColor];
        _subsidiesInterImageView.image = [UIImage imageNamed:@"mianshibutie"];
        [self.contentView addSubview:_subsidiesInterImageView];
        
        
        //公司名称
        _companyNameLabel = [[UILabel alloc]init];
        _companyNameLabel.frame = CGRectMake(15, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y, self.frame.size.width-50, 35);
        _companyNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.f];
        _companyNameLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
        _companyNameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_companyNameLabel];
        
        //工作地点
        _workPlaceLabel = [[UILabel alloc]init];
        _workPlaceLabel.frame = CGRectMake(15, _companyNameLabel.frame.size.height+_companyNameLabel.frame.origin.y-5, 110, 35);
        _workPlaceLabel.backgroundColor = [UIColor clearColor];
        _workPlaceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        _workPlaceLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
        [self.contentView addSubview:_workPlaceLabel];
        
        //学历
        _educationLabel = [[UILabel alloc]init];
        _educationLabel.frame = CGRectMake(_workPlaceLabel.frame.size.width+_workPlaceLabel.frame.origin.x, _workPlaceLabel.frame.origin.y, 50, 35);
        _educationLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
        _educationLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        _educationLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_educationLabel];
        
        //创建职位时间
        _creatTimeLabel = [[UILabel alloc]init];
        _creatTimeLabel.frame = CGRectMake(_companyNameLabel.frame.size.width-15,_companyNameLabel.frame.origin.y+12,60,35);
        _creatTimeLabel.backgroundColor = [UIColor clearColor];
        _creatTimeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        [self.contentView addSubview:_creatTimeLabel];
        
        //竞争人数
        UIImageView *competitionNumberImageView = [[UIImageView alloc]init];
        competitionNumberImageView.frame = CGRectMake(15, _workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y+10, 25, 25);
//        competitionNumberImageView.backgroundColor = [UIColor redColor];
        competitionNumberImageView.image = [UIImage imageNamed:@"jingzhengli"];
        [self.contentView addSubview:competitionNumberImageView];
        
        _competitionNumberLabel = [[UILabel alloc]init];
        _competitionNumberLabel.frame =CGRectMake(competitionNumberImageView.frame.origin.x+competitionNumberImageView.frame.size.width+5, competitionNumberImageView.frame.origin.y-5, 70, 35);
        _competitionNumberLabel.backgroundColor = [UIColor clearColor];
        _competitionNumberLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        [self.contentView addSubview:_competitionNumberLabel];
        
        //排名
        UIImageView *rankImageView = [[UIImageView alloc]init];
        rankImageView.frame =CGRectMake(_competitionNumberLabel.frame.size.width+_competitionNumberLabel.frame.origin.x, _competitionNumberLabel.frame.origin.y+5, 25, 25);
//        rankImageView.backgroundColor = [UIColor redColor];
        rankImageView.image = [UIImage imageNamed:@"paiming"];
        [self.contentView addSubview:rankImageView];
        
        _rankLabel = [[UILabel alloc]init];
        _rankLabel.frame = CGRectMake(rankImageView.frame.size.width+rankImageView.frame.origin.x, rankImageView.frame.origin.y-5, 70, 35);
        _rankLabel.backgroundColor = [UIColor clearColor];
        _rankLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        [self.contentView addSubview:_rankLabel];
        
        //匹配度
        UIImageView *matchNumberImageView = [[UIImageView alloc]init];
        matchNumberImageView.frame =  CGRectMake(_rankLabel.frame.size.width+_rankLabel.frame.origin.x, _rankLabel.frame.origin.y+5, 25, 25);
        //matchNumberImageView.backgroundColor = [UIColor redColor];
        matchNumberImageView.image = [UIImage imageNamed:@"pipeidu"];
        [self.contentView addSubview:matchNumberImageView];
        
        _matchNumberLabel = [[UILabel alloc]init];
        _matchNumberLabel.frame =CGRectMake(matchNumberImageView.frame.origin.x+matchNumberImageView.frame.size.width, matchNumberImageView.frame.origin.y-5, 70, 35);
        _matchNumberLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
        _matchNumberLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_matchNumberLabel];
        
    }
    return self;
}


-(void)setPositionList:(Position *)positionList{
    
    NSString *positionNameString = [positionList.positionName stringByReplacingOccurrencesOfString:@" " withString:@""];
    _positionNameLabel.text = positionNameString;
    _companyNameLabel.text = positionList.companyName;
    _workPlaceLabel.text = positionList.workPlace;
    _workPlaceLabel.text = positionList.workPlace;
    _educationLabel.text = positionList.education;
    _creatTimeLabel.text = positionList.creatTime;
    _matchNumberLabel.text =[@" 匹配度: " stringByAppendingString:positionList.matchNumber];
    _competitionNumberLabel.text = [positionList.competitionNumber stringByAppendingString:@" 人竞争 "];
    _rankLabel.text = [@"  排名: " stringByAppendingString:positionList.rank];
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
