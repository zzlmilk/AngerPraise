//
//  VirtualImportViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/3/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "VirtualImportViewController.h"
#import "MYBlurIntroductionView.h"
#import "MYIntroductionPanel.h"

#import "NeedDataViewController.h"
#import "ApIClient.h"
#import "MarkViewController.h"

@interface VirtualImportViewController ()

@end

@implementation VirtualImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"虚拟投放";

    _virtuaImportlWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _virtuaImportlWebView.delegate = self;
    NSURL *url=[NSURL URLWithString:@"http://m.51job.com/my/login.php"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_virtuaImportlWebView loadRequest:request];
    [_virtuaImportlWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_virtuaImportlWebView];
    
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(importResume)];

    self.navigationItem.rightBarButtonItem = saveItem;
    
    
    
    //Create stock panel with header
    
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"操作步骤如图所示:第一步 输入51job账号登录." image:[UIImage imageNamed:@"pic1"]];
    
    //Create stock panel with image
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第二步 在职位名栏目中搜索“虚拟职位”" image:[UIImage imageNamed:@"pic2"]];
    
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第三步 正确选择我们提供的虚拟职位" image:[UIImage imageNamed:@"pic3"]];
    
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@" " description:@"第四步 点击“申请”完成简历的虚拟投递" image:[UIImage imageNamed:@"pic4"]];

    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
   // introductionView.backgroundColor =RGBACOLOR(246, 248, 238, 1.0f);
    introductionView.backgroundColor = [UIColor whiteColor];
    //Add panels to an array
    NSArray *panels = @[panel1, panel2, panel3,panel4];
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
    

    _secondsCountDown = 8;//8秒倒计时
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
}

#pragma mark -- 导入简历
-(void)importResume{
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *lHtml1 = [_virtuaImportlWebView stringByEvaluatingJavaScriptFromString:lJs];
    
    NSLog(@"%@",lHtml1);
    
}

#pragma mark -- 计时器执行方法
-(void)timeFireMethod{
    _secondsCountDown--;
    if(_secondsCountDown==0){
        [_countDownTimer invalidate];
        
//        [APIClient showMessage:@"您已投递成功"];
//        
//        MarkViewController *markVC = [[MarkViewController alloc]init];
//        [self.navigationController pushViewController:markVC animated:YES];
        
    }
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
