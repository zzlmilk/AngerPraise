//
//  SettingViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *settingTableView;

@property NSArray *settingListArray;
@property(nonatomic,strong)NSString *takeUrlString;

@property(nonatomic,strong)NSString *about_url;
@property(nonatomic,strong)NSString *privacy_url;
@property(nonatomic,strong)NSString *review_app_url;
@property(nonatomic,strong)NSString *version_url;

@end
