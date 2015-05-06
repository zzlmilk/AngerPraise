//
//  InviteFriendCell.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteFriend.h"


@interface InviteFriendCell : UITableViewCell

@property(nonatomic,strong)UIImageView *friendPhotoImageView;
@property(nonatomic,strong)UILabel *friendNameLabel;
@property(nonatomic,strong)UIButton *inviteButton;

@property (nonatomic,strong)InviteFriend *inviteFriendList;

@end
