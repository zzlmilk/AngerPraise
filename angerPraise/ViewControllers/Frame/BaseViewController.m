//
//  BaseViewController.m
//  SyjRedess
//
//  Created by rex on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont systemFontOfSize:19.f];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;           
    }
    
    titleView.text = title;
    [titleView sizeToFit];
    

}

-(void)loadData{
    // 子类重写
}


-(void)doBack{
    
  
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadView{
    [super loadView];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 1.0f);
    
//    self.navigationController.navigationBar.backgroundColor = RGBACOLOR(1, 0, 0, 1);
    self.navigationController.navigationBar.translucent = NO;
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    if (![self isEqual:[self.navigationController.viewControllers objectAtIndex:0]] && self.navigationController!=nil) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 44, 44);
        [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
        backBtn.backgroundColor = [UIColor clearColor];
        [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
       
        NSLog(@"%@",self.tabBarController);
        
    }
    else{
        
       
        
    }
    
   
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
