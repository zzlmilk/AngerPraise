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
#import "HomeOldViewController.h"
#import "HomeViewController.h"
#import "DSNavigationBar.h"


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    //self.view.backgroundColor = [UIColor yellowColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
//    homeVC.title =@"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar1"];
    homeVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    homeVC.tabBarItem.tag = 1;

    
    ResumeViewController *resumeVC = [[ResumeViewController alloc]init];
//    resumeVC.title =@"简历";
    resumeVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar2"];
    resumeVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    resumeVC.tabBarItem.tag = 2;
    
    
    PositionViewController *posotionVC = [[PositionViewController alloc]init];
//    posotionVC.title = @"职位";
    posotionVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar3"];
    posotionVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    posotionVC.tabBarItem.tag = 3;
    
    UserViewController *userVC = [[UserViewController alloc]init];
//    userVC.title = @"我的";
    userVC.tabBarItem.image = [UIImage imageNamed:@"0tabbar4"];
    userVC.tabBarItem.imageInsets=UIEdgeInsetsMake(5, 0,-5, 0);
    userVC.tabBarItem.tag = 4;
//    userVC.tabBarItem.badgeValue = @"3";
    //userVC.tabBarItem.badgeValue = nil;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeVC,resumeVC,posotionVC,userVC, nil];
    
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

    switch (item.tag) {
        case 1:
        {
            HomeViewController *homeVC  = [[HomeViewController alloc] init];
            self.delegate =  homeVC;
            
            [self.delegate homeItemSelected];
        }
            break;
        case 2:
        {
            ResumeViewController *resumeVC  = [[ResumeViewController alloc] init];
            self.delegate = resumeVC;
            
            [self.delegate resumeItemSelected];
        }
            break;
        case 3:
        {
            PositionViewController *positionVC  = [[PositionViewController alloc] init];
            self.delegate = positionVC;
            
            [self.delegate positionItemSelected];
        }
            break;
        case 4:
        {
            UserViewController *userVC  = [[UserViewController alloc] init];
            self.delegate = userVC;
            
            [self.delegate userItemSelected];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)homeItemSelected{};
- (void)resumeItemSelected{};
- (void)userItemSelected{};
- (void)positionItemSelected{};



@end
