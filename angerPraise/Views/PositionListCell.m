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
        _hotJobStatusImageView.frame = CGRectMake((rect.size.width-115)/2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+18, 20, 20);
        _hotJobStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_hotJobStatusImageView];
        
        // 是否 急招
        _nowHiringStatusImageView = [[UIImageView alloc]init];
        _nowHiringStatusImageView.frame = CGRectMake(_hotJobStatusImageView.frame.size.width+_hotJobStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+18, 20, 20);
        _nowHiringStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_nowHiringStatusImageView];
        
        // 是否 高薪
        _highSalaryStatusImageView = [[UIImageView alloc]init];
        _highSalaryStatusImageView.frame = CGRectMake(_nowHiringStatusImageView.frame.size.width+_nowHiringStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+18, 20, 20);
        _highSalaryStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_highSalaryStatusImageView];
        
        //是否有 面试补贴
        _subsidiesInterImageView = [[UIImageView alloc]init];
        _subsidiesInterImageView.frame = CGRectMake(_highSalaryStatusImageView.frame.size.width+_highSalaryStatusImageView.frame.origin.x+2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+18, 20, 20);
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
        UIImageView *competitionNumberImageView = [[UIImageView alloc]init];
        competitionNumberImageView.frame = CGRectMake(100, _companyNameLabel.frame.size.height+_companyNameLabel.frame.origin.y+10, 15, 15);
        competitionNumberImageView.image = [UIImage imageNamed:@"0tabbar2"];
        competitionNumberImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:competitionNumberImageView];
        
        _competitionNumberLabel = [[UILabel alloc]init];
        _competitionNumberLabel.frame = CGRectMake(competitionNumberImageView.frame.size.width+competitionNumberImageView.frame.origin.x+3, _companyNameLabel.frame.size.height+_companyNameLabel.frame.origin.y+10, WIDTH-2*100, 17);
        _competitionNumberLabel.text = @"竞争力排名6/121";
        _competitionNumberLabel.font = [UIFont systemFontOfSize: 10.0];
        _competitionNumberLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        _competitionNumberLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_competitionNumberLabel];

        
        UIImageView *educationImageView = [[UIImageView alloc]init];
        educationImageView.frame = CGRectMake(100, _competitionNumberLabel.frame.size.height+_competitionNumberLabel.frame.origin.y+2, 15, 15);
        educationImageView.image = [UIImage imageNamed:@"0tabbar2"];
        educationImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:educationImageView];

        _educationLabel = [[UILabel alloc]init];
        _educationLabel.frame = CGRectMake(educationImageView.frame.origin.x+educationImageView.frame.size.width+3, _competitionNumberLabel.frame.size.height+_competitionNumberLabel.frame.origin.y+1, WIDTH-2*100, 17);
        _educationLabel.backgroundColor = [UIColor clearColor];
        _educationLabel.text = @"本科";
        _educationLabel.font =[UIFont systemFontOfSize: 10.0];
        _educationLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        [cellView addSubview:_educationLabel];

        UIImageView *workPlaceImageView = [[UIImageView alloc]init];
        workPlaceImageView.frame = CGRectMake(100, _educationLabel.frame.size.height+_educationLabel.frame.origin.y+2, 15, 15);
        workPlaceImageView.image = [UIImage imageNamed:@"0tabbar2"];
        workPlaceImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:workPlaceImageView];
        
        _workPlaceLabel = [[UILabel alloc]init];
        _workPlaceLabel.frame = CGRectMake(workPlaceImageView.frame.origin.x+workPlaceImageView.frame.size.width+3, _educationLabel.frame.size.height+_educationLabel.frame.origin.y+1, WIDTH-2*100, 17);
        _workPlaceLabel.text = @"上海 - 陆家嘴";
        _workPlaceLabel.backgroundColor = [UIColor clearColor];
        _workPlaceLabel.font =[UIFont systemFontOfSize: 10.0];
        _workPlaceLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        [cellView addSubview:_workPlaceLabel];
        
        _tagLabel = [[UILabel alloc]init];
        _tagLabel.frame = CGRectMake(0, _workPlaceLabel.frame.size.height+_workPlaceLabel.frame.origin.y+10,cellView.frame.size.width, 15);
        _tagLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
        _tagLabel.text = @"有管理能力 三年以上经验   BAT背景";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = RGBACOLOR(226, 205, 123, 1.0f);
        [cellView addSubview:_tagLabel];
        
        _matchImageView = [[UIImageView alloc]init];
        _matchImageView.frame = CGRectMake(0, 20, 50, 25);
        _matchImageView.image = [UIImage imageNamed:@"0cell_bg"];
        [cellView addSubview:_matchImageView];
        
        // 使用两个label 拼接
        UILabel *matchNumberTipLabel = [[UILabel alloc]init];
        matchNumberTipLabel.frame = CGRectMake(0, 0, 30, 25);
        matchNumberTipLabel.backgroundColor = [UIColor clearColor];
        matchNumberTipLabel.text = @"匹配度";
        matchNumberTipLabel.textColor = RGBACOLOR(220, 220, 220, 1.0f);
        matchNumberTipLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
        [_matchImageView addSubview:matchNumberTipLabel];
        
        _matchNumberLabel = [[UILabel alloc]init];
        _matchNumberLabel.frame = CGRectMake(matchNumberTipLabel.frame.size.width+1, 0, 20, 25);
        _matchNumberLabel.text = @"53%";
        _matchNumberLabel.textColor = RGBACOLOR(220, 220, 220, 1.0f);
        _matchNumberLabel.font =[UIFont fontWithName:hlScoreFont size:16.f];
        [_matchImageView addSubview:_matchNumberLabel];
        
        //视频 图标
        _companyVideoStatusImageView = [[UIImageView alloc]init];
        _companyVideoStatusImageView.frame = CGRectMake(cellView.frame.size.width-2*15, _tagLabel.frame.origin.y, 15, 15);
        _companyVideoStatusImageView.image = [UIImage imageNamed:@"0tabbar2"];
        [cellView addSubview:_companyVideoStatusImageView];
        
        
        
    }
    return self;
}

-(void)setPositionList:(Position *)positionList{
    
    NSString *positionNameString = [positionList.positionName stringByReplacingOccurrencesOfString:@" " withString:@""];
    _positionNameLabel.text = positionNameString;
    
    _companyNameLabel.text = [positionList.companyName stringByAppendingFormat : @"   %@",positionList.creatTime];
    
    _workPlaceLabel.text =positionList.workPlace;
    _educationLabel.text =positionList.education;
    
    NSString *competitionString = [@"竞争力排名" stringByAppendingFormat:@"%@ /%@",positionList.rank, positionList.competitionNumber];
    
    _competitionNumberLabel.text =competitionString;
    _matchNumberLabel.text = [positionList.matchNumber stringByAppendingFormat : @"%@",@"%"];
    
    NSString *videoStatusString = [NSString stringWithFormat:@"%@",positionList.company_video_status];
    if ([videoStatusString isEqualToString:@"0"]) {//没视频
        
        _companyVideoStatusImageView.hidden = YES;
        
    }

    //company_video_status
    
    
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
