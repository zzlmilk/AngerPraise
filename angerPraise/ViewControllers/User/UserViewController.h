//
//  UserViewController.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HomeViewController.h"

@interface UserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,HomeViewControllerDelegate>
{
    User *user;
}


@property(nonatomic,strong)UIView *cardView;

@property(nonatomic,strong)UIButton *taskButton;

@property(nonatomic,strong)UITableView *userTableView;

@property NSArray *modelListArray;

@property __block int timeout;

@property(nonatomic,strong)UIButton *userNameButton;
@property(nonatomic,strong)UILabel *hirelibNumberLabel;

@property(nonatomic,strong)UIImageView *userPhotoImageView;

@property(nonatomic,strong)NSString *user_type;

@property(nonatomic, strong)UIView *editView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *waitUsernameLabel;

@property(nonatomic,strong)UILabel *matchPositionLabel;
@property(nonatomic,strong)UILabel *taskLabel;
@property(nonatomic,strong)UILabel *walletNumberLabel;

@property(nonatomic,strong)NSString *hr_url;
@property(nonatomic,strong)NSString *pay_url;
@property(nonatomic,strong)NSString *user_apply_url;
@property(nonatomic,strong)NSString *user_friend_url;


@property(nonatomic,strong)UIImage *savedImage;


//修改名称
@property(nonatomic, strong)UIView *editNameView;

@property(nonatomic,strong)UITextField *editNameTextField;

@end
