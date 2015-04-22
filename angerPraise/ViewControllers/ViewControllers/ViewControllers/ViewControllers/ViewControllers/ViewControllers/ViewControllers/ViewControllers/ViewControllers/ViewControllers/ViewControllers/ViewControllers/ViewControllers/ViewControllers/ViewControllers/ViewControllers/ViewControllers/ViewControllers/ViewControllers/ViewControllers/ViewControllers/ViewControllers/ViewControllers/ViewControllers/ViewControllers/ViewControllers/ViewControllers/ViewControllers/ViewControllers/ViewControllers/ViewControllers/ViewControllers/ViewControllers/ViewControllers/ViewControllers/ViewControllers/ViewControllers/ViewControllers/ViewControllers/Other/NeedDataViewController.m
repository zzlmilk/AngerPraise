//
//  NeedDataViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "NeedDataViewController.h"

@interface NeedDataViewController ()

@end

@implementation NeedDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"完善资料";
    
    _needDataWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _needDataWebView.delegate=self;
    [self.view addSubview:_needDataWebView];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"questionnaire" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_needDataWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
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
