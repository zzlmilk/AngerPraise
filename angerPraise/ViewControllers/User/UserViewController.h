//
//  UserViewController.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface UserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *userTableView;

@property NSArray *modelListArray;

@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *hirelibNumberLabel;

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)NSString *user_type;

@end
