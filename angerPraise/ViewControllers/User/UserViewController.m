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

#import "ScanViewController.h"
#import "IsOrNoHrViewController.h"
#import "SettingViewController.h"
#import "EditPhotoViewController.h"
#import "InterviewPayViewController.h"

#define BUFFERX 5 //distance from side to the card (higher makes thinner card)
#define BUFFERY 10 //distance from top to the card (higher makes shorter card)
@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RKCardView* cardView= [[RKCardView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT)];
    
    cardView.backgroundColor = [UIColor clearColor];
    
    cardView.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    cardView.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    [self.view addSubview:cardView];
    
    UIButton *editPhotoButton = [[UIButton alloc]init];
    //editPhotoButton.frame = cardView.profileImageView.frame;
    editPhotoButton.frame = CGRectMake(100, cardView.profileImageView.frame.origin.y+32, WIDTH-2*100, cardView.profileImageView.frame.size.height);
    
    editPhotoButton.backgroundColor = RGBACOLOR(75, 90, 248, 0.5f);
    [editPhotoButton addTarget:self action:@selector(editPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editPhotoButton];
    
//    _userNameLabel = [[UILabel alloc]init];

    
    
    NSUserDefaults *userType = [NSUserDefaults standardUserDefaults];
     _user_type = [userType objectForKey:@"userType"];
    
    if ([_user_type isEqualToString:@"1"]) {
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录",@"扫一扫",@"HR特权",@"设置",nil];
    }else{
    
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录",@"扫一扫",@"设置",nil];
    
    }

    _userTableView = [[UITableView alloc]init];
    _userTableView.frame = CGRectMake(0,cardView.coverImageView.frame.size.height+cardView.coverImageView.frame.origin.y, WIDTH,HEIGHT);
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.scrollEnabled = NO;
    //隐藏多余分割线 函数调用
    [self setExtraCellLineHidden:_userTableView];
    [self.view addSubview:_userTableView];
    
}

//修改头像 查看 二维码
-(void)editPhoto{

    EditPhotoViewController *editPhotoVC = [[EditPhotoViewController alloc]init];
    [self.navigationController pushViewController:editPhotoVC animated:YES];

}

#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}

#pragma mark -- UITableView cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_user_type isEqualToString:@"1"]) {
        
        return 5;
        
    }else{
        
        return 4;
        
    }
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    
    UITableViewCell * cell = [_userTableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:showUserInfoCellIdentifier];
    }  
    
    // Configure the cell.
    if(indexPath.row == 0)
    {
    
        cell.imageView.image = [UIImage imageNamed:@"e"];
        
    }else if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"f"];
        
    }else if(indexPath.row == 2){
        
        cell.imageView.image = [UIImage imageNamed:@"g"];

    }else if (indexPath.row ==3){
    
        cell.imageView.image = [UIImage imageNamed:@"h"];
        
    }else if(indexPath.row ==4){
    
     cell.imageView.image = [UIImage imageNamed:@"i"];
        
    }
    
    cell.textLabel.text = [_modelListArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    return cell;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    
    if ([_user_type isEqualToString:@"1"]) { //  hr
        
        switch (indexPath.row) {
            case 0://钱包
                
                break;
            case 1://投递记录
            {
                InterviewPayViewController *interviewPayVC = [[InterviewPayViewController alloc]init];
                [self.navigationController pushViewController:interviewPayVC animated:YES];
            }
                break;
            case 2://扫一扫
            {
                ScanViewController *scanVC = [[ScanViewController alloc]init];
                [self.navigationController pushViewController:scanVC animated:YES];
            }
                break;
            case 3://HR特权
            {
                IsOrNoHrViewController *isOrNoHrVC = [[IsOrNoHrViewController alloc]init];
                [self.navigationController pushViewController:isOrNoHrVC animated:YES];
            }
                break;
            case 4://设置
            {
                SettingViewController *settingVC = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }else{// 非hr
        
        switch (indexPath.row) {
            case 0://钱包
                
                break;
            case 1://投递记录
            {
                InterviewPayViewController *interviewPayVC = [[InterviewPayViewController alloc]init];
                [self.navigationController pushViewController:interviewPayVC animated:YES];
            }
                break;
            case 2://扫一扫
            {
                ScanViewController *scanVC = [[ScanViewController alloc]init];
                [self.navigationController pushViewController:scanVC animated:YES];
            }
                break;
            case 3://设置
            {
                SettingViewController *settingVC = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    
    
    }
    
}


//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


@end
