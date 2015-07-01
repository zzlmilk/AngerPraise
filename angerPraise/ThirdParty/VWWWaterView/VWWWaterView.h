//
//  VWWWaterView.h
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWWWaterView : UIView

{
    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    
    float a;
    float b;
    BOOL jia;
}
//设置水位高度
-(void)setCurrentLinePointY:(float)h;

@end
