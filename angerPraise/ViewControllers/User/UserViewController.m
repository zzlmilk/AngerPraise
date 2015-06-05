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
#import "ShowQrCodeViewController.h"

#import "EditPhoto.h"
#import "ApIClient.h"
#import "SMS_MBProgressHUD.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

#import "WalletWebViewController.h"
#import "MyFriendWebViewController.h"
#import "CollectWebViewController.h"
#import "HrWebViewCon                           `````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````   ```````````````troller.h"

#import "SMS_MBProgressHUD.h"

#define BUFFERX 5 //distance from side to the card (higher makes thinner card)
#define BUFFERY 10 //distance from top to the card (higher makes shorter card)
@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBACOLOR(48, 47, 53, 1.0f);

    UIView *cardView = [[UIView alloc]init];
    cardView.frame = CGRectMake(0, 0, WIDTH, 245);
    cardView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    [self.view addSubview:cardView];
    
    _userPhotoImageView = [[UIImageView alloc]init];
    [_userPhotoImageView setImage:[UIImage imageNamed:@"touxiang"]];
    _userPhotoImageView.userInteractionEnabled = YES;
    _userPhotoImageView.backgroundColor = [UIColor clearColor];
    _userPhotoImageView.frame = CGRectMake((WIDTH-100)/2, 20, 100, 100);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEditPersonInfoView)];
    _userPhotoImageView.layer.masksToBounds = YES;
    _userPhotoImageView.layer.cornerRadius = 50;
    [_userPhotoImageView addGestureRecognizer:singleTap];
    [cardView addSubview:_userPhotoImageView];
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.frame = CGRectMake(0, _userPhotoImageView.frame.size.height+_userPhotoImageView.frame.origin.y, WIDTH, 35);
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.text = @"Allen Zhu";
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [_userNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:17.f]];
    _userNameLabel.textColor = RGBACOLOR(0, 204, 252, 1.0f);
    [cardView addSubview:_userNameLabel];
    
    _hirelibNumberLabel = [[UILabel alloc]init];
    _hirelibNumberLabel.frame = CGRectMake(0, _userNameLabel.frame.size.height+_userNameLabel.frame.origin.y-5, WIDTH, 20);
    _hirelibNumberLabel.backgroundColor = [UIColor clearColor];
    _hirelibNumberLabel.text = @"hirelib No.11122";
    _hirelibNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_hirelibNumberLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    _hirelibNumberLabel.textColor = RGBACOLOR(82, 82, 82, 1.0f);
    [cardView addSubview:_hirelibNumberLabel];
    
    
    
    _matchPositionLabel = [[UILabel alloc]init];
    _matchPositionLabel.frame = CGRectMake(30, _hirelibNumberLabel.frame.origin.y+_hirelibNumberLabel.frame.size.height+10, WIDTH-2*30, 35);
    _matchPositionLabel.backgroundColor = [UIColor clearColor];
    _matchPositionLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _matchPositionLabel.text= @"28";
    _matchPositionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [cardView addSubview:_matchPositionLabel];
    
    UILabel *matchPositionTitleLabel = [[UILabel alloc]init];
    matchPositionTitleLabel.frame = CGRectMake(20, _matchPositionLabel.frame.origin.y+_matchPositionLabel.frame.size.height-12, WIDTH-2*20, 35);
    matchPositionTitleLabel.backgroundColor = [UIColor clearColor];
    matchPositionTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    matchPositionTitleLabel.text= @"匹配职位";
    matchPositionTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [cardView addSubview:matchPositionTitleLabel];
    
    
    
    _synthesisScoreLabel = [[UILabel alloc]init];
    _synthesisScoreLabel.frame =_matchPositionLabel.frame;
    _synthesisScoreLabel.backgroundColor = [UIColor clearColor];
    _synthesisScoreLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _synthesisScoreLabel.text= @"65";
    _synthesisScoreLabel.textAlignment = NSTextAlignmentCenter;
    _synthesisScoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [cardView addSubview:_synthesisScoreLabel];
    
    UILabel *synthesisScoreTitleLabel = [[UILabel alloc]init];
    synthesisScoreTitleLabel.frame = matchPositionTitleLabel.frame;
    synthesisScoreTitleLabel.backgroundColor = [UIColor clearColor];
    synthesisScoreTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    synthesisScoreTitleLabel.text= @"综合评分";
    synthesisScoreTitleLabel.textAlignment = NSTextAlignmentCenter;
    synthesisScoreTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [cardView addSubview:synthesisScoreTitleLabel];
    
    
    
    _walletNumberLabel = [[UILabel alloc]init];
    _walletNumberLabel.frame =_matchPositionLabel.frame;
    _walletNumberLabel.backgroundColor = [UIColor clearColor];
    _walletNumberLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _walletNumberLabel.text= @"125";
    _walletNumberLabel.textAlignment = NSTextAlignmentRight;
    _walletNumberLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [cardView addSubview:_walletNumberLabel];
    
    UILabel *walletNumberTitleLabel = [[UILabel alloc]init];
    walletNumberTitleLabel.frame = matchPositionTitleLabel.frame;
    walletNumberTitleLabel.backgroundColor = [UIColor clearColor];
    walletNumberTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    walletNumberTitleLabel.text= @"钱包数额";
    walletNumberTitleLabel.textAlignment = NSTextAlignmentRight;
    walletNumberTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [cardView addSubview:walletNumberTitleLabel];
    
    
    
//     NSUserDefaults *userType = [NSUserDefaults standardUserDefaults];
//     _user_type = [userType objectForKey:@"userType"];
    
    _user_type = @"1";
    
    if ([_user_type isEqualToString:@"1"]) {
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"激活HR特权？",@"设置",nil];
    }else{
    
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"设置",nil];
    
    }

    _userTableView = [[UITableView alloc]init];
    _userTableView.frame = CGRectMake(0,cardView.frame.size.height+cardView.frame.origin.y, WIDTH,HEIGHT);
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    _userTableView.scrollEnabled = NO;
    _userTableView.backgroundColor = RGBACOLOR(48, 47, 53, 1.0f);
    _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //隐藏多余分割线 函数调用
    [self setExtraCellLineHidden:_userTableView];
    [self.view addSubview:_userTableView];

    
    _editView = [[UIView alloc]init];
    _editView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _editView.backgroundColor = [UIColor whiteColor];
    _editView.hidden = YES;
    [self.view addSubview:_editView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 15, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(hideView)forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:backBtn];
    
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(0, backBtn.frame.size.height+backBtn.frame.origin.y+50, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [_editView addSubview:lineLabel];
    
    UIButton *editPhotoButton = [[UIButton alloc]init];
    editPhotoButton.frame = CGRectMake(0, lineLabel.frame.origin.y+lineLabel.frame.size.height, WIDTH, 60);
    [editPhotoButton setTitle:@"修改头像" forState:UIControlStateNormal];
    [editPhotoButton setTitleColor:RGBACOLOR(100, 100, 100, 1.0f)forState:UIControlStateNormal];
    editPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    editPhotoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [editPhotoButton addTarget:self action:@selector(onClickImageView) forControlEvents:UIControlEventTouchUpInside];
    editPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_editView addSubview:editPhotoButton];
    
    UILabel *lineLabel1 = [[UILabel alloc]init];
    lineLabel1.frame = CGRectMake(0, editPhotoButton.frame.size.height+editPhotoButton.frame.origin.y, WIDTH, 0.5);
    lineLabel1.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [_editView addSubview:lineLabel1];
    
    UIButton *myQrCodeButton = [[UIButton alloc]init];
    myQrCodeButton.frame = CGRectMake(0, lineLabel1.frame.origin.y+lineLabel1.frame.size.height, WIDTH, 60);
    [myQrCodeButton setTitle:@"我的二维码" forState:UIControlStateNormal];
    [myQrCodeButton setTitleColor:RGBACOLOR(100, 100, 100, 1.0f)forState:UIControlStateNormal];
    myQrCodeButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    myQrCodeButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [myQrCodeButton addTarget:self action:@selector(lookQrCode) forControlEvents:UIControlEventTouchUpInside];
    myQrCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    myQrCodeButton.backgroundColor = [UIColor clearColor];
    [_editView addSubview:myQrCodeButton];
    
    UIImageView *iconQrImageView = [[UIImageView alloc]init];
    iconQrImageView.frame = CGRectMake(WIDTH-50, 20, 35/2, 35/2);
    //iconQrImageView.backgroundColor = [UIColor yellowColor];
    [iconQrImageView setImage:[UIImage imageNamed:@"0code"]];
    [myQrCodeButton addSubview:iconQrImageView];
    
    
    UILabel *lineLabel2 = [[UILabel alloc]init];
    lineLabel2.frame = CGRectMake(0, myQrCodeButton.frame.size.height+myQrCodeButton.frame.origin.y, WIDTH, 0.5);
    lineLabel2.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [_editView addSubview:lineLabel2];
    

    [self getUserInfo];
}

-(void)getUserInfo{

    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [User getUserInfo:dic WithBlock:^(User *user, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        if (e.info !=nil) {
            
            [APIClient showInfo:e.info title:@"提示"];
            
        }else{
        
            [_userPhotoImageView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            _userNameLabel.text = user.user_name;//hirelib No.11122
            _hirelibNumberLabel.text =[@"hirelib No." stringByAppendingFormat:@"%@",user.hirelib_code];
            _matchPositionLabel.text = user.position_number;
            _synthesisScoreLabel.text = user.user_resume_synthesize_grade;
            _walletNumberLabel.text = user.user_intergral;
        
            _hr_url = user.hr_url;
            _pay_url = user.pay_url;
            _user_apply_url = user.user_apply_url;
            _user_friend_url = user.user_friend_url;
        }
        
    }];
    
}


-(void)hideView{
    
    _editView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

//查看 二维码
-(void)lookQrCode{
    
    ShowQrCodeViewController *showQrCodeVC = [[ShowQrCodeViewController alloc]init];
    [self.navigationController pushViewController:showQrCodeVC animated:YES];
}


-(void)showEditPersonInfoView{
    self.tabBarController.tabBar.hidden = YES;

    _editView.hidden = NO;
    
}


// 调用相机
-(void)onClickImageView{
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
    
}

// 跳转到相机 或 相册界面
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
            
        }
        
        else {
            
            if (buttonIndex == 0) {
                
                return;
                
            } else {
                
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            }
            
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


// 实现 picker delegte
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    // isFullScreen = NO;
    [_userPhotoImageView setImage:savedImage];
    //
    //_avatarImageView.tag = 100;
    
    _editView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    //[self UploadPhoto];
    [self UploadPhoto:savedImage];
    
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

-(void)UploadPhoto:(UIImage *)image{
    
    UIImage *img = image;
    NSData *imageData = UIImagePNGRepresentation(img);
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
    [dic setObject:imageData forKey:@"imageData"];
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [EditPhoto uploadUserProfileImageParameters:dic WithBlock:^(EditPhoto *e) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        // NSLog(@"%@",e);
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([e.res isEqualToString:@"1"]) {
            
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
    
        cell.imageView.image = [UIImage imageNamed:@"0userwallet1"];
        
    }else if (indexPath.row == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"0usermap1"];
        
    }else if(indexPath.row == 2){
        
        cell.imageView.image = [UIImage imageNamed:@"0userfriend1"];

    }else if (indexPath.row ==3){
    
        cell.imageView.image = [UIImage imageNamed:@"0userhr1"];
        
    }else if(indexPath.row ==4){
    
     cell.imageView.image = [UIImage imageNamed:@"0usersetting1"];
        
    }
    
    
    UIImageView *cellBgImageView = [[UIImageView alloc]init];
    [cellBgImageView setImage:[UIImage imageNamed:@"0cell_bg"]];
    cell.selectedBackgroundView = cellBgImageView;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = RGBACOLOR(0, 204, 252, 1.0f);
    cell.textLabel.text = [_modelListArray objectAtIndex:indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor= RGBACOLOR(48, 47, 53, 1.0f);
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    return cell;
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_userTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    
    if ([_user_type isEqualToString:@"1"]) { //  hr
        
        switch (indexPath.row) {
            case 0://钱包
            {
                WalletWebViewController *walletWebVC = [[WalletWebViewController alloc]init];
                walletWebVC.walletUrl = _pay_url;
                [self.navigationController pushViewController:walletWebVC animated:YES];
            }
                break;
            case 1://投递记录 收藏
            {
                CollectWebViewController *collectWebVC = [[CollectWebViewController alloc]init];
                collectWebVC.collectUrl = _user_apply_url;
                [self.navigationController pushViewController:collectWebVC animated:YES];
            }
                break;
            case 2: //我的好友
            {
                MyFriendWebViewController *myFriendWebVC = [[MyFriendWebViewController alloc]init];
                myFriendWebVC.myFriendUrl = _user_friend_url;
                [self.navigationController pushViewController:myFriendWebVC animated:YES];
            }
                break;
            case 3://HR特权
            {
                HrWebViewController *hrWebVC = [[HrWebViewController alloc]init];
                hrWebVC.hrUrl = _hr_url;
                [self.navigationController pushViewController:hrWebVC animated:YES];
//                IsOrNoHrViewController *isOrNoHrVC = [[IsOrNoHrViewController alloc]init];
//                [self.navigationController pushViewController:isOrNoHrVC animated:YES];
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
            {
                WalletWebViewController *walletWebVC = [[WalletWebViewController alloc]init];
                walletWebVC.walletUrl = _pay_url;
                [self.navigationController pushViewController:walletWebVC animated:YES];
            }
                break;
            case 1://投递记录 收藏
            {
                CollectWebViewController *collectWebVC = [[CollectWebViewController alloc]init];
                collectWebVC.collectUrl = _user_apply_url;
                [self.navigationController pushViewController:collectWebVC animated:YES];
            }
                break;
            case 2: //我的好友
            {
                MyFriendWebViewController *myFriendWebVC = [[MyFriendWebViewController alloc]init];
                myFriendWebVC.myFriendUrl = _user_friend_url;
                [self.navigationController pushViewController:myFriendWebVC animated:YES];
            }
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
