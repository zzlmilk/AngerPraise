//
//  HrPrivilegeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HrPrivilegeViewController.h"
#import "HrPrivilegeWebViewController.h"
#import "HrPrivilegeCell.h"
#import "HrPrivilege.h"
#import "SMS_MBProgressHUD.h"

@interface HrPrivilegeViewController ()

@end

@implementation HrPrivilegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hrReviewAppaly];
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
    stayReviewLabel.text = @"待点评的应聘者";
    [self.view addSubview:stayReviewLabel];
    
    UILabel *stayReviewTipLabel = [[UILabel alloc]init];
    stayReviewTipLabel.frame = CGRectMake(20, stayReviewLabel.frame.size.height+stayReviewLabel.frame.origin.y-10, WIDTH, 35);
    stayReviewTipLabel.textColor = [UIColor grayColor];
    stayReviewTipLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    stayReviewTipLabel.backgroundColor = [UIColor clearColor];
    stayReviewTipLabel.text = @"您的点评可以获得4倍红包";
    [self.view addSubview:stayReviewTipLabel];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(15, stayReviewTipLabel.frame.size.height+stayReviewTipLabel.frame.origin.y+1, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel];

    
    _hrPrivilegeTableView = [[UITableView alloc]init];
    _hrPrivilegeTableView.frame = CGRectMake(0, lineLabel.frame.size.height+lineLabel.frame.origin.y+1, WIDTH,HEIGHT);
    _hrPrivilegeTableView.delegate = self;
    _hrPrivilegeTableView.dataSource = self;
    [self.view addSubview:_hrPrivilegeTableView];
    
    [self setExtraCellLineHidden:_hrPrivilegeTableView];

}


-(void)hrReviewAppaly{

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"token"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [HrPrivilege hrReviewAppalyList:dic WithBlock:^(NSMutableArray *hrReviewAppalyArray, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
//        [_hrPrivilegeArray addObjectsFromArray:hrReviewAppalyArray];
        
        _hrPrivilegeArray = hrReviewAppalyArray;
        [_hrPrivilegeTableView reloadData];
        
    }];



}

//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hrPrivilegeArray.count;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId = @"cellId";
    
    HrPrivilegeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    HrPrivilege *h = [_hrPrivilegeArray objectAtIndex:indexPath.row];
    
    cell.hrPrivilegeList = h;
    
    if (cell == nil)
    {
        cell = [[HrPrivilegeCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.f;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    HrPrivilege *h = [_hrPrivilegeArray objectAtIndex:indexPath.row];
    
    HrPrivilegeWebViewController *hrPrivilegeWebVC = [[HrPrivilegeWebViewController alloc]init];
    hrPrivilegeWebVC.hrPrivilegeUrl = h.interview_url;
    [self.navigationController pushViewController:hrPrivilegeWebVC animated:YES];
    
}



-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
