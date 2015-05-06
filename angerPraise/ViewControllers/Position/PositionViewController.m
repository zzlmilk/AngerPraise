//
//  PositionViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/8.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "PositionViewController.h"
#import "PositionListCell.h"
#import "Position.h"
#import "PositionDetailViewController.h"
#import "SMS_MBProgressHUD.h"
#import "MJRefresh.h"


@interface PositionViewController ()

@end

static CGFloat kImageOriginHight = 150.f;

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _page = 1;
    
    _positionTableView = [[UITableView alloc]init];
    _positionTableView.frame = CGRectMake(0,0, WIDTH,HEIGHT);
    _positionTableView.delegate = self;
    _positionTableView.dataSource = self;
    
    _positionTableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    _expandZoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image1"]];
    //  _expandZoomImageView.contentMode = UIViewContentModeRedraw;
    _expandZoomImageView.frame = CGRectMake(0, 0, WIDTH, kImageOriginHight);
    
    UILabel *positionNameLabel = [[UILabel alloc]init];
    positionNameLabel.frame = CGRectMake(8, 5, 300, 30);
    positionNameLabel.text = @"PHP工程师";
    positionNameLabel.font =  [UIFont fontWithName:@"Helvetica" size:26.f];
    positionNameLabel.textColor = [UIColor whiteColor];
    positionNameLabel.backgroundColor = [UIColor clearColor];
    
    UILabel *describeLabel = [[UILabel alloc]init];
    describeLabel.frame = CGRectMake(11, positionNameLabel.frame.origin.y+positionNameLabel.frame.size.height-5, 200, 20);
    describeLabel.text = @"推荐的职位名称";
    describeLabel.textColor = [UIColor whiteColor];
    describeLabel.backgroundColor = [UIColor clearColor];
    describeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.f];
    [_expandZoomImageView addSubview:describeLabel];
    [_expandZoomImageView addSubview:positionNameLabel];
    [_positionTableView addSubview:_expandZoomImageView];
    
    [self.view addSubview:_positionTableView];
    
    
    [self getPositionInfo];

    [_positionTableView addLegendFooterWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [self getMorePositionInfo];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.expandZoomImageView.frame = CGRectMake(0, -kImageOriginHight, _positionTableView.frame.size.width, kImageOriginHight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //CGFloat yOffset  = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y < -kImageOriginHight) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = scrollView.contentOffset.y;
        f.size.height =  -scrollView.contentOffset.y;
        self.expandZoomImageView.frame = f;
    }
    
    
    int currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion - _lastPosition > 0  && currentPostion > 0) {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = YES;
        
    }
    
    else if ((_lastPosition - currentPostion > 0) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height) )
    {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = NO;
        
    }
}


//获取推荐职位列表
-(void)getPositionInfo{

    _pageString =  [[NSString alloc] initWithFormat:@"%d",_page];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"PHP" forKey:@"keyword"];
    [dic setObject:_pageString forKey:@"page"];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@"1" forKey:@"user_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Position getPositionList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {

        _positionListArray = positionArray;
        [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];
        [_positionTableView reloadData];
        
    }];
    _page++;

}

//职位列表 上提 加载更多
-(void)getMorePositionInfo{
    
    _pageString =  [[NSString alloc] initWithFormat:@"%d",_page];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"PHP" forKey:@"keyword"];
    [dic setObject:_pageString forKey:@"page"];
    [dic setObject:@"1" forKey:@"type"];
    [dic setObject:@"1" forKey:@"user_id"];
    
     [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Position getPositionList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [_positionListArray addObjectsFromArray:positionArray];
        
        [_positionTableView reloadData];
        
    }];
    
    _page++;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _positionListArray.count;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    PositionListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    Position *p = [_positionListArray objectAtIndex:indexPath.row];
    
    cell.positionList = p;
    
    if (cell == nil)
    {
        cell = [[PositionListCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150.f;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    Position * p = [_positionListArray objectAtIndex:indexPath.row];
    
    PositionDetailViewController *positionDetailVC = [[PositionDetailViewController alloc]init];
    positionDetailVC.positionDetailUrl = p.webUrl;
    [self.navigationController pushViewController:positionDetailVC animated:YES];
    
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
