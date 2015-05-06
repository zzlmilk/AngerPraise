//
//  InterviewPayViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "InterviewPayViewController.h"
#import "InterviewPayWebViewController.h"


@interface InterviewPayViewController ()

@end

@implementation InterviewPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"13"]];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
 
    UILabel *stayReviewLabel = [[UILabel alloc]init];
    stayReviewLabel.frame = CGRectMake(20, backBtn.frame.size.height+backBtn.frame.origin.y+30, WIDTH, 35);
    stayReviewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    stayReviewLabel.backgroundColor = [UIColor clearColor];
    stayReviewLabel.text = @"投递记录";
    [self.view addSubview:stayReviewLabel];
    
    UILabel *stayReviewTipLabel = [[UILabel alloc]init];
    stayReviewTipLabel.frame = CGRectMake(20, stayReviewLabel.frame.size.height+stayReviewLabel.frame.origin.y-10, WIDTH, 35);
    stayReviewTipLabel.textColor = [UIColor grayColor];
    stayReviewTipLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    stayReviewTipLabel.backgroundColor = [UIColor clearColor];
    stayReviewTipLabel.text = @"您可以在此查看并申请提供面试补贴的公司";
    [self.view addSubview:stayReviewTipLabel];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(15, stayReviewTipLabel.frame.size.height+stayReviewTipLabel.frame.origin.y+1, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel];
    
//    _interviewPayTableView = [[UITableView alloc]init];
//    _interviewPayTableView.frame = CGRectMake(0, lineLabel.frame.size.height+lineLabel.frame.origin.y+1, WIDTH,HEIGHT);
//    _interviewPayTableView.delegate = self;
//    _interviewPayTableView.dataSource = self;
//    [self.view addSubview:_interviewPayTableView];
//    
//    [self setExtraCellLineHidden:_interviewPayTableView];
    
}

-(void)doBack{

    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _interviewPayArray.count;
}


//隐藏多余分割线
//-(void)setExtraCellLineHidden: (UITableView *)tableView
//{
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [tableView setTableFooterView:view];
//}
//


//#pragma mark -- UITableView dataSource
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    static NSString *cellId = @"cellId";
//    
//    InterviewPayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    
//    InterviewPay *i = [_interviewPayArray objectAtIndex:indexPath.row];
//    
//    cell.interviewPayList = i;
//    
//    if (cell == nil)
//    {
//        cell = [[InterviewPayCell alloc] initWithStyle:UITableViewCellStyleSubtitle
//                                       reuseIdentifier:cellId];
//    }
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;
//}
//
//
//#pragma mark -- UITableView height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 150.f;
//}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
//    InterviewPay * p = [_interviewPayArray objectAtIndex:indexPath.row];
    
//    PositionDetailViewController *positionDetailVC = [[PositionDetailViewController alloc]init];
//    positionDetailVC.positionDetailUrl = p.webUrl;
//    [self.navigationController pushViewController:positionDetailVC animated:YES];
    
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
