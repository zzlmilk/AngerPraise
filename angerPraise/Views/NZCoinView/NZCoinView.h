//
//  NZCoinView.h
//  angerPraise
//
//  Created by zhilingzhou on 15/7/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZCoinView : UIView
{
    bool displayingPrimary;

}
- (id) initWithPrimaryView: (UIView *) view1 andSecondaryView: (UIView *) view2 inFrame: (CGRect) frame;

@property (nonatomic, strong) UIView *primaryView;
@property (nonatomic, strong) UIView *secondaryView;
@property float spinTime; //动画时间



@end
