//
//  AppDelegate.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
@private
    UINavigationController *_naviController;
    NSString *_deviceToken;
}


@property (strong, nonatomic) UIWindow *window;




@end

