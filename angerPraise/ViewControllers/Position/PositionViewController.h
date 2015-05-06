//
//  PositionViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PositionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *positionTableView;

@property NSMutableArray *positionListArray;

@property (strong, nonatomic)  UIImageView *expandZoomImageView;

@property int page;
@property NSString* pageString;

@property int lastPosition;

@end
