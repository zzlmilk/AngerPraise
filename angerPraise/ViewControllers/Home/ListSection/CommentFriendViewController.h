//
//  CommentFriendViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CommentFriendViewController : BaseViewController

@property(nonatomic,strong)UITableView *commentFriendTableView;

@property(nonatomic,strong)UIButton *backBtn;

@property NSMutableArray *commentFriendArray;

@end
