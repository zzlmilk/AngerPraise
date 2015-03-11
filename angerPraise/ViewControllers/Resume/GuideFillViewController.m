//
//  GuideFillViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "GuideFillViewController.h"
#import "MYBlurIntroductionView.h"
#import "MYIntroductionPanel.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


@interface GuideFillViewController ()

@end

@implementation GuideFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"引导填写";
    self.view.backgroundColor = RGBACOLOR(246, 248, 238, 1.0f);
    
    _guideImportlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _guideImportlWebView.delegate = self;
    NSURL *url=[NSURL URLWithString:@"http://m.51job.com/my/login.php"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_guideImportlWebView loadRequest:request];
    [_guideImportlWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_guideImportlWebView];
    
    //Create stock panel with header
    
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"操作步骤如图所示:第一步 输入51job账号登录." image:[UIImage imageNamed:@"pic1"]];
    
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第二步 按照引导逐步填写并完成简历信息" image:[UIImage imageNamed:@"pic_yindao"]];
    
    //Create stock panel with image
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第三步 在职位名栏目中搜索“虚拟职位”" image:[UIImage imageNamed:@"pic2"]];
    
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第四步 正确选择我们提供的虚拟职位" image:[UIImage imageNamed:@"pic3"]];
    
    MYIntroductionPanel *panel5 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第五步 点击“申请”完成简历的虚拟投递" image:[UIImage imageNamed:@"pic4"]];
    
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    // introductionView.backgroundColor =RGBACOLOR(246, 248, 238, 1.0f);
    introductionView.backgroundColor = [UIColor whiteColor];
    //Add panels to an array
    NSArray *panels = @[panel1, panel2, panel3,panel4,panel5];
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
    
    
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
