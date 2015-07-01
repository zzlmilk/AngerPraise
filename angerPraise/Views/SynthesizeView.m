//
//  SynthesizeView.m
//  angerPraise
//
//  Created by zhilingzhou on 15/7/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "SynthesizeView.h"

@implementation SynthesizeView

-(id)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    
    
    UIImageView *primaryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"0blue_circle"]];
    
    
    UIImageView *profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"0blue_add"]];
    
    [self setPrimaryView: primaryView];
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.frame = CGRectMake(0, 0, primaryView.frame.size.width, primaryView.frame.size.height);
    _scoreLabel.text = @"25";
    _scoreLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    _scoreLabel.textColor = [UIColor whiteColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [primaryView addSubview:_scoreLabel];

    // self.touchBlock();
    
    
    [self setSecondaryView: profileView];
    
    //3.5秒旋转
    [self beginSpinTime:3.5];

    
    return self;
}

-(void)flipTouched:(id)sender{
    //重写
    
    
    if (self.touchBlock) {
        
        self.touchBlock();
    }
  
    
}



-(void)beginSpinTime:(float)spantime{
    [NSTimer scheduledTimerWithTimeInterval:spantime target:self selector:@selector(spanCoin) userInfo:nil repeats:YES];
    
}

-(void)spanCoin{
    [UIView transitionFromView:(displayingPrimary ? self.primaryView : self.secondaryView)
                        toView:(displayingPrimary ? self.secondaryView : self.primaryView)
                      duration: 1
                       options: UIViewAnimationOptionTransitionFlipFromLeft+UIViewAnimationOptionCurveEaseInOut
                    completion:^(BOOL finished) {
                        if (finished) {
                            //UIView *view = (displayingPrimary ? view1 : view2);
                            displayingPrimary = !displayingPrimary;
                        }
                    }
     ];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
