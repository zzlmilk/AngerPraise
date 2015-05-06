//
//  InviteFriendCell.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "InviteFriendCell.h"
#import "InviteFriendViewController.h"

@implementation InviteFriendCell

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
        _friendPhotoImageView.image = [UIImage imageNamed:@"exampleProfile"];
        [self addSubview:_friendPhotoImageView];
        
        _friendNameLabel = [[UILabel alloc]init];
        _friendNameLabel.frame = CGRectMake(_friendPhotoImageView.frame.size.width+_friendPhotoImageView.frame.origin.x+20, 15, 120, 70);
        _friendNameLabel.text = @"王小二";
        _friendNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_friendNameLabel];
        
        
    }
    return self;
}


-(void)setInviteFriendList:(InviteFriend *)inviteFriendList{

    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
