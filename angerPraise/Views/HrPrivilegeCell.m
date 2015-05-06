//
//  HrPrivilegeCell.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HrPrivilegeCell.h"
#import "UIImageView+AFNetworking.h"


@implementation HrPrivilegeCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _applyPhotoImageView = [[UIImageView alloc]init];
        _applyPhotoImageView.frame = CGRectMake(20, 15, 70, 70);
        //_applyPhotoImageView.image = [UIImage imageNamed:@"exampleProfile"];
        [self addSubview:_applyPhotoImageView];
        
        _applyNameLabel = [[UILabel alloc]init];
        _applyNameLabel.frame = CGRectMake(_applyPhotoImageView.frame.size.width+_applyPhotoImageView.frame.origin.x+20, 15, 120, 70);
//        _applyNameLabel.text = @"王小二";
        _applyNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_applyNameLabel];
        
//        _isReviewLabel = [[UILabel alloc]init];
//        _isReviewLabel.frame = CGRectMake(_applyNameLabel.frame.origin.x+_applyNameLabel.frame.size.width, 15, 100, 70);
//        _isReviewLabel.text = @"可点评";
//        _isReviewLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:_isReviewLabel];
        
        
    }
    return self;
}

-(void)setHrPrivilegeList:(HrPrivilege *)hrPrivilegeList{

    _applyNameLabel.text = hrPrivilegeList.user_name;
    [_applyPhotoImageView setImageWithURL:[NSURL URLWithString:hrPrivilegeList.photo_url]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
