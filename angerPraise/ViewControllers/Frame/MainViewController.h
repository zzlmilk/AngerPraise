//
//  HomeViewControllers.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController<UITabBarControllerDelegate>

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end
