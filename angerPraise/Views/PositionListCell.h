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
@property(nonatomic,strong)UILabel *workPlaceLabel;
@property(nonatomic,strong)UILabel *educationLabel;
@property(nonatomic,strong)UILabel *creatTimeLabel;
@property(nonatomic,strong)UILabel *matchNumberLabel;//匹配度
@property(nonatomic,strong)UILabel *competitionNumberLabel;//竞争人数
@property(nonatomic,strong)UILabel *rankLabel;//排名
@property(nonatomic,strong)UIImageView *subsidiesInterImageView;//是否有面试补贴 1有 0 没有
@property(nonatomic,strong)UILabel *typeLabel; // 1精确推荐 2关联推荐 3特长推荐

@property(nonatomic,strong)UIButton *applyPositionButton;

@property (nonatomic,strong)Position *positionList;


@end
