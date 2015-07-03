//
//  HomeViewControllers.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "MainViewController.h"

//4个Tab
#import "ResumeViewController.h"
#import "UserViewController.h"
#import "PositionViewController.h"
#import "HomeViewController.h"


@implementation MainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeNav.tabBarItem.image = [UIImage imageNamed:@"0tabbar1"];
    homeNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    homeNav.tabBarItem.tag = 1;

    ResumeViewController *resumeVC = [[ResumeViewController alloc]init];
    UINavigationController *resumeNav = [[UINavigationController alloc]initWithRootViewController:resumeVC];
    resumeNav.tabBarItem.image = [UIImage imageNamed:@"0tabbar2"];
    resumeNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    resumeNav.tabBarItem.tag = 2;
    
    PositionViewController *posotionVC = [[PositionViewController alloc]init];
     UINavigationController *posotionNav = [[UINavigationController alloc]initWithRootViewController:posotionVC];
    posotionNav.tabBarItem.image = [UIImage imageNamed:@"0tabbar3"];
    posotionNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    posotionNav.tabBarItem.tag = 3;
    
    UserViewController *userVC = [[UserViewController alloc]init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userVC];
    userNav.tabBarItem.image = [UIImage imageNamed:@"0tabbar4"];
    userNav.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    userNav.tabBarItem.tag = 4;
    
    
    homeVC.delegate = userVC;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeNav,resumeNav,posotionNav,userNav, nil];
    
    self.viewControllers =viewControllers;
    
 
//    self.delegate = self;
    self.tabBar.translucent = NO;
    self.tabBar.alpha = 1.0f;
    self.tabBar.tintColor = RGBACOLOR(255, 255, 255, 1.0f);
    self.tabBar.barTintColor = RGBACOLOR(20, 20, 20, 1.0f);
    self.tabBar.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
    
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //我先判断用户有没有简历
    //怎么判断 根据用户的token 
    
//    if (item.tag == 3) {
//        PositionViewController *positionVC  = [[PositionViewController alloc] init];
//        [positionVC getPositionInfo];
//    }
    
    
}

@end
