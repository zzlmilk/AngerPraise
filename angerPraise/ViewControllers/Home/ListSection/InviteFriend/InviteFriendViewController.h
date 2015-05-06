//
//  InviteFriendViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "InviteFriendCell.h"

@interface InviteFriendViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *inviteFriendTableView;

@property NSMutableArray *inviteFriendArray;

@property(nonatomic,strong)UIButton *inviteButton;

@end

