//
//  ResumeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ResumeViewController.h"
#import "ResumeScore.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"简历";
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    
    [ResumeScore getResumeScoer:dic WithBlock:^(ResumeScore *resumeScoer, Error *e) {
       
        
    }];
    
    
    
    
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
