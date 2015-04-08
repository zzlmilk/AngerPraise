//
//  UserViewController.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "UserViewController.h"
#import "RKCardView.h"
#import "CheckQuestionViewController.h"


#define BUFFERX 5 //distance from side to the card (higher makes thinner card)
#define BUFFERY 10 //distance from top to the card (higher makes shorter card)
@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *personItem = [[UIBarButtonItem alloc]initWithTitle:@"好友评价" style:UIBarButtonItemStylePlain target:self action:@selector(friendEvaluate)];
    self.navigationItem.rightBarButtonItem = personItem;
    
    
    self.title = @"个人中心";
    
    RKCardView* cardView= [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    
    cardView.backgroundColor = [UIColor yellowColor];
    
    cardView.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    cardView.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    cardView.titleLabel.text = @"王小二";
    //    [cardView addBlur];
    //    [cardView addShadow];
    [self.view addSubview:cardView];
//    
//    _radarWebView=[[UIWebView alloc] initWithFrame:CGRectMake(cardView.frame.origin.x-10, cardView.frame.origin.y+200, self.view.frame.size.width-60, 240)];
//    _radarWebView.delegate=self;
//    [cardView addSubview:_radarWebView];
//    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"radar" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [_radarWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    
}

#pragma mark -- 好友评价
-(void)friendEvaluate{
    CheckQuestionViewController *checkQuestionVC = [[CheckQuestionViewController alloc]init];
    
    [self.navigationController pushViewController:checkQuestionVC animated:YES];
    
}


@end
