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
#import "MCCore.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NoozanAppdelegate.h"

static NSUserDefaults* userData;

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    userData = [NSUserDefaults standardUserDefaults];
    
    if(![userData objectForKey:@"id"]){
        [userData setObject:[NSString stringWithFormat:@"%i",(arc4random() % 9999999) + 1000000] forKey:@"id"];
    }
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _settingListArray = [[NSArray alloc]initWithObjects:
                       @"",@"     隐私",@"     版本",@"     关于我们",@"     我要评价",@"     联系客服",nil];
    
    
    
    
    UIButton *settingButton = [[UIButton alloc]init];
    settingButton.frame = CGRectMake(18, backBtn.frame.size.height+backBtn.frame.origin.y+30, 100, 35);
    settingButton.backgroundColor = [UIColor clearColor];
    [settingButton setTitle:@"   设置" forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"0usersetting1"] forState:UIControlStateNormal];
    settingButton.titleLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    [settingButton setTitleColor:RGBACOLOR(77, 77, 80, 1.0f)forState:UIControlStateNormal];
    [self.view addSubview:settingButton];
    
    
    
    _settingTableView = [[UITableView alloc]init];
    _settingTableView.frame = CGRectMake(0,settingButton.frame.size.height+settingButton.frame.origin.y, WIDTH,300);
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.scrollEnabled = NO;
    [_settingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //隐藏多余分割线 函数调用
    [self setExtraCellLineHidden:_settingTableView];
    [self.view addSubview:_settingTableView];
    
    
    //退出登录
    UIButton *loginOutButton = [[UIButton alloc]init];
    loginOutButton.frame = CGRectMake(100,_settingTableView.frame.origin.y+_settingTableView.frame.size.height+60, WIDTH-2*100, 35);
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

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

    [User userLoginOut:dic WithBlock:^(User *user, Error *e) {
       
        if ([user.res isEqualToString:@"1"]) {
            //退出成功  清空 NSUserDefaults  的值 做跳转
            
            [[NoozanAppdelegate getAppDelegate] getIndexVC];
            [[NoozanAppdelegate getAppDelegate] clearUserInfo];
            
//            UserViewController *userVC = [[UserViewController alloc]init];
//            [userVC closeTimer];
//            
//            IndexViewController *indexVC= [[IndexViewController alloc]init];
//            [self.navigationController pushViewController:indexVC animated:YES];
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults removeObjectForKey:@"hrPrivilege"];
//            NSUserDefaults *token=[NSUserDefaults standardUserDefaults];
//            [token removeObjectForKey:@"token"];
            
        }
        
    }];
}

#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        
        return 30.f;
        
    }else{
    
        return 50.f;

    }
    
}

#pragma mark -- UITableView cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
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
        case 5:
        {

            [self meiChartAction];
        
        }
            break;
            
        default:
            break;
    }
    
    
    if (indexPath.row !=5) {
        
        //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
        //    Position * p = [_positionListArray objectAtIndex:indexPath.row];
        //
        SettingWebViewController *settingWebVC = [[SettingWebViewController alloc]init];
        settingWebVC.settingDetailUrl =_takeUrlString;
        [self.navigationController pushViewController:settingWebVC animated:YES];
    }
    
}

//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//调用美洽
-(void)meiChartAction{

    if ([self.textField.text isEqualToString:@""]) {
        [userData setObject:[userData objectForKey:@"cookie"] forKey:@"userName"];
    }else{
        [userData setObject:self.textField.text forKey:@"userName"];
    }
    
    //创建用户信息
    NSDictionary* userInfoTemp =  @{
                                    @"realName"     : @"张三",
                                    @"sex"          : @"男",
                                    @"birthday"     : @"2000-1-1",
                                    @"age"          : @"20",
                                    @"job"          : @"法师",
                                    @"avatar"       : @"http://meiqia.com/avatar.jpg",
                                    @"comment"      : @"备注",
                                    @"appUserName"  : @"demo+sdk@meiqia.com",
                                    @"appNickName"  : @"demo",
                                    @"tel"          : @"13500000000",
                                    @"email"        : @"demo+sdk@meiqia.com",
                                    @"address"      : @"成都",
                                    @"QQ"           : @"123456",
                                    @"weibo"        : @"美洽",
                                    @"weixin"       : @"美洽",
                                    };
    
    //设置用户id，实现该用户的消息漫游
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithDictionary:userInfoTemp];
//    [userInfo setObject:[userData objectForKey:@"userName"] forKey:@"appUserId"];
    
    //创建自定义信息
    NSDictionary* otherInfo = @{
                                @"职业"             : @"法师",
                                @"金币"             : @"123",
                                @"余额"             : @"￥1000",
                                @"购物车"            : @"[衣服一件]",
                                @"这是自定义信息"     : @"可以随便填写",
                                @"这些数据"          : @"由SDK上传"
                                };
    
    //添加用户信息
    [MCCore addUserInfo:userInfo addOtherInfo:otherInfo];
    
    //指定分配到客服分组
    //    [MCCore specifyAllocGroup:@"客服组的ID"];
    //指定分配到客服
    //    [MCCore specifyAllocServer:@"1000" isForce:NO];
    
    MCChatViewController* viewController = [MCCore createChatViewController];
    //    MCChatViewController* viewController = [[MCChatViewController alloc] init];  //这种方法也可以
    
    //修改footerBar的backgroundColor
    viewController.footerBar.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    
    //设置deviceToken
    viewController.deviceToken = [userData objectForKey:@"deviceToken"];
    
    //设置代理
    viewController.delegate = (id)self;
    
    //禁用语音
    //    viewController.sendAudioEnable = NO;
    
    //隐藏提示
    //    viewController.hideTipView = YES;
    
    //是否消息同步
    //    viewController.syncNetworkMessage = YES;

    
//    _titleView = [[UIView alloc]init];
//    _titleView.frame = CGRectMake(0, 0, WIDTH, 44);
//    _titleView.backgroundColor = [UIColor yellowColor];
//    
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.frame = CGRectMake(40, 0, WIDTH-2*48, 44);
//    titleLabel.text = @"小怒";
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [_titleView addSubview:titleLabel];
    
    
    UIButton *tBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tBackBtn.frame = CGRectMake(0, 0, 44, 44);
    [tBackBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [tBackBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:tBackBtn];
    viewController.navigationItem.leftBarButtonItem = backItem;
    viewController.navigationBarTintColor =[UIColor whiteColor];
    viewController.title = @"留言";
    
    //替换自定义TitleView
    //viewController.titleView = _titleView;
    //修改footerBar背景颜色
    viewController.footerBar.backgroundColor = [UIColor grayColor];
    //为TextView添加边框
    viewController.textView.layer.borderColor = [UIColor grayColor].CGColor;
    viewController.textView.layer.borderWidth = 1;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


//注意：该代理函数为MCChatViewDelegate中的函数，并非MCMessageDelegate的函数。
//这两者的参数类型不同，注意不要混淆
-(void)receiveMessage:(MCMessage*)message
{
    //收到消息时，震动手机
    SystemSoundID soundID = kSystemSoundID_Vibrate;
    AudioServicesPlaySystemSound(soundID);
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
