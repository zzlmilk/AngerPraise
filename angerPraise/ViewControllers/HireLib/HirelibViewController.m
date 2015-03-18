//
//  HirelibViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/18.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HirelibViewController.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface HirelibViewController ()

@end

@implementation HirelibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    self.title = @"HireLib";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
