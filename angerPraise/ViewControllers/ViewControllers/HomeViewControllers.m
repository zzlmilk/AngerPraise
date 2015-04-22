//
//  HomeViewControllers.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeViewControllers.h"
#import "ResumeViewController.h"
#import "UserViewController.h"
#import "PositionViewController.h"

@implementation HomeViewControllers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor yellowColor];
    
    ResumeViewController *resumeVC = [[ResumeViewController alloc]init];
    UINavigationController *resumeNav = [[UINavigationController alloc]initWithRootViewController:resumeVC];
    resumeNav.title =@"简历";
    resumeNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    PositionViewController *posotionVC = [[PositionViewController alloc]init];
    UINavigationController *posotionNav = [[UINavigationController alloc]initWithRootViewController:posotionVC];
    posotionNav.title = @"职位";
    posotionNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    UserViewController *userVC = [[UserViewController alloc]init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userVC];
    userNav.title = @"我的";
    userNav.tabBarItem.image = [UIImage imageNamed:@"avatar_placeholder"];
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects:resumeNav,posotionNav,userNav, nil];
    
    self.viewControllers =viewControllers;
    
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor whiteColor];

    
}

@end
