//
//  EditPhotoViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EditPhotoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *editPhotoTableView;

@property NSArray *editListArray;

@end
