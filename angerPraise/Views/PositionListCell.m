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

#define kMagin 15

#define kCellHeight 250.f

@implementation PositionListCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        CGRect rect = self.contentView.frame;
        
        UIView *cellView = [[UIView alloc]init];
        cellView.frame = CGRectMake(kMagin, kMagin, rect.size.width-2*kMagin, kCellHeight-kMagin);
        
        cellView.backgroundColor = RGBACOLOR(255, 255, 255, 1.0f);
        cellView.layer.masksToBounds = YES;
        cellView.layer.cornerRadius = 8;
        [self.contentView addSubview:cellView];
        
        
        
        // 使用两个label 拼接
        _matchImageView = [[UIImageView alloc]init];
        _matchImageView.frame = CGRectMake(0, kMagin, 60, 25);
        _matchImageView.image = [UIImage imageNamed:@"0cell_bg"];
         [cellView addSubview:_matchImageView];
        
        
        UILabel *matchNumberTipLabel = [[UILabel alloc]init];
        matchNumberTipLabel.frame = CGRectMake(2, 0, 30, 25);
        matchNumberTipLabel.backgroundColor = [UIColor clearColor];
        matchNumberTipLabel.text = @"匹配度";
        matchNumberTipLabel.textColor = RGBACOLOR(220, 220, 220, 1.0f);
        matchNumberTipLabel.font = [UIFont fontWithName:@"Helvetica" size:10.f];
        [_matchImageView addSubview:matchNumberTipLabel];
        
    
        _matchNumberLabel = [[UILabel alloc]init];
        _matchNumberLabel.frame = CGRectMake(matchNumberTipLabel.frame.size.width+matchNumberTipLabel.frame.origin.x +2, 4, 20, 25);
        _matchNumberLabel.text = @"883%";
        [_matchNumberLabel sizeToFit];
        _matchNumberLabel.textColor = RGBACOLOR(220, 220, 220, 1.0f);
        _matchNumberLabel.font =[UIFont fontWithName:hlScoreFont size:16.f];
        [_matchImageView addSubview:_matchNumberLabel];
        
      

        
        
        //职位名称
        _positionNameLabel = [[UILabel alloc]init];
        _positionNameLabel.frame = CGRectMake(_matchImageView.frame.origin.x+_matchImageView.frame.size.width + 4, kMagin, cellView.frame.size.width-2*(_matchImageView.frame.origin.x+_matchImageView.frame.size.width), 35);
        _positionNameLabel.textColor = RGBACOLOR(20, 20, 20, 1.0F);
        _positionNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
        _positionNameLabel.text = @"职位名称";
        _positionNameLabel.textAlignment = NSTextAlignmentCenter;
        _positionNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_positionNameLabel];

       
        // 是否 热门
        _hotJobStatusImageView = [[UIImageView alloc]init];
        _hotJobStatusImageView.frame = CGRectMake(_positionNameLabel.frame.origin.x+_positionIdLabel.frame.size.width + 2*kMagin, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+kMagin, 20, 20);
        _hotJobStatusImageView.image = [UIImage imageNamed:@"0hotpositionsmall2"];
        [cellView addSubview:_hotJobStatusImageView];
        
        // 是否 急招
        _nowHiringStatusImageView = [[UIImageView alloc]init];
        _nowHiringStatusImageView.frame = CGRectMake(_hotJobStatusImageView.frame.size.width+_hotJobStatusImageView.frame.origin.x+kMagin/2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+kMagin, 20, 20);
        _nowHiringStatusImageView.image = [UIImage imageNamed:@"0urgentpositionsmall2"];
        [cellView addSubview:_nowHiringStatusImageView];
        
        // 是否 高薪
        _highSalaryStatusImageView = [[UIImageView alloc]init];
        _highSalaryStatusImageView.frame = CGRectMake(_nowHiringStatusImageView.frame.size.width+_nowHiringStatusImageView.frame.origin.x+kMagin/2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+kMagin, 20, 20);
        _highSalaryStatusImageView.image = [UIImage imageNamed:@"0highsalarysmall2"];
        [cellView addSubview:_highSalaryStatusImageView];
        
        //是否有 面试补贴
        _subsidiesInterImageView = [[UIImageView alloc]init];
        _subsidiesInterImageView.frame = CGRectMake(_highSalaryStatusImageView.frame.size.width+_highSalaryStatusImageView.frame.origin.x+kMagin/2, _positionNameLabel.frame.size.height+_positionIdLabel.frame.origin.y+kMagin, 20, 20);
        _subsidiesInterImageView.image = [UIImage imageNamed:@"0bonoussmall2"];
        [cellView addSubview:_subsidiesInterImageView];
        
        
        //竞争力排名
        UIImageView *competitionNumberImageView = [[UIImageView alloc]init];
        competitionNumberImageView.frame = CGRectMake(_hotJobStatusImageView.frame.origin.x, _hotJobStatusImageView.frame.size.height+_hotJobStatusImageView.frame.origin.y+kMagin, 20, 20);
        competitionNumberImageView.image = [UIImage imageNamed:@"0tabbar2"];
        competitionNumberImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:competitionNumberImageView];
        
        _competitionNumberLabel = [[UILabel alloc]init];
        _competitionNumberLabel.frame = CGRectMake(competitionNumberImageView.frame.size.width+competitionNumberImageView.frame.origin.x+5, competitionNumberImageView.frame.origin.y, _positionNameLabel.frame.size.width, 17);
        _competitionNumberLabel.text = @"竞争力排名6/121";
        _competitionNumberLabel.font = [UIFont systemFontOfSize: 13.0];
        _competitionNumberLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        _competitionNumberLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_competitionNumberLabel];
        
        
        UIImageView *educationImageView = [[UIImageView alloc]init];
        educationImageView.frame = CGRectMake(competitionNumberImageView.frame.origin.x, competitionNumberImageView.frame.size.height+_competitionNumberLabel.frame.origin.y+3, 20, 20);
        educationImageView.image = [UIImage imageNamed:@"0tabbar2"];
        educationImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:educationImageView];
        
        _educationLabel = [[UILabel alloc]init];
        _educationLabel.frame = CGRectMake(educationImageView.frame.origin.x+educationImageView.frame.size.width+5, _competitionNumberLabel.frame.size.height+_competitionNumberLabel.frame.origin.y+8, _positionNameLabel.frame.size.width, 17);
        _educationLabel.backgroundColor = [UIColor clearColor];
        _educationLabel.text = @"本科以及上";
        _educationLabel.font =[UIFont systemFontOfSize: 13];
        _educationLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        [cellView addSubview:_educationLabel];
        
        
        
        UIImageView *workPlaceImageView = [[UIImageView alloc]init];
        workPlaceImageView.frame = CGRectMake(educationImageView.frame.origin.x, educationImageView.frame.size.height+educationImageView.frame.origin.y+5, 20, 20);
        workPlaceImageView.image = [UIImage imageNamed:@"0tabbar2"];
        workPlaceImageView.backgroundColor = [UIColor clearColor];
        [cellView addSubview:workPlaceImageView];
        
        _workPlaceLabel = [[UILabel alloc]init];
        _workPlaceLabel.frame = CGRectMake(workPlaceImageView.frame.origin.x+workPlaceImageView.frame.size.width+5, _educationLabel.frame.size.height+_educationLabel.frame.origin.y+8, _positionNameLabel.frame.size.width, 17);
        _workPlaceLabel.text = @"上海 - 陆家嘴";
        _workPlaceLabel.backgroundColor = [UIColor clearColor];
        _workPlaceLabel.font =[UIFont systemFontOfSize: 13.0];
        _workPlaceLabel.textColor =RGBACOLOR(20, 20, 20, 1.0f);
        [cellView addSubview:_workPlaceLabel];
        
        
        _companyNameLabel = [[UILabel alloc]init];
        _companyNameLabel.frame = CGRectMake(_positionNameLabel.frame.origin.x, cellView.frame.size.height-kMagin*3, _positionNameLabel.frame.size.width, 30);
        _companyNameLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
        _companyNameLabel.text = @"海浩厉科技信息有限公司";
        _companyNameLabel.textAlignment = NSTextAlignmentLeft;
        _companyNameLabel.textColor =RGBACOLOR(177, 179, 180, 1.0f);
        _companyNameLabel.backgroundColor = [UIColor clearColor];
        [cellView addSubview:_companyNameLabel];
        
        
        
        _tagLabel = [[UILabel alloc]init];
        _tagLabel.frame = CGRectMake(0, _companyNameLabel.frame.origin.y-20,cellView.frame.size.width, 15);
        _tagLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
        _tagLabel.text = @"有管理能力  三年以上经验   BAT背景";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = RGBACOLOR(226, 205, 123, 1.0f);
        [cellView addSubview:_tagLabel];
        
        
        
    }
    return self;
}

-(void)setP:(Position *)p{
    if (!p) {
        return;
    }
    
    NSString *positionNameString = [p.positionName stringByReplacingOccurrencesOfString:@" " withString:@""];
    _positionNameLabel.text = positionNameString;
    
    _companyNameLabel.text = [p.companyName stringByAppendingFormat : @"   %@",p.creatTime];
    
    _workPlaceLabel.text =p.workPlace;
    _educationLabel.text =p.education;
    
    
    NSString *competitionString = [@"竞争力排名" stringByAppendingFormat:@"%@ /%@",p.rank, p.competitionNumber];
    
    _competitionNumberLabel.text =competitionString;
    _matchNumberLabel.text = [p.matchNumber stringByAppendingFormat : @"%@",@"%"];
    
    
    
    if (p.hot_job_status  == YES) {
        _hotJobStatusImageView.image = [UIImage imageNamed:@"0hotpositionsmall1"];
    }
    
    if (p.now_hiring_status == YES) {
        
         _nowHiringStatusImageView.image = [UIImage imageNamed:@"0urgentpositionsmall1"];
    }
    
    if (p.high_salary_status ==YES) {
        _highSalaryStatusImageView.image=[UIImage imageNamed:@"0highsalarysmall1"];
        
    }
    if (p.subsidiesInterview ==YES) {
         _subsidiesInterImageView.image= [UIImage imageNamed:@"0bonoussmall1"];
        
    }
    
    
    //热词
    
    for (int i=0; i<p.hot_words.count; i++) {
       NSString*  words = [p.hot_words objectAtIndex:i];
        [words stringByAppendingString:words];
      
    }
    
   
    
    
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
