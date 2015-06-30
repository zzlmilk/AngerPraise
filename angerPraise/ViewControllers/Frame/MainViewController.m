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
    homeVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar1"];
    homeVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    homeVC.tabBarItem.tag = 1;

<<<<<<< HEAD
=======
    
    
>>>>>>> 3029c53fe6a14750fb13615fc55abc46f3b2a847
    ResumeViewController *resumeVC = [[ResumeViewController alloc]init];
    resumeVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar2"];
    resumeVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    resumeVC.tabBarItem.tag = 2;
    
    PositionViewController *posotionVC = [[PositionViewController alloc]init];
    posotionVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar3"];
    posotionVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    posotionVC.tabBarItem.tag = 3;
    
    UserViewController *userVC = [[UserViewController alloc]init];
    userVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar4"];
    userVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    userVC.tabBarItem.tag = 4;
<<<<<<< HEAD
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeVC,resumeVC,posotionVC,userVC, nil];
    
    self.viewControllers =viewControllers;
    
=======

    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeVC,resumeVC,posotionVC,userVC, nil];
    
    
    self.viewControllers =viewControllers;
>>>>>>> 3029c53fe6a14750fb13615fc55abc46f3b2a847
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
    
    if (item.tag == 2) {
        ResumeViewController *resumeVC  = [[ResumeViewController alloc] init];
        [resumeVC getresumeInfo];
    }
    if (item.tag == 3) {
        PositionViewController *positionVC  = [[PositionViewController alloc] init];
        [positionVC getPositionInfo];
    }
    
}

@end
