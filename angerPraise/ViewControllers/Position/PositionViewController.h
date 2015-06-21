//
//  PositionViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MainViewController.h"

@interface PositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,TabBarItemSelectDelegate>

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
@end
