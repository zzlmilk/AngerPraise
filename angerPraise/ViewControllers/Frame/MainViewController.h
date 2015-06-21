//
//  HomeViewControllers.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarItemSelectDelegate <NSObject>

- (void)homeItemSelected;
- (void)resumeItemSelected;
- (void)userItemSelected;
- (void)positionItemSelected;

@end

@interface MainViewController : UITabBarController<UITabBarControllerDelegate,TabBarItemSelectDelegate>

@property(strong,nonatomic) id<TabBarItemSelectDelegate> delegate;


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;


@end
