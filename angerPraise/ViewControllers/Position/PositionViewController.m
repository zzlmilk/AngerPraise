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
#import "ApIClient.h"
#import "ImportResumeViewController.h"
#import "AHKActionSheet.h"


@interface PositionViewController ()

@end

@implementation PositionViewController

-(id)init{
    self= [super init];
    
    
    _payRangeArray = [[NSArray alloc]initWithObjects:
                      @"3000以下",@"3000-4999",@"5000-7999",
                      @"8000-9999",@"10000-14999",@"15000-19999",
                      @"20000以上",nil];
    
    _experienceArray = [[NSArray alloc]initWithObjects:
                        @"应届生",@"0-2年",@"3-5年",@"6-8年",@"9-10年",@"10年+",@"不限",nil];
    
    _placeArray = [[NSArray alloc]initWithObjects:
                   @"上海",@"北京",@"广州",@"深圳",nil];
    
    

    
    return self;
    
    
}


-(void)creatAdvanceView{
    
    UIImageView *advancedSearchImageView = [[UIImageView alloc]init];
    advancedSearchImageView.frame = CGRectMake(WIDTH-60, 0.75*HEIGHT, 54, 39);
    advancedSearchImageView.image = [UIImage imageNamed:@"0searchandfilter"];
    advancedSearchImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:advancedSearchImageView];
    
    UIButton *advancedSearchButton = [[UIButton alloc]init];
    advancedSearchButton.frame = advancedSearchImageView.frame;
    [advancedSearchButton addTarget:self action:@selector(advancedSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:advancedSearchButton];
    
    
    _tipView = [[UIView alloc]init];
    _tipView.frame = CGRectMake((WIDTH-235)/2, 0, 235, 59);
    _tipView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"0position"]];
    _tipView.hidden = YES;
    [self.view addSubview:_tipView];
    
    _recommondLabel = [[UILabel alloc]init];
    _recommondLabel.frame = CGRectMake(0, -3, _tipView.frame.size.width, _tipView.frame.size.height);
    _recommondLabel.textAlignment = NSTextAlignmentCenter;
    _recommondLabel.text = @"今日为你匹配20个职位";
    _recommondLabel.textColor =hl_black;
    _recommondLabel.font = [UIFont fontWithName:hlTextFont size:16.f];
    [_tipView addSubview:_recommondLabel];
    
    //以下 布局 高级搜索
    
    _searchView = [[UIView alloc]init];
    _searchView.frame = self.view.frame;
    _searchView.backgroundColor = RGBACOLOR(0, 0, 0, 0.9);
    _searchView.hidden = YES;
    [self.view addSubview:_searchView];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_searchView addGestureRecognizer:tapGestureRecognizer];
    
    _searchPositionTextField = [[UITextField alloc]initWithFrame:CGRectMake(20,20, WIDTH-2*20, 40)];
    _searchPositionTextField.returnKeyType = UITextBorderStyleBezel;
    [_searchPositionTextField setBorderStyle:UITextBorderStyleLine];
    _searchPositionTextField.delegate =self;
    _searchPositionTextField.layer.borderColor=[RGBACOLOR(159, 159, 159, 1.0f)CGColor];
    [_searchPositionTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //_searchPositionTextField.hidden = YES;
    _searchPositionTextField.textColor = [UIColor whiteColor];
    _searchPositionTextField.layer.borderWidth = 1.0f;
    _searchPositionTextField.backgroundColor = [UIColor clearColor];
    [_searchView addSubview:_searchPositionTextField];
    
    _searchPositionPlaceholderlabel = [[UILabel alloc]init];
    _searchPositionPlaceholderlabel.frame = CGRectMake(10, 0, _searchPositionTextField.frame.size.width, 40);
    _searchPositionPlaceholderlabel.text = @"请输入职位关键字";
    _searchPositionPlaceholderlabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    _searchPositionPlaceholderlabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
    [_searchPositionTextField addSubview:_searchPositionPlaceholderlabel];
    
    
    UIButton *advSearchButton = [[UIButton alloc]init];
    advSearchButton.frame = CGRectMake(0, _searchPositionTextField.frame.size.height+_searchPositionTextField.frame.origin.y+15, _searchView.frame.size.width, 30);
    advSearchButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [advSearchButton setTitleColor:RGBACOLOR(240, 240, 240, 1.0f)forState:UIControlStateNormal];
    advSearchButton.backgroundColor = [UIColor clearColor];
    [advSearchButton setTitle:@"高级搜索" forState:UIControlStateNormal];
    [_searchView addSubview:advSearchButton];
    
    
    UILabel *lineOneLabel = [[UILabel alloc]init];
    lineOneLabel.frame = CGRectMake(_searchPositionTextField.frame.origin.x, advSearchButton.frame.size.height+advSearchButton.frame.origin.y, _searchPositionTextField.frame.size.width, 2);
    lineOneLabel.backgroundColor = RGBACOLOR(250, 250, 250, 1.0f);
    [_searchView addSubview:lineOneLabel];
    
    UILabel *workPlacelabel = [[UILabel alloc]init];
    workPlacelabel.frame = CGRectMake(70, lineOneLabel.frame.origin.y+20, 90, 30);
    workPlacelabel.text = @"工作所在地";
    workPlacelabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.f];
    workPlacelabel.textColor = RGBACOLOR(230, 230, 230, 1.0f);
    workPlacelabel.backgroundColor = [UIColor clearColor];
    [_searchView addSubview:workPlacelabel];
    
    _workPlaceDataButton = [[UIButton alloc]init];
    _workPlaceDataButton.frame = CGRectMake(workPlacelabel.frame.origin.x+workPlacelabel.frame.size.width, workPlacelabel.frame.origin.y+5, 50, 20);
    [_workPlaceDataButton setTitle:@"上海" forState:UIControlStateNormal];
    [_workPlaceDataButton addTarget:self action:@selector(chooseList:) forControlEvents:UIControlEventTouchUpInside];
    _workPlaceDataButton.tag = 201;
    _workPlaceDataButton.backgroundColor = [UIColor clearColor];
    _workPlaceDataButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [_searchView addSubview:_workPlaceDataButton];
    
    
    UILabel *lineTwoLabel = [[UILabel alloc]init];
    lineTwoLabel.frame = CGRectMake(_searchPositionTextField.frame.origin.x, workPlacelabel.frame.size.height+workPlacelabel.frame.origin.y+24, _searchPositionTextField.frame.size.width, 1);
    lineTwoLabel.backgroundColor = RGBACOLOR(230, 230, 230, 1.0f);
    [_searchView addSubview:lineTwoLabel];
    
    UILabel *workAgeLabel = [[UILabel alloc]init];
    workAgeLabel.frame = CGRectMake(70, lineTwoLabel.frame.origin.y+20, 90, 30);
    workAgeLabel.text = @"工作年限";
    workAgeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.f];
    workAgeLabel.textColor = RGBACOLOR(230, 230, 230, 1.0f);
    workAgeLabel.backgroundColor = [UIColor clearColor];
    [_searchView addSubview:workAgeLabel];
    
    _workAgeDataButton = [[UIButton alloc]init];
    _workAgeDataButton.frame = CGRectMake(workAgeLabel.frame.origin.x+workAgeLabel.frame.size.width, workAgeLabel.frame.origin.y+5, 50, 20);
    [_workAgeDataButton setTitle:@"0-2年" forState:UIControlStateNormal];
    [_workAgeDataButton addTarget:self action:@selector(chooseList:) forControlEvents:UIControlEventTouchUpInside];
    _workAgeDataButton.backgroundColor = [UIColor clearColor];
    _workAgeDataButton.tag = 202;
    _workAgeDataButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [_searchView addSubview:_workAgeDataButton];
    
    UILabel *lineThreeLabel = [[UILabel alloc]init];
    lineThreeLabel.frame = CGRectMake(_searchPositionTextField.frame.origin.x, workAgeLabel.frame.size.height+workAgeLabel.frame.origin.y+24, _searchPositionTextField.frame.size.width, 1);
    lineThreeLabel.backgroundColor = RGBACOLOR(230, 230, 230, 1.0f);
    [_searchView addSubview:lineThreeLabel];
    
    UILabel *monthlyLabel = [[UILabel alloc]init];
    monthlyLabel.frame = CGRectMake(70, lineThreeLabel.frame.origin.y+20, 90, 30);
    monthlyLabel.text = @"月薪范围";
    monthlyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.f];
    monthlyLabel.textColor = RGBACOLOR(230, 230, 230, 1.0f);
    monthlyLabel.backgroundColor = [UIColor clearColor];
    [_searchView addSubview:monthlyLabel];
    
    _monthlyDataButton = [[UIButton alloc]init];
    _monthlyDataButton.frame = CGRectMake(monthlyLabel.frame.origin.x+monthlyLabel.frame.size.width, monthlyLabel.frame.origin.y+5, 90, 20);
    [_monthlyDataButton setTitle:@"5000-8000" forState:UIControlStateNormal];
    [_monthlyDataButton addTarget:self action:@selector(chooseList:) forControlEvents:UIControlEventTouchUpInside];
    _monthlyDataButton.backgroundColor = [UIColor clearColor];
    _monthlyDataButton.tag = 203;
    _monthlyDataButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [_searchView addSubview:_monthlyDataButton];
    
    UILabel *lineFourLabel = [[UILabel alloc]init];
    lineFourLabel.frame = CGRectMake(_searchPositionTextField.frame.origin.x, monthlyLabel.frame.size.height+monthlyLabel.frame.origin.y+24, _searchPositionTextField.frame.size.width, 2);
    lineFourLabel.backgroundColor = RGBACOLOR(250, 250, 250, 1.0f);
    [_searchView addSubview:lineFourLabel];
    
    // 存放一维数组的 下标
    _workPlaceDataUILabel = [[UILabel alloc]init];
    _workPlaceDataUILabel.text = @"0";
    _workAgeDataUILabel = [[UILabel alloc]init];
    _workAgeDataUILabel.text = @"0";
    _monthlyDataUILabel = [[UILabel alloc]init];
    _monthlyDataUILabel.text = @"0";
    
    
    UIButton *advancedSearchStarButton = [[UIButton alloc]init];
    advancedSearchStarButton.frame = CGRectMake((WIDTH-130)/2,lineFourLabel.frame.origin.y+90, 130, 35);
    [advancedSearchStarButton.layer setMasksToBounds:YES];
    [advancedSearchStarButton.layer setCornerRadius:35/2.f]; //设置矩形四个圆角半径
    [advancedSearchStarButton.layer setBorderWidth:1.0]; //边框宽度
    advancedSearchStarButton.layer.borderColor = [RGBACOLOR(0, 203, 251, 1.0f) CGColor];
    [advancedSearchStarButton setTitle:@"启   用" forState:UIControlStateNormal];
    [advancedSearchStarButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [advancedSearchStarButton setTitleColor:hl_gary forState:UIControlStateHighlighted];
    advancedSearchStarButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    advancedSearchStarButton.backgroundColor = [UIColor clearColor];
    [advancedSearchStarButton addTarget:self action:@selector(advancedSearchStar) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:advancedSearchStarButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    

    
    
    //推荐职位
    _titleBgLabel = [[UILabel alloc]init];
    _titleBgLabel.frame = CGRectMake(0, 0, WIDTH, 44);
    _titleBgLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_titleBgLabel];
    
    
    
    //列表
    _positionTableView = [[UITableView alloc]init];
    _positionTableView.frame = CGRectMake(0,0, WIDTH,HEIGHT);
    _positionTableView.delegate = self;
    _positionTableView.dataSource = self;
    _positionTableView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    _positionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_positionTableView];
    

    
    //高级搜索UI
    [self creatAdvanceView];
    
    
    [self getPositionInfo];

    
    
    // 向上滑动 隐藏键盘
    UISwipeGestureRecognizer *oneFingerSwipeUp =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [_searchView addGestureRecognizer:oneFingerSwipeUp];
    
}

#pragma mark -- 下拉列表 进行选择 筛选
-(void)chooseList:(UIButton *)sender{
    
    _searchView.hidden = NO;
    
    UIButton *button = (UIButton *)sender;
    
    NSArray *loopArray = [[NSArray alloc]init];
    
    if (button.tag == 201) {
        
        loopArray = _placeArray;
        
    }else if(button.tag == 202){
        
        loopArray =_experienceArray;
        
    }else if (button.tag ==203){
        
        loopArray = _payRangeArray;
        
    }
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(nil, nil)];
    
    for (int i =0; i < loopArray.count; i++) {
        
        NSString *projectList = loopArray[i];
        
        [actionSheet addButtonWithTitle:NSLocalizedString(projectList, nil)
                                  image:nil
                                   type:AHKActionSheetButtonTypeDefault
                                handler:^(AHKActionSheet *as) {
                                    
                                    if (button.tag ==201) {

                                        [_workPlaceDataButton setTitle:loopArray[i] forState:UIControlStateNormal];
                                        
                                        _workPlaceDataUILabel.text = [NSString stringWithFormat:@"%d",i+1];
                                        
                                    }
                                    if(button.tag ==202){
                                        
                                        [_workAgeDataButton setTitle:loopArray[i] forState:UIControlStateNormal];
                                        _workAgeDataUILabel.text = [NSString stringWithFormat:@"%d",i+1];
                                    }
                                    if(button.tag ==203){
                                        
                                     [_monthlyDataButton setTitle:loopArray[i] forState:UIControlStateNormal];
                                    _monthlyDataUILabel.text = [NSString stringWithFormat:@"%d",i+1];
                                    }
                                    
                                }];
        
    }
    
    [actionSheet show];
}

#pragma mark -- 键盘return 事件

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self advancedSearchStar];
    
    [_searchPositionTextField resignFirstResponder];
    
    return YES;
    
    
    
}

#pragma mark -- 使用高级搜索
-(void)advancedSearch{

    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [_searchView.layer addAnimation:animation forKey:nil];
    [_searchPositionTextField.layer addAnimation:animation forKey:nil];
    
    //显示searchView 及其附属元素
    _searchView.hidden = NO;
    //_searchPositionTextField.hidden = NO;
    [_searchPositionTextField becomeFirstResponder];
    _searchPositionPlaceholderlabel.hidden= NO;
    _searchPositionTextField.text = @"";
}

#pragma mark -- 手势事件监听
-(void)tapGestureAction:(UITapGestureRecognizer*)tap{
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [_searchView.layer addAnimation:animation forKey:nil];
    [_searchPositionTextField.layer addAnimation:animation forKey:nil];
    
    //_searchView.hidden = YES;
    //_searchPositionTextField.hidden = YES;
    [_searchPositionTextField resignFirstResponder];
    
}

#pragma mark -- 手势向上滑动
- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    [self tapGestureAction:nil];
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

            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


#pragma mark -- 控制 上下滑动 底部栏 出现或隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //CGFloat yOffset  = scrollView.contentOffset.y;
    
    int currentPostion = scrollView.contentOffset.y;
    
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


#pragma mark -- 高级搜索 调用接口数据
-(void)advancedSearchStar{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    
    [dic setObject:_searchPositionTextField.text forKey:@"keyword"];
    [dic setObject:_workPlaceDataUILabel.text forKey:@"work_place_id"];
    [dic setObject:_workAgeDataUILabel.text forKey:@"work_year_id"];
    [dic setObject:_monthlyDataUILabel.text forKey:@"compensation_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Position advancedSearchList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];
        
        if(positionArray.count >0){
            
            _positionListArray = positionArray;
            [_positionTableView reloadData];
            
        }
        _searchView.hidden = YES;
        
    }];
    
    
}

#pragma mark -- 获取推荐职位列表
-(void)getPositionInfo{
   
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    [dic setObject:@"1" forKey:@"type"];//type 1 表示用户开启的推荐职位类型
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];

    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [Position getPositionList:dic WithBlock:^(NSMutableArray *positionArray, Error *e) {

        [SMS_MBProgressHUD hideHUDForView: self.view animated:YES];

        int errorCode = [e.code intValue];
        if (errorCode ==40004) {
            
            [APIClient showInfo:e.info title:@"提示"];
            
            //待 修改－－ 每次调用接口都会创建新的 VC
            ImportResumeViewController *importResumeVC = [[ImportResumeViewController alloc]init];
            [self.navigationController pushViewController:importResumeVC animated:YES];
            
        }
        
        if(positionArray.count >0){                        
            _positionListArray = positionArray;
            [_positionTableView reloadData];
            
            [self tipAnimation];//显示推荐职位数量
        }
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _positionListArray.count;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    
    PositionListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[PositionListCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellId];
    }
    
    
    Position *p = [_positionListArray objectAtIndex:indexPath.row];
    cell.p = p;
    


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
