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
                       @"",@"  隐私",@"  版本",@"  关于我们",@"  我要评价",nil];
    
    UILabel *settingLabel = [[UILabel alloc]init];
    settingLabel.frame = CGRectMake(20, backBtn.frame.size.height+backBtn.frame.origin.y+30, WIDTH, 35);
    settingLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    settingLabel.backgroundColor = [UIColor clearColor];
    settingLabel.text = @"设置";
    [self.view addSubview:settingLabel];
    
    
    _settingTableView = [[UITableView alloc]init];
    _settingTableView.frame = CGRectMake(0,settingLabel.frame.size.height+settingLabel.frame.origin.y, WIDTH,250);
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.scrollEnabled = NO;
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
    loginOutButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    loginOutButton.backgroundColor = RGBACOLOR(255, 87, 102, 1.0f);
    [loginOutButton addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutButton];
    
    
}

-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//退出登录
-(void)loginOut{
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];

    [User userLoginOut:dic WithBlock:^(User *user, Error *e) {
       
        if ((int)user.res == 1) {
            //退出成功  清空 NSUserDefaults  的值 做跳转
            
            [APIClient showSuccess:@"退出成功" title:@"成功"];
            
//            NSUserDefaults *userId=[NSUserDefaults standardUserDefaults];
//            [userId removeObjectForKey:@"userId"];
            
            
        }else if (e != nil){
            //退出失败
            
            [APIClient showInfo:e.info title:@"提示"];
        
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
