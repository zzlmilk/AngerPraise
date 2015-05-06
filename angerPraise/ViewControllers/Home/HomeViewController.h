//
//  HomeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface HomeViewController : BaseViewController<ABPeoplePickerNavigationControllerDelegate>

@property(nonatomic,strong)UIView *resumeScoreView;
@property(nonatomic,strong)UILabel *resumeScoreData;
@property(nonatomic,strong)UILabel *resumeScoreUrlLabel;

@property(nonatomic,strong)UIView *myDynamicInfoView;

@property(nonatomic,strong)UIView *commentFriendView;
@property(nonatomic,strong)UILabel *commentFriendData;

@property(nonatomic,strong)UIView *interviewPayView;
@property(nonatomic,strong)UILabel *interviewPayData;

@property(nonatomic,strong)UIView *hrPrivilegeView;
@property(nonatomic,strong)UILabel *hrPrivilegeData;

@end
