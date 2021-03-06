//
//  NoozanAppdelegate.h
//  angerPraise
//
//  Created by zhilingzhou on 15/6/29.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "WXApi.h"



@class MainViewController;
@interface NoozanAppdelegate : AppDelegate<WXApiDelegate>
{
  
}


@property(nonatomic,strong) MainViewController *mainVC;
@property (nonatomic,strong)UINavigationController *loginNav;

//清楚NSUsersDefault里面保存的用户信息
-(void) clearUserInfo;

+(NoozanAppdelegate*)getAppDelegate;
-(void)getMainVC;
-(void)getIndexVC;
-(void)sendDeviceInfo;


@end
