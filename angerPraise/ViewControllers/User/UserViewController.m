//
//  UserViewController.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "UserViewController.h"
#import "SettingViewController.h"
#import "EditPhoto.h"
#import "ApIClient.h"
#import "SMS_MBProgressHUD.h"
#import "User.h"
#import "UIImageView+SYJImageCache.h"
#import "WalletWebViewController.h"
#import "MyFriendWebViewController.h"
#import "CollectWebViewController.h"
#import "HrWebViewController.h"
#import "MainViewController.h"
#import "PositionViewController.h"
#import "EditViewController.h"



#define BUFFERX 5 //distance from side to the card (higher makes thinner card)
#define BUFFERY 10 //distance from top to the card (higher makes shorter card)
@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBACOLOR(48, 47, 53, 1.0f);
    
    _cardView = [[CardView alloc]init];
    _cardView.frame = CGRectMake(0, 0, WIDTH, 0.44*HEIGHT+5);
    _cardView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    [self.view addSubview:_cardView];
    
    //给 头像添加点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageView)];
    [_cardView.userPhotoImageView addGestureRecognizer:singleTap];

    //给 昵称添加点击事件
    [_cardView.userNameButton addTarget:self action:@selector(showEditPersonInfoView) forControlEvents:UIControlEventTouchUpInside];
    
    //给 剩余任务数添加点击事件
    [_cardView.taskButton addTarget:self action:@selector(lookTask) forControlEvents:UIControlEventTouchUpInside];
    
    //给 剩余任务数添加点击事件
    [_cardView.positionButton addTarget:self action:@selector(lookPosition) forControlEvents:UIControlEventTouchUpInside];

    //cardView 结束
    
    
    _userTableView = [[UITableView alloc]init];
    _userTableView.frame = CGRectMake(0,_cardView.frame.size.height+_cardView.frame.origin.y, WIDTH,HEIGHT);
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.scrollEnabled = NO;
    _userTableView.backgroundColor = RGBACOLOR(48, 47, 53, 1.0f);
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //隐藏多余分割线 函数调用
    [self setExtraCellLineHidden:_userTableView];
    [self.view addSubview:_userTableView];
    

    if ([_user_type isEqualToString:@"0"]) {  // 不是hr

        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"设置",nil];
    }else{
        
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"激活HR特权？",@"设置",nil];
    }
    
    _walletNumberLabel = [[UILabel alloc]init];
    

}

#pragma mark --  viewWillAppear
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_editedNameString){
        
        [_cardView.userNameButton setTitle:_editedNameString forState:UIControlStateNormal];
        
    }
    
    if (user) {
        
        if (_editedNameString) { //判断昵称是否被修改
            
            [_cardView.userNameButton setTitle:_editedNameString forState:UIControlStateNormal];
            
        }else{
        
            [_cardView.userNameButton setTitle:user.user_name forState:UIControlStateNormal];

        }
        
        _cardView.hirelibNumberLabel.text =[@"怒赞 No." stringByAppendingFormat:@"%@",user.hirelib_code];
        
        if (_userPhotoUrlSting) {
            
            [_cardView.userPhotoImageView setImageWithURL:[NSURL URLWithString:_userPhotoUrlSting] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
            
        }else{
        
            [_cardView.userPhotoImageView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
        }
        
        
//       if (![user.photo_url isEqualToString:@"<null>"]) {
//            
//            [_userPhotoImageView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
//       }
        
        NSString *mission_number = [NSString stringWithFormat:@"%@",user.mission_number];
        _cardView.matchPositionLabel.text =mission_number;// user.position_number;
        
        
        NSString *_task_number = [NSString stringWithFormat:@"%@",user.position_number];
        _cardView.taskLabel.text = _task_number;
        
        _walletNumberLabel.text = user.user_intergral;
        
    }else{
    
        [self getUserInfo];
    }
}


#pragma mark -- 修改个人信息 -- 昵称  密码
-(void)showEditPersonInfoView{
    
    EditViewController *editVC = [[EditViewController alloc]init];
    
    if (_editedNameString) {//判断昵称是否被修改

        editVC.waitUserNameString = _editedNameString;

    }else{
        editVC.waitUserNameString = user.user_name;

    }
    
    [editVC setHidesBottomBarWhenPushed:YES];//push出去的ViewController隐藏Tabbar
    [self.navigationController pushViewController:editVC animated:YES];
    
}


#pragma mark 查看匹配的职位
-(void)lookPosition{

    [self.tabBarController setSelectedIndex:2];
}

#pragma mark 查看剩余任务
-(void)lookTask{
    
    [self.tabBarController setSelectedIndex:0];

}


#pragma mark 安全与隐私
-(void)safeAction{
    
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];

}


#pragma mark -- 获取 user 模块的用户基本信息
-(void)getUserInfo{

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
        [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
        [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

        [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        [User getUserInfoData:dic WithBlock:^(User *userData, Error *e) {
            
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];

            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];
                
            }else{
                
                [_cardView.userPhotoImageView setImageWithURL:[NSURL URLWithString:userData.photo_url] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
                
                [_cardView.userNameButton setTitle:userData.user_name forState:UIControlStateNormal];
                _cardView.hirelibNumberLabel.text =[@"hirelib No." stringByAppendingFormat:@"%@",userData.hirelib_code];
                
                
            }
            
        }];
}

#pragma mark  获取 钱包赏银数量
-(void)getWalletNumber{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];
    [dic setObject:[userDefaults objectForKey:USER_ID] forKey:@"user_id"];

        [User getWalletNumber:dic WithBlock:^(User *userWalletData, Error *e) {
            
            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];

            }else{

                _walletNumberLabel.text = userWalletData.user_intergral;
                
            }
        }];
    
}


#pragma mark --  调用相机
-(void)onClickImageView{
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
    
}

#pragma mark --  跳转到相机 或 相册界面
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    // 取消
                    return;
                    
                    break;
            }
            
        }
        
        else {
            
            if (buttonIndex == 0) {
                
               sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

                
            } else {
                
                 return;
                
            }
            
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


#pragma mark --  实现 picker delegte
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    _savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    // isFullScreen = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    [self UploadPhoto:_savedImage];
    
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark --  UploadPhoto
-(void)UploadPhoto:(UIImage *)image{
    
    UIImage *img = image;
    NSData *imageData = UIImagePNGRepresentation(img);
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [dic setObject:[userDefaults objectForKey:USER_TOKEN] forKey:@"token"];


    [dic setObject:imageData forKey:@"imageData"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [EditPhoto uploadUserProfileImageParameters:dic WithBlock:^(EditPhoto *e) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        if (e.photo_url) {
            
            [_cardView.userPhotoImageView setImageWithURL:[NSURL URLWithString:e.photo_url] placeholderImage:_savedImage];
            _userPhotoUrlSting = e.photo_url;
            
            [APIClient showSuccess:@"头像上传成功" title:@"成功"];
            
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _user_type = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"user_type"]];
    
    
    if ([_user_type isEqualToString:@"0"]) {  //不是 hr
        
        return 4;
        
    }else{
        
        return 5;
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
    
    if ([_user_type isEqualToString:@"0"]) { //  不是hr
        if(indexPath.row == 0)
        {
            
            cell.imageView.image = [UIImage imageNamed:@"0userwallet1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0userwallet2"];
            
          
            _walletNumberLabel.frame = CGRectMake(WIDTH-50-20, 10, 50, 30);
           // _walletNumberLabel.text = @"1000";
            _walletNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
            _walletNumberLabel.backgroundColor = [UIColor clearColor];
            _walletNumberLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
            [cell addSubview:_walletNumberLabel];
            
            
        }else if (indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"0usermap1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0usermap2"];
            
            
        }else if(indexPath.row == 2){
            
            cell.imageView.image = [UIImage imageNamed:@"0userfriend1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0userfriend2"];
            
        }else if (indexPath.row ==3){
            
            cell.imageView.image = [UIImage imageNamed:@"0usersetting1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0usersetting2"];

            
            
        }
        
        
    }else{ // 是HR
    
        if(indexPath.row == 0)
        {
            
            cell.imageView.image = [UIImage imageNamed:@"0userwallet1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0userwallet2"];
            
        
            _walletNumberLabel.frame = CGRectMake(WIDTH-50-20, 10, 50, 30);
           // _walletNumberLabel.text = @"1000";
            _walletNumberLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
            _walletNumberLabel.backgroundColor = [UIColor clearColor];
            _walletNumberLabel.textColor = RGBACOLOR(200, 200, 200, 1.0f);
            [cell addSubview:_walletNumberLabel];
            
            
        }else if (indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"0usermap1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0usermap2"];
            
        }else if(indexPath.row == 2){
            
            cell.imageView.image = [UIImage imageNamed:@"0userfriend1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0userfriend2"];
            
        }else if (indexPath.row ==3){
            
            cell.imageView.image = [UIImage imageNamed:@"0userhr1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0userhr2"];
            
        }else if(indexPath.row ==4){
            
            cell.imageView.image = [UIImage imageNamed:@"0usersetting1"];
            cell.imageView.highlightedImage = [UIImage imageNamed:@"0usersetting2"];
        }

    }
    
    
    UIImageView *cellBgImageView = [[UIImageView alloc]init];
    [cellBgImageView setImage:[UIImage imageNamed:@"0cell_bg"]];
    cell.selectedBackgroundView = cellBgImageView;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = RGBACOLOR(0, 204, 252, 1.0f);
    [cell setHighlighted:YES animated:YES];
    cell.textLabel.text = [_modelListArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor= RGBACOLOR(48, 47, 53, 1.0f);
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    
    
    return cell;
}


#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([_user_type isEqualToString:@"0"]) { //  不是hr
        
        switch (indexPath.row) {
            case 0://钱包
            {
                WalletWebViewController *walletWebVC = [[WalletWebViewController alloc]init];
                [self.navigationController pushViewController:walletWebVC animated:YES];
            }
                break;
            case 1://投递记录 收藏
            {
                CollectWebViewController *collectWebVC = [[CollectWebViewController alloc]init];
                [self.navigationController pushViewController:collectWebVC animated:YES];
            }
                break;
            case 2: //我的好友
            {
                MyFriendWebViewController *myFriendWebVC = [[MyFriendWebViewController alloc]init];
                [self.navigationController pushViewController:myFriendWebVC animated:YES];
            }
                break;
            case 3: //设置
            {
                
                SettingViewController *settingVC = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;

                
            default:
                break;
        }
        
    }else{// hr
        
        switch (indexPath.row) {
            case 0://钱包
            {
                WalletWebViewController *walletWebVC = [[WalletWebViewController alloc]init];
                [self.navigationController pushViewController:walletWebVC animated:YES];
            }
                break;
            case 1://投递记录 收藏
            {
                CollectWebViewController *collectWebVC = [[CollectWebViewController alloc]init];
                [self.navigationController pushViewController:collectWebVC animated:YES];
            }
                break;
            case 2: //我的好友
            {
                MyFriendWebViewController *myFriendWebVC = [[MyFriendWebViewController alloc]init];
                [self.navigationController pushViewController:myFriendWebVC animated:YES];
            }
                break;
            case 3://HR特权
            {
                HrWebViewController *hrWebVC = [[HrWebViewController alloc]init];
                [self.navigationController pushViewController:hrWebVC animated:YES];
            }
                break;
            case 4: //设置
            {
                SettingViewController *settingVC = [[SettingViewController alloc]init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    
    
    }
    
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



#pragma mark -- 隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark --- HomeViewDelegate
-(void)userInfoValueShouldChange:(User *)u{
    
    if (!u) {
        return;
    }
    
    user = u;
    
}





@end
