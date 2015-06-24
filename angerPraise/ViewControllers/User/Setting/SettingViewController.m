//
//  SettingViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "SettingViewController.h"
#import "User.h"
#import "ApIClient.h"
#import "IndexViewController.h"
#import "SettingWebViewController.h"
#import "Setting.h"
#import "UserViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _settingListArray = [[NSArray alloc]initWithObjects:
                       @"",@"     隐私",@"     版本",@"     关于我们",@"     我要评价",nil];
    
    
    
    
    UIButton *settingButton = [[UIButton alloc]init];
    settingButton.frame = CGRectMake(18, backBtn.frame.size.height+backBtn.frame.origin.y+30, 100, 35);
    settingButton.backgroundColor = [UIColor clearColor];
    [settingButton setTitle:@"   设置" forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"0usersetting1"] forState:UIControlStateNormal];
    settingButton.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    [settingButton setTitleColor:RGBACOLOR(77, 77, 80, 1.0f)forState:UIControlStateNormal];
    [self.view addSubview:settingButton];
    
    
    
    _settingTableView = [[UITableView alloc]init];
    _settingTableView.frame = CGRectMake(0,settingButton.frame.size.height+settingButton.frame.origin.y, WIDTH,250);
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.scrollEnabled = NO;
    [_settingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //隐藏多余分割线 函数调用
    [self setExtraCellLineHidden:_settingTableView];
    [self.view addSubview:_settingTableView];
    
    
    //退出登录
    UIButton *loginOutButton = [[UIButton alloc]init];
    loginOutButton.frame = CGRectMake(100,_settingTableView.frame.origin.y+_settingTableView.frame.size.height+90, WIDTH-2*100, 35);
    [loginOutButton setTitle:@"退 出 登 录" forState:UIControlStateNormal];
    [loginOutButton.layer setMasksToBounds:YES];
    [loginOutButton.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [loginOutButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    [loginOutButton setTitleColor:RGBACOLOR(20, 20, 20, 1.0f) forState:UIControlStateHighlighted];
    loginOutButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    loginOutButton.backgroundColor = RGBACOLOR(255, 87, 102, 1.0f);
    [loginOutButton addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutButton];
    
    [self getSettingDetailUrl];
}

-(void)getSettingDetailUrl{

    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];

    [Setting getSettingUrl:dic WithBlock:^(Setting *setting, Error *e) {
       
        if (e.info !=nil) {
            
            [APIClient showMessage:e.info];
            
        }else{
            
            _about_url = setting.about_url;
            _privacy_url = setting.privacy_url;
            _review_app_url = setting.review_app_url;
            _version_url = setting.version_url;
        
        }
    }];
    
}


-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//退出登录
-(void)loginOut{
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];

    [User userLoginOut:dic WithBlock:^(User *user, Error *e) {
       
        if ([user.res isEqualToString:@"1"]) {
            //退出成功  清空 NSUserDefaults  的值 做跳转
            
            NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
            [token removeObjectForKey:@"token"];
            
            NSUserDefaults *hrPrivilege = [NSUserDefaults standardUserDefaults];
            [hrPrivilege removeObjectForKey:@"hrPrivilege"];
            
            IndexViewController *indexVC= [[IndexViewController alloc]init];
            [self.navigationController pushViewController:indexVC animated:YES];
            
        }else if (e != nil){
            //退出失败
            
            [APIClient showMessage:e.info title:@"提示"];
        
        }
        
    }];
}

#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}

#pragma mark -- UITableView cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellId = @"CellId";
    
    UITableViewCell * cell = [_settingTableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellId];
    }
    
    
    cell.textLabel.text = [_settingListArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    return cell;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);

    switch (indexPath.row) {
        case 1:
        {
            _takeUrlString = _privacy_url;
        }
            break;
        case 2:
        {
            _takeUrlString = _version_url;
        }
            break;
        case 3:
        {
            _takeUrlString = _about_url;
        }
            break;
        case 4:
        {
            _takeUrlString = _review_app_url;
        }
            break;
            
        default:
            break;
    }
    
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
//    Position * p = [_positionListArray objectAtIndex:indexPath.row];
//    
    SettingWebViewController *settingWebVC = [[SettingWebViewController alloc]init];
    
    settingWebVC.settingDetailUrl =_takeUrlString;
    
    [self.navigationController pushViewController:settingWebVC animated:YES];
    
}

//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
