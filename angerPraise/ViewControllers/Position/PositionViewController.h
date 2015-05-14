//
//  PositionViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *positionTableView;

@property(nonatomic,strong)UISearchBar *searchPositionTextField;

@property NSMutableArray *positionListArray;


@property int page;
@property NSString* pageString;

@property int lastPosition;

@end
