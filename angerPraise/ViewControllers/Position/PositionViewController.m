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
#import "ApIClient.h"
#import "ImportResumeViewController.h"


@interface PositionViewController ()

@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //_page = 1;
    self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
    _titleBgLabel = [[UILabel alloc]init];
    _titleBgLabel.frame = CGRectMake(0, 0, WIDTH, 44);
    _titleBgLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_titleBgLabel];
    
    _positionTableView = [[UITableView alloc]init];
    _positionTableView.frame = CGRectMake(0,0, WIDTH,HEIGHT);
    _positionTableView.delegate = self;
    _positionTableView.dataSource = self;
    _positionTableView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    _positionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_positionTableView];
    
    [self getPositionInfo];

//    __block PositionViewController *controller = self;
//    [_positionTableView addLegendFooterWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//
//        [controller getMorePositionInfo];
//
//    }];
    
    
    _tipView = [[UIView alloc]init];
    _tipView.frame = CGRectMake((WIDTH-235)/2, 0, 235, 59);
    _tipView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"0position"]];
    _tipView.hidden = YES;
    [self.view addSubview:_tipView];
    
    _recommondLabel = [[UILabel alloc]init];
    _recommondLabel.frame = CGRectMake(0, -3, _tipView.frame.size.width, _tipView.frame.size.height);
    _recommondLabel.textAlignment = NSTextAlignmentCenter;
    _recommondLabel.text = @"今日为你匹配12个职位";
    _recommondLabel.textColor =hl_black;
    _recommondLabel.font = [UIFont fontWithName:hlTextFont size:16.f];
    [_tipView addSubview:_recommondLabel];
    
    
    _searchView = [[UIView alloc]init];
    _searchView.frame = self.view.frame;
    _searchView.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
    _searchView.hidden = YES;
    [self.view addSubview:_searchView];
    
    _searchPositionTextField = [[UITextField alloc]initWithFrame:CGRectMake(20,30, WIDTH-2*20, 40)];
    _searchPositionTextField.returnKeyType = UITextBorderStyleBezel;
    [_searchPositionTextField setBorderStyle:UITextBorderStyleLine];
    _searchPositionTextField.delegate =self;
    _searchPositionTextField.layer.borderColor=[RGBACOLOR(0, 199, 255, 1.0f)CGColor];
    [_searchPositionTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchPositionTextField.hidden = YES;
    _searchPositionTextField.textColor = [UIColor whiteColor];
    _searchPositionTextField.layer.borderWidth = 1.0f;
//    [self.navigationController.navigationBar addSubview:_searchPositionTextField];
    [_searchView addSubview:_searchPositionTextField];
    _searchPositionPlaceholderlabel = [[UILabel alloc]init];
    _searchPositionPlaceholderlabel.frame = CGRectMake(10, 0, _searchPositionTextField.frame.size.width, 40);
    _searchPositionPlaceholderlabel.text = @"请输入职位关键字";
    _searchPositionPlaceholderlabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _searchPositionPlaceholderlabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
    [_searchPositionTextField addSubview:_searchPositionPlaceholderlabel];
    
    
    UIButton *advSearchButton = [[UIButton alloc]init];
    advSearchButton.frame = CGRectMake(0, _searchPositionTextField.frame.size.height+_searchPositionTextField.frame.origin.y+5, _searchView.frame.size.width, 30);
    advSearchButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [advSearchButton setTitleColor:RGBACOLOR(0, 199, 255, 1.0f)forState:UIControlStateNormal];
    advSearchButton.backgroundColor = [UIColor clearColor];
    [advSearchButton setTitle:@"高级搜索" forState:UIControlStateNormal];
    [_searchView addSubview:advSearchButton];
    
    
//    UIImageView *searchIcon = [[UIImageView alloc]init];
//    searchIcon.frame = CGRectMake(100, 2, 30, 38);
//    searchIcon.image = [UIImage imageNamed:@"0search"];
//    searchIcon.backgroundColor = [UIColor yellowColor];
//    [_searchPositionTextField addSubview:searchIcon];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_searchView addGestureRecognizer:tapGestureRecognizer];
    
    // 向上滑动
    UISwipeGestureRecognizer *oneFingerSwipeUp =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [_searchView addGestureRecognizer:oneFingerSwipeUp];
 
}

#pragma mark -- 手势事件监听
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [_searchView.layer addAnimation:animation forKey:nil];
    [_searchPositionTextField.layer addAnimation:animation forKey:nil];
    
    _searchView.hidden = YES;
    _searchPositionTextField.hidden = YES;
    _searchPositionTextField.hidden = YES;
    [_searchPositionTextField resignFirstResponder];
    
}

#pragma mark -- 手势向上滑动
- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    
    [self keyboardHide:nil];
}

- (void) textFieldDidChange:(UITextField *) TextField{
    
    _searchPositionPlaceholderlabel.hidden= YES;
    
}


// 显示推荐职位  动画
-(void)tipAnimation{

    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [_tipView.layer addAnimation:animation forKey:nil];
    
    _tipView.hidden = NO;

    [self hideTipAnimation];
}

// 使用计时器 隐藏动画
-(void)hideTipAnimation{

    __block int timeout=2; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置

                CATransition *animation = [CATransition animation];
                animation.type = kCATransitionFade;
                animation.duration = 0.2;
                [_tipView.layer addAnimation:animation forKey:nil];
                
                _tipView.hidden = YES;
                
            });
        }else{
            //            int minutes = timeout / 60;
            //int seconds = timeout % 60;
            //NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //CGFloat yOffset  = scrollView.contentOffset.y;
    
    int currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion < -44) {
    
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [_searchView.layer addAnimation:animation forKey:nil];
        [_searchPositionTextField.layer addAnimation:animation forKey:nil];
        
        //显示searchView 及其附属元素
        _searchView.hidden = NO;
        _searchPositionTextField.hidden = NO;
        [_searchPositionTextField becomeFirstResponder];
        _searchPositionPlaceholderlabel.hidden= NO;
        _searchPositionTextField.text = @"";
        
    }
    
    if (currentPostion - _lastPosition > 0  && currentPostion > 0) {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = YES;
        
    }
    
    if ((_lastPosition - currentPostion > 0) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height) )
    {
        _lastPosition = currentPostion;
        self.tabBarController.tabBar.hidden = NO;
        
    }
}


#pragma mark -- 响应键盘 search 事件
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
   
    if (![_searchPositionTextField.text isEqualToString:@""]) {
        
      //  NSLog(@"%@",_searchPositionTextField.text);
        
    }else{
    
        [APIClient showMessage:@"职位关键字不能为空"];
    }
    
    return YES;
}



//获取推荐职位列表
-(void)getPositionInfo{

    //_pageString =  [[NSString alloc] initWithFormat:@"%d",_page];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"type"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Position getPositionList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {

        [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];

        int errorCode = [e.code intValue];
        
        if (errorCode ==40004) {
            
            [APIClient showInfo:e.info title:@"提示"];
            
            ImportResumeViewController *importResumeVC = [[ImportResumeViewController alloc]init];
            [self.navigationController pushViewController:importResumeVC animated:YES];
            
        }else if(positionArray.count >0){
            
            NSUserDefaults *recommendPosition= [[NSUserDefaults alloc]init];
        
            NSString *recommendPositionString = [NSString stringWithFormat:@"%@",[recommendPosition objectForKey:@"recommendPosition"]];

            _recommondLabel.text = [@"今日为你推荐" stringByAppendingFormat : @"%@%@",recommendPositionString,@"个职位信息"];
            //清空 recommendPosition 数据
            [recommendPosition removeObjectForKey:@"recommendPosition"];
            
            _positionListArray = positionArray;
            [_positionTableView reloadData];
            
            [self tipAnimation];//显示推荐职位数量
        }
    }];
    
    //_page++;

}

////职位列表 上提 加载更多
//-(void)getMorePositionInfo{
//    
//    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
//    
//    _pageString =  [[NSString alloc] initWithFormat:@"%d",_page];
//    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
//    [dic setObject:@"PHP" forKey:@"keyword"];
//    [dic setObject:_pageString forKey:@"page"];
//    [dic setObject:@"1" forKey:@"type"];
//    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
//    
//     [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [Position getPositionList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {
//        
//        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//        [_positionListArray addObjectsFromArray:positionArray];
//        
//        [_positionTableView reloadData];
//        
//    }];
//    
//    _page++;
//    
//}


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
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    return cell;
}


#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 250.f;
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
