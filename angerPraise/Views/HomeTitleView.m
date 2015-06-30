//
//  HomeTitleView.m
//  angerPraise
//
//  Created by zhilingzhou on 15/6/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeTitleView.h"

@implementation HomeTitleView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = RGBACOLOR(40, 40, 40, 1.0f);
    
    //为什么是按钮
    UIButton *titleButton= [[UIButton alloc]init];
    titleButton.frame = CGRectMake((WIDTH-118/2)/2, 15, 118/2, 38/2);
    [titleButton setTitle:@"怒         赞" forState:UIControlStateNormal];
    [titleButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [titleButton setTitleColor:RGBACOLOR(177, 179, 180, 1.0f) forState:UIControlStateNormal];
    titleButton.backgroundColor = [UIColor clearColor];
    [self addSubview:titleButton];

    
    UIImageView *titleLogoImageView = [[UIImageView alloc]init];
    titleLogoImageView.frame =titleButton.frame;
    titleLogoImageView.image = [UIImage imageNamed:@"0logoathomepage"];
    titleLogoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLogoImageView];

    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
