//
//  AppDelegate.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "MainViewController.h"
#import "MCCore.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


    // 判断token 如果存在 storyborder中 页面跳转到Home
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Main tabber 首页    
    UIStoryboard *storyBoard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //登陆注册首页
    UIStoryboard *storyBoard2 = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    if([token objectForKey:@"token"]){
        
        self.window.rootViewController = [storyBoard1 instantiateInitialViewController];
        
    }else{
        
        self.window.rootViewController = [storyBoard2 instantiateInitialViewController];
    }
    

    

    return YES;
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
      
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    //处理推送消息
}








@end
