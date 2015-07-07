//
//  PositionViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PositionDetailViewController.h"
#import "ImportResumeViewController.h"


@interface PositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *positionTableView;

@property NSMutableArray *positionListArray;


@property int page;
@property NSString* pageString;

@property int lastPosition;

@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)UITextField *searchPositionTextField;
@property(nonatomic,strong)UILabel *searchPositionPlaceholderlabel;

@property(nonatomic,strong)UIView *tipView;
@property(nonatomic,strong)UILabel *recommondLabel;
@property(nonatomic,strong)UILabel *titleBgLabel;

@property(nonatomic,strong)UIButton *workPlaceDataButton;
@property(nonatomic,strong)UIButton *workAgeDataButton;
@property(nonatomic,strong)UIButton *monthlyDataButton;
@property(nonatomic,strong)UILabel *workPlaceDataUILabel;
@property(nonatomic,strong)UILabel *workAgeDataUILabel;
@property(nonatomic,strong)UILabel *monthlyDataUILabel;


@property(nonatomic,strong)NSArray *payRangeArray; // 薪资范围
@property(nonatomic,strong)NSArray *experienceArray;// 工作年限
@property(nonatomic,strong)NSArray *placeArray;// 目标地点


@property(nonatomic,strong)PositionDetailViewController *positionDetailVC;
@property(nonatomic,strong)ImportResumeViewController *importResumeVC;


-(void)getPositionInfo;
@end
