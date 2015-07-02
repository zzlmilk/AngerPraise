//
//  CommentFriendCell.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CommentFriendCell.h"
#import "UIImageView+SYJImageCache.h"
#import "CommentFriend.h"

@implementation CommentFriendCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _friendPhotoImageView = [[UIImageView alloc]init];
        _friendPhotoImageView.frame = CGRectMake(20, 15, 70, 70);
//        _friendPhotoImageView.image = [UIImage imageNamed:@"exampleProfile"];
        [_friendPhotoImageView setImageWithURL:[NSURL URLWithString:@"http://61.174.13.143/photo/12.jpg"]];
        
        [_friendPhotoImageView setImageWithURL:[NSURL URLWithString:@"http://61.174.13.143/photo/14.jpg"] placeholderImage:[UIImage imageNamed:@"user_avatar_default"]];
        [self addSubview:_friendPhotoImageView];
        
        _friendNameLabel = [[UILabel alloc]init];
        _friendNameLabel.frame = CGRectMake(_friendPhotoImageView.frame.size.width+_friendPhotoImageView.frame.origin.x+20, 15, 120, 70);
        _friendNameLabel.text = @"zxp";
        _friendNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_friendNameLabel];
        
        _isReviewLabel = [[UILabel alloc]init];
        _isReviewLabel.frame = CGRectMake(_friendNameLabel.frame.origin.x+_friendNameLabel.frame.size.width, 15, 100, 70);
        _isReviewLabel.text = @"可点评";
        _isReviewLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_isReviewLabel];
        
    }
    return self;
}


-(void)setCommentFriendList:(CommentFriend *)commentFriendList{

    NSLog(@"%@",commentFriendList);

}

//-(void)setCommentFriendList:(CommentFriend *)commentFriendList{
//    
//    _friendNameLabel.text = commentFriendList.user_name;
//    [_friendPhotoImageView setImageWithURL:[NSURL URLWithString:commentFriendList.friend_evluation_url]];
//    
//    if ([commentFriendList.friend_evluation_status isEqualToString:@"1"]) {
//        
//        _isReviewLabel.text = @"可点评";
//        
//    }else{
//    
//        _isReviewLabel.text = @"已点评";
//        _isReviewLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
//        
//    }
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
