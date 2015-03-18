//
//  HomeViewControllers.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeViewControllers.h"
#import "ImportResumeViewController.h"
#import "UserViewController.h"
#import "HirelibViewController.h"

@implementation HomeViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor yellowColor];
    
    ImportResumeViewController *resumeVC = [[ImportResumeViewController alloc]init];
    UINavigationController *resumeNav = [[UINavigationController alloc]initWithRootViewController:resumeVC];
    resumeNav.title =@"简历";
    resumeNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    
    HirelibViewController *hirelibVC = [[HirelibViewController alloc]init];
    UINavigationController *hirelibNav = [[UINavigationController alloc]initWithRootViewController:hirelibVC];
    hirelibNav.title = @"HireLib";
    hirelibNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    
    UserViewController *userVC = [[UserViewController alloc]init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userVC];
    userNav.title = @"个人中心";
    userNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects:resumeNav,hirelibNav,userNav, nil];
    
    self.viewControllers =viewControllers;
    
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor whiteColor];

    
}

@end
