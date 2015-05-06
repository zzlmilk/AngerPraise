//
//  HrPrivilegeCell.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HrPrivilege.h"

@interface HrPrivilegeCell : UITableViewCell

@property(nonatomic,strong)UIImageView *applyPhotoImageView;
@property(nonatomic,strong)UILabel *applyNameLabel;
@property(nonatomic,strong)UILabel *isReviewLabel;

@property(nonatomic,strong)NSString *reviewUrlString;

@property (nonatomic,strong)HrPrivilege *hrPrivilegeList;

@end
