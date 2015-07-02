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
        cellView.frame = CGRectMake(15, 25, rect.size.width-2*15, [[UIScreen mainScreen] bounds].size.height*0.36);
        cellView.backgroundColor = RGBACOLOR(252, 254, 253, 1.0f);
        cellView.layer.masksToBounds = YES;
        cellView.layer.cornerRadius = 10;
        [self.contentView addSubview:cellView];
        
        
        //职位名称
        _positionNameLabel = [[UILabel alloc]init];
        _positionNameLabel.frame = CGRectMake(15, 20, cellView.frame.size.width-2*15, 35);
        _positionNameLabel.textColor = RGBACOLOR(20, 20, 20, 1.0F);
        _positionNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
        _positionNameLabel.text = @"软件工程师";
        _positionNameLabel.textAlignment = NSTextAlignmentCenter;
        _positionNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_positionNameLabel];

        // 是否 热门
        _hotJobStatusImageView = [[UIImageView alloc]init];
        _hotJobStatusImageView.frame = CGRectMake((rect.size.width-130)/2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+12, 25, 25);
        _hotJobStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_hotJobStatusImageView];
        
        // 是否 急招
        _nowHiringStatusImageView = [[UIImageView alloc]init];
        _nowHiringStatusImageView.frame = CGRectMake(_hotJobStatusImageView.frame.size.width+_hotJobStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+12, 25, 25);
        _nowHiringStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_nowHiringStatusImageView];
        
        // 是否 高薪
        _highSalaryStatusImageView = [[UIImageView alloc]init];
        _highSalaryStatusImageView.frame = CGRectMake(_nowHiringStatusImageView.frame.size.width+_nowHiringStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+12, 25, 25);
        _highSalaryStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_highSalaryStatusImageView];
        
        //是否有 面试补贴
        _subsidiesInterImageView = [[UIImageView alloc]init];
        _subsidiesInterImageView.frame = CGRectMake(_highSalaryStatusImageView.frame.size.width+_highSalaryStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+12, 25, 25);
        _subsidiesInterImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_subsidiesInterImageView];
        
        //公司名称中拼接 创建时间
        _companyNameLabel = [[UILabel alloc]init];
        _companyNameLabel.frame = CGRectMake(50-10, _subsidiesInterImageView.frame.size.height+_subsidiesInterImageView.frame.origin.y, WIDTH-2*50, 30);
        _companyNameLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
        _companyNameLabel.text = @"红丘陵(上海)实业有限公司";
        _companyNameLabel.textAlignment = NSTextAlignmentCenter;
        _companyNameLabel.textColor =RGBACOLOR(177, 179, 180, 1.0f);
        _companyNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_companyNameLabel];
        
        //竞争力排名
        _competitionNumberUIButton = [[UIButton alloc]init];
        _competitionNumberUIButton.frame = CGRectMake(100-10, _companyNameLabel.frame.size.height+_companyNameLabel.frame.origin.y+10, WIDTH-2*100, 20);
        [_competitionNumberUIButton setTitle:@"   上海 - 陆家嘴" forState:UIControlStateNormal];
        [_competitionNumberUIButton setImage:[UIImage imageNamed:@"0tabbar2"] forState:UIControlStateNormal];
        _competitionNumberUIButton.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        [_competitionNumberUIButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateNormal];
        _competitionNumberUIButton.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_competitionNumberUIButton];

        _educationButton = [[UIButton alloc]init];
        _educationButton.frame = CGRectMake(_competitionNumberUIButton.frame.origin.x, _competitionNumberUIButton.frame.size.height+_competitionNumberUIButton.frame.origin.y+1, WIDTH-2*100, 20);
        _educationButton.backgroundColor = [UIColor clearColor];
        [_educationButton setTitle:@"   上海 - 陆家嘴" forState:UIControlStateNormal];
        _educationButton.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        [_educationButton setImage:[UIImage imageNamed:@"0tabbar2"] forState:UIControlStateNormal];
        [_educationButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateNormal];
        [cellView addSubview:_educationButton];

        _workPlaceButton = [[UIButton alloc]init];
        _workPlaceButton.frame = CGRectMake(_educationButton.frame.origin.x, _educationButton.frame.size.height+_educationButton.frame.origin.y+1, WIDTH-2*100, 20);
        [_workPlaceButton setTitle:@"   上海 - 陆家嘴" forState:UIControlStateNormal];
        [_workPlaceButton setImage:[UIImage imageNamed:@"0tabbar2"] forState:UIControlStateNormal];
        _workPlaceButton.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        _workPlaceButton.backgroundColor = [UIColor clearColor];
        [_workPlaceButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateNormal];
        [cellView addSubview:_workPlaceButton];
        
        _tagLabel = [[UILabel alloc]init];
        _tagLabel.frame = CGRectMake(0, _workPlaceButton.frame.size.height+_workPlaceButton.frame.origin.y,cellView.frame.size.width, 35);
        _tagLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
        _tagLabel.text = @"有管理能力 三年以上经验   BAT背景";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        [cellView addSubview:_tagLabel];
        
        _matchImageView = [[UIImageView alloc]init];
        _matchImageView.frame = CGRectMake(0, 20, 50, 25);
        _matchImageView.image = [UIImage imageNamed:@"0cell_bg"];
        [cellView addSubview:_matchImageView];
        
//        _workPlaceLabel = [[UILabel alloc]init];
//        _workPlaceLabel.frame = CGRectMake(0, _positionNameLabel.frame.size.height+_positionNameLabel.frame.origin.y-5, cellView.frame.size.width, 35);
//        _workPlaceLabel.text = @"上海－浦东";
//        _workPlaceLabel.textAlignment = NSTextAlignmentCenter;
//        _workPlaceLabel.backgroundColor = [UIColor clearColor];
//        _workPlaceLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
//        _workPlaceLabel.textColor = RGBACOLOR(177, 179, 180, 1.0f);
//        [cellView addSubview:_workPlaceLabel];
        
        
        //面试补贴
//        _subsidiesInterImageView = [[UIImageView alloc]init];
//        _subsidiesInterImageView.frame = CGRectMake(cellView.frame.size.width-76,cellView.frame.size.height-76,76,76);
//        _subsidiesInterImageView.backgroundColor = [UIColor clearColor];
//        _subsidiesInterImageView.image = [UIImage imageNamed:@"0interviewbonus"];
//        [cellView addSubview:_subsidiesInterImageView];
 
        
        //竞争人数

        
        

      
        //学历
//        _educationLabel = [[UILabel alloc]init];
//        _educationLabel.frame = CGRectMake(_workPlaceLabel.frame.size.width+_workPlaceLabel.frame.origin.x, _workPlaceLabel.frame.origin.y, 50, 35);
//        _educationLabel.textColor = RGBACOLOR(80, 80, 80, 1.0f);
//        _educationLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        _educationLabel.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_educationLabel];
        
        
//        //竞争人数
//        UIImageView *competitionNumberImageView = [[UIImageView alloc]init];
//        competitionNumberImageView.frame = CGRectMake(15, _workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y+10, 25, 25);
////        competitionNumberImageView.backgroundColor = [UIColor redColor];
//        competitionNumberImageView.image = [UIImage imageNamed:@"jingzhengli"];
//        [self.contentView addSubview:competitionNumberImageView];
//        
//        
//        //排名
//        UIImageView *rankImageView = [[UIImageView alloc]init];
//        rankImageView.frame =CGRectMake(_competitionNumberUIButton.frame.size.width+_competitionNumberUIButton.frame.origin.x, _competitionNumberUIButton.frame.origin.y+5, 25, 25);
////        rankImageView.backgroundColor = [UIColor redColor];
//        rankImageView.image = [UIImage imageNamed:@"paiming"];
//        [self.contentView addSubview:rankImageView];
        
//        _rankLabel = [[UILabel alloc]init];
//        _rankLabel.frame = CGRectMake(rankImageView.frame.size.width+rankImageView.frame.origin.x, rankImageView.frame.origin.y-5, 70, 35);
//        _rankLabel.backgroundColor = [UIColor clearColor];
//        _rankLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
//        [self.contentView addSubview:_rankLabel];
        
        //匹配度
//        UIImageView *matchNumberImageView = [[UIImageView alloc]init];
//        matchNumberImageView.frame =  CGRectMake(_rankLabel.frame.size.width+_rankLabel.frame.origin.x, _rankLabel.frame.origin.y+5, 25, 25);
//        //matchNumberImageView.backgroundColor = [UIColor redColor];
//        matchNumberImageView.image = [UIImage imageNamed:@"pipeidu"];
//        [self.contentView addSubview:matchNumberImageView];
        
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
    
    //_workPlaceLabel.text = [positionList.workPlace stringByAppendingFormat : @"%@ %@ %@" ,@" | ",positionList.education,positionList.creatTime];
    
    //_educationLabel.text = positionList.education;
    //_creatTimeLabel.text = positionList.creatTime;
    
    //_matchNumberLabel.text =[@" 匹配度: " stringByAppendingString:positionList.matchNumber];
    
    //_competitionNumberLabel.text = [positionList.competitionNumber stringByAppendingString:@" 人竞争 "];
    
    //_rankLabel.text = [@"  排名: " stringByAppendingString:positionList.rank];
    
    //[_indexButton setTitle:[positionList.matchNumber stringByAppendingString:@"%"] forState:UIControlStateNormal];
    
    //NSString *rankCompetitionString = [positionList.rank stringByAppendingFormat : @"%@ %@",@" /",positionList.competitionNumber];
    
    //[_competitionNumberUIButton setTitle:rankCompetitionString forState:UIControlStateNormal];
    
    //_typeLabel.text = positionList.type;
    
//    if ([positionList.subsidiesInterview isEqualToString:@"0"]) {
//        
//        _subsidiesInterImageView.hidden = YES;
//    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
