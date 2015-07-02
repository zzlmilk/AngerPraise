//
//  PositionListCell.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Position.h"

@interface PositionListCell : UITableViewCell

@property(nonatomic,strong)UILabel *positionIdLabel;
@property(nonatomic,strong)UILabel *positionNameLabel;
@property(nonatomic,strong)UILabel *companyNameLabel;
@property(nonatomic,strong)UIButton *workPlaceButton;
@property(nonatomic,strong)UIButton *educationButton;
@property(nonatomic,strong)UILabel *matchNumberLabel;//匹配度
@property(nonatomic,strong)UILabel *rankLabel;//排名
@property(nonatomic,strong)UIButton *competitionNumberUIButton;//竞争人数
@property(nonatomic,strong)UILabel *typeLabel; // 1精确推荐 2关联推荐 3特长推荐
@property(nonatomic,strong)UILabel *creatTimeLabel;

@property(nonatomic,strong)UIImageView *matchImageView;//匹配度

@property(nonatomic,strong)UILabel *tagLabel;

@property(nonatomic,strong)UIImageView *subsidiesInterImageView;//是否有面试补贴 1有 0 没有
@property(nonatomic,strong)UIImageView *hotJobStatusImageView; // 是否有热门职位 0 否，1 是
@property(nonatomic,strong)UIImageView *nowHiringStatusImageView; // 是否急招 0 否，1 是
@property(nonatomic,strong)UIImageView *highSalaryStatusImageView; // 是否高薪 0 否，1 是
@property(nonatomic,strong)UIImageView *companyMapStatusImageView; //是否有地图 0 否，1 是
@property(nonatomic,strong)UIImageView *companyVideoStatusImageView; //是否有视频 0 否，1 是





//@property(nonatomic,strong)UIButton *applyPositionButton;

@property (nonatomic,strong)Position *positionList;


@end
