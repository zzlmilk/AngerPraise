//
//  UserViewController.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "EditPhotoViewController.h"

@interface UserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *userTableView;

@property NSArray *modelListArray;

@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *hirelibNumberLabel;

@property(nonatomic,strong)UIImageView *userPhotoImageView;

@property(nonatomic,strong)NSString *user_type;

@property(nonatomic, strong)UIView *editView;
@property(nonatomic, strong)UIImageView *waitPhotoImageView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *waitUsernameLabel;


@property(nonatomic,strong)UILabel *matchPositionLabel;
@property(nonatomic,strong)UILabel *taskLabel;
@property(nonatomic,strong)UILabel *walletNumberLabel;

@property(nonatomic,strong)NSString *hr_url;
@property(nonatomic,strong)NSString *pay_url;
@property(nonatomic,strong)NSString *user_apply_url;
@property(nonatomic,strong)NSString *user_friend_url;

@end
