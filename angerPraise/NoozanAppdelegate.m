//
//  NoozanAppdelegate.m
//  angerPraise
//
//  Created by zhilingzhou on 15/6/29.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "NoozanAppdelegate.h"
#import "MCCore.h"



@implementation NoozanAppdelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    //注册mechat
    [self mechatRegister];
    
    
    //注册通知
    [self registerRemoteNotification];
    
    //微信 注册信息
    [WXApi registerApp:@"wx97dbb5b24f24c791"];
    
    
    
    return YES;
}


#pragma mark Notification
- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}


#pragma mark--- Mechat 注册mechat
-(void)mechatRegister{
    //美洽
    [MCCore initWithAppkey:@"558a5b764eae356666000003" expcetionDelegate:nil];
    NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];
    if (![userData objectForKey:@"cookie"]) {
        int random = (arc4random() % 99999) + 10000;
        [userData setObject:[NSString stringWithFormat:@"006600%qu%i",(unsigned long long)([[NSDate date] timeIntervalSince1970] * 1000),random] forKey:@"cookie"];
    }
    
    
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
   NSString* _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", _deviceToken);
    
    //_deviceToken 存本地，等用户注册账号成功之后把_deviceToken和Userid全部给后台
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
    //用户不允许通知
    NSLog(@"用户不允许通知");
    
}






#pragma mark --- WeiXin
//第二步 重写 两个方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}
#pragma mark ----end weixin----
@end
