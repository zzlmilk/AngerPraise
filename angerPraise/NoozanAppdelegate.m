//
//  NoozanAppdelegate.m
//  angerPraise
//
//  Created by zhilingzhou on 15/6/29.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "NoozanAppdelegate.h"
#import "MCCore.h"

#import "MainViewController.h"
#import "IndexViewController.h"
#import "User.h"



@implementation NoozanAppdelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
   // [[UIApplication sharedApplication] setStatusBarHidden:YES];

    //注册mechat
    [self mechatRegister];
    
    //注册通知
    [self registerRemoteNotification];
    
    //微信 注册信息
    [WXApi registerApp:@"wx97dbb5b24f24c791"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    //[self clearUserInfo];
    
    NSString *user_id =[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    NSString *user_token =[[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    
    
    if (user_id && user_token) {
         _mainVC = [[MainViewController alloc]init];
        [self.window setRootViewController:_mainVC];
    }
    else{
        IndexViewController *indexVC = [[IndexViewController alloc]init];
        _loginNav = [[UINavigationController alloc]initWithRootViewController:indexVC];
        [self.window setRootViewController:_loginNav];
    }
    
   
    return YES;
}

-(void)getMainVC{
    
    if (!_mainVC) {        
        MainViewController *manVC = [[MainViewController alloc]init];
        _mainVC = manVC;
    }
    
    
    //[_mainVC.tabBarController setSelectedIndex:0];
    [self.window setRootViewController:_mainVC];
}

-(void)getIndexVC{
    
    IndexViewController *indexVC = [[IndexViewController alloc]init];
    _loginNav = [[UINavigationController alloc]initWithRootViewController:indexVC];
    
    [self.window setRootViewController:_loginNav];
}



#pragma mark -- 发送 token 和 deviceToken 及设备信息
-(void)sendDeviceInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceTokenString = [userDefaults objectForKey:USER_DEVIECTOKEN];
    
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];
    
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    
    [dic setObject:@"1" forKey:@"dict_device_id"];
    [dic setObject:deviceName forKey:@"device_name"];
    
    if (deviceTokenString!=nil) {
        
        [dic setObject:deviceTokenString forKey:@"device_id"];
        
    }else{
        
        [dic setObject:@"0" forKey:@"device_id"];
        
    }
    
    [User sendDeviceInfo:dic WithBlock:^(User *user, Error *e) {
        
    }];
    
}



-(void)clearUserInfo{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_TOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ACCOUNT];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_type"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"recommendPosition"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    _mainVC = nil;
}




+(NoozanAppdelegate*)getAppDelegate{
    return  (NoozanAppdelegate *)[UIApplication sharedApplication].delegate;
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
    if (NZ_DugSet) {
        NSLog(@"deviceToken:%@", _deviceToken);
    }
    
    NSUserDefaults *deviceTokenUserDefaults = [NSUserDefaults standardUserDefaults];
    [deviceTokenUserDefaults setObject:_deviceToken forKey:USER_DEVIECTOKEN];

    
    //_deviceToken 存本地，等用户注册账号成功之后把_deviceToken和Userid全部给后台
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //处理APN
    //NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    // 获取 server 返回值 进行页面跳转
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
    //用户不允许通知
    if (NZ_DugSet) {
        NSLog(@"用户不允许通知");
    }

    
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
