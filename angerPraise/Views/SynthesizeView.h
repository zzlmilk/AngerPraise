//
//  SynthesizeView.h
//  angerPraise
//
//  Created by zhilingzhou on 15/7/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZCoinView.h"


typedef void (^TouchBlock)();


@interface SynthesizeView : NZCoinView

@property(nonatomic,strong) UILabel *scoreLabel;

@property (nonatomic,copy)TouchBlock touchBlock;



//自定义



//多少秒旋转一次
-(void)beginSpinTime:(float)spantime;
-(void) flipTouched:(id)sender;



@end
