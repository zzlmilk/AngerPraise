//
//  HomeViewControllers.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "MainViewController.h"
#import "ResumeViewController.h"
#import "UserViewController.h"
#import "PositionViewController.h"
#import "HomeViewController.h"

#import "DSNavigationBar.h"


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor yellowColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.title =@"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home1"];

    
    ResumeViewController *resumeVC = [[ResumeViewController alloc]init];
    resumeVC.title =@"简历";
    resumeVC.tabBarItem.image = [UIImage imageNamed:@"resume_tabBar1"];
    
    
    PositionViewController *posotionVC = [[PositionViewController alloc]init];
    posotionVC.title = @"职位";
    posotionVC.tabBarItem.image = [UIImage imageNamed:@"zhiwei1"];
    
    
    UserViewController *userVC = [[UserViewController alloc]init];
    userVC.title = @"我的";
    userVC.tabBarItem.image = [UIImage imageNamed:@"wode1"];
//    userVC.tabBarItem.badgeValue = @"3";
    //userVC.tabBarItem.badgeValue = nil;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeVC,resumeVC,posotionVC,userVC, nil];
    
    self.viewControllers =viewControllers;
    
    self.delegate = self;
    
    self.tabBar.translucent = NO;
    self.tabBar.alpha = 0.7f;
    self.tabBar.tintColor = RGBACOLOR(75, 90, 248, 1.0f);
    self.tabBar.barTintColor = RGBACOLOR(255, 255, 255, 0.7f);
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
}

@end
