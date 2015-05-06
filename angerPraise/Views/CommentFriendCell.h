//
//  CommentFriendCell.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentFriend.h"

@interface CommentFriendCell : UITableViewCell

@property(nonatomic,strong)UIImageView *friendPhotoImageView;
@property(nonatomic,strong)UILabel *friendNameLabel;
@property(nonatomic,strong)UILabel *isReviewLabel;
@property(nonatomic,strong)NSString *reviewUrlString;

@property(nonatomic,strong)CommentFriend *commentFriendList;

@end
