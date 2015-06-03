//
//  MyDynamicViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "MyDynamicViewController.h"
#import "SMS_MBProgressHUD.h"
#import "MyDynamic.h"


@interface MyDynamicViewController ()

@end

@implementation MyDynamicViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMydynameic];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
}

-(void)getMydynameic{

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"user_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [MyDynamic getMyDynamic:dic WithBlock:^(MyDynamic *myDynamic, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        _myDynamicWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -42, WIDTH, HEIGHT+65)];
        _myDynamicWebView.delegate = self;

        NSURL *url=[NSURL URLWithString: myDynamic.dynamic_url];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        [_myDynamicWebView loadRequest:request];
        [_myDynamicWebView setUserInteractionEnabled:YES];
        [self.view addSubview:_myDynamicWebView];
        
    }];
    
}

//网页 刚开始加载
- (void)webViewDidStartLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

//网页 加载完成
- (void)webViewDidFinishLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];
}

-(void)doBack{
    
    if (_myDynamicWebView.canGoBack)
    {
        [_myDynamicWebView goBack];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
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
