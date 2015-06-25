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
#import "HrWebViewController.h"
#import "PositionViewController.h"
#import "MainViewController.h"
#import "WalletWebViewController.h"

#import "SMS_MBProgressHUD.h"
#import "EditNameViewController.h"
#import "EditPasswordViewController.h"


#define BUFFERX 5 //distance from side to the card (higher makes thinner card)
#define BUFFERY 10 //distance from top to the card (higher makes shorter card)
@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBACOLOR(48, 47, 53, 1.0f);

    _cardView = [[UIView alloc]init];
    _cardView.frame = CGRectMake(0, 0, WIDTH, 0.44*HEIGHT+5);
    _cardView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    [self.view addSubview:_cardView];
    
    _userPhotoImageView = [[UIImageView alloc]init];
    [_userPhotoImageView setImage:[UIImage imageNamed:@"Icon"]];
    _userPhotoImageView.userInteractionEnabled = YES;
    _userPhotoImageView.backgroundColor = [UIColor clearColor];
    _userPhotoImageView.frame = CGRectMake((WIDTH-100)/2, 20, 100, 100);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageView)];
    _userPhotoImageView.layer.masksToBounds = YES;
    _userPhotoImageView.layer.cornerRadius = 50;
    [_userPhotoImageView addGestureRecognizer:singleTap];
    [_cardView addSubview:_userPhotoImageView];
    
    _userNameButton = [[UIButton alloc]init];
    _userNameButton.frame =CGRectMake(100, _userPhotoImageView.frame.size.height+_userPhotoImageView.frame.origin.y+5, WIDTH-2*100, 35);
    [_userNameButton setTitle:@"Allen Zhu" forState:UIControlStateNormal];
    [_userNameButton setTitleColor:btnHighlightedColor forState:UIControlStateNormal];
    [_userNameButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f) forState:UIControlStateHighlighted];
    _userNameButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    _userNameButton.backgroundColor = [UIColor clearColor];
    _userNameButton.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [_userNameButton addTarget:self action:@selector(showEditPersonInfoView) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:_userNameButton];

    
    _hirelibNumberLabel = [[UILabel alloc]init];
    _hirelibNumberLabel.frame = CGRectMake(0, _userNameButton.frame.size.height+_userNameButton.frame.origin.y-5, WIDTH, 20);
    _hirelibNumberLabel.backgroundColor = [UIColor clearColor];
    _hirelibNumberLabel.text = @"hirelib No.000000";
    _hirelibNumberLabel.textAlignment = NSTextAlignmentCenter;
    [_hirelibNumberLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    _hirelibNumberLabel.textColor = RGBACOLOR(82, 82, 82, 1.0f);
    [_cardView addSubview:_hirelibNumberLabel];
    
    
    
    _matchPositionLabel = [[UILabel alloc]init];
    _matchPositionLabel.frame = CGRectMake(55, _hirelibNumberLabel.frame.origin.y+_hirelibNumberLabel.frame.size.height+12, WIDTH-2*50-10, 35);
    _matchPositionLabel.backgroundColor = [UIColor clearColor];
    _matchPositionLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _matchPositionLabel.text= @"0";
    _matchPositionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [_cardView addSubview:_matchPositionLabel];
    
    UILabel *matchPositionTitleLabel = [[UILabel alloc]init];
    matchPositionTitleLabel.frame = CGRectMake(40, _matchPositionLabel.frame.origin.y+_matchPositionLabel.frame.size.height-12, WIDTH-2*40, 35);
    matchPositionTitleLabel.backgroundColor = [UIColor clearColor];
    matchPositionTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    matchPositionTitleLabel.text= @"剩余任务";
    matchPositionTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [_cardView addSubview:matchPositionTitleLabel];
    
    
//    _synthesisScoreLabel = [[UILabel alloc]init];
//    _synthesisScoreLabel.frame =_matchPositionLabel.frame;
//    _synthesisScoreLabel.backgroundColor = [UIColor clearColor];
//    _synthesisScoreLabel.textColor = RGBACOLOR(0,204,252,1.0f);
//    _synthesisScoreLabel.text= @"65";
//    _synthesisScoreLabel.textAlignment = NSTextAlignmentCenter;
//    _synthesisScoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
//    [cardView addSubview:_synthesisScoreLabel];
//    
//    UILabel *synthesisScoreTitleLabel = [[UILabel alloc]init];
//    synthesisScoreTitleLabel.frame = matchPositionTitleLabel.frame;
//    synthesisScoreTitleLabel.backgroundColor = [UIColor clearColor];
//    synthesisScoreTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
//    synthesisScoreTitleLabel.text= @"剩余任务";
//    synthesisScoreTitleLabel.textAlignment = NSTextAlignmentCenter;
//    synthesisScoreTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
//    [cardView addSubview:synthesisScoreTitleLabel];
    
    
    
    _taskLabel = [[UILabel alloc]init];
    _taskLabel.frame =_matchPositionLabel.frame;
    _taskLabel.backgroundColor = [UIColor clearColor];
    _taskLabel.textColor = RGBACOLOR(0,204,252,1.0f);
    _taskLabel.text= @"0";
    _taskLabel.textAlignment = NSTextAlignmentRight;
    _taskLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    [_cardView addSubview:_taskLabel];
    
    UILabel *taskNumberTitleLabel = [[UILabel alloc]init];
    taskNumberTitleLabel.frame = matchPositionTitleLabel.frame;
    taskNumberTitleLabel.backgroundColor = [UIColor clearColor];
    taskNumberTitleLabel.textColor = RGBACOLOR(100,100,100,1.0f);
    taskNumberTitleLabel.text= @"匹配职位";
    taskNumberTitleLabel.textAlignment = NSTextAlignmentRight;
    taskNumberTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:12.f];
    [_cardView addSubview:taskNumberTitleLabel];
    
    
    _taskButton = [[UIButton alloc]init];
    _taskButton.frame =CGRectMake(10, _matchPositionLabel.frame.origin.y, WIDTH/2-20, 100);
    [_taskButton addTarget:self action:@selector(lookTask) forControlEvents:UIControlEventTouchUpInside];
    //_taskButton.backgroundColor = RGBACOLOR(190, 231, 214, 0.5);
    _taskButton.backgroundColor = [UIColor clearColor];
    [_cardView addSubview:_taskButton];
    
    
    UIButton *positionButton = [[UIButton alloc]init];
    positionButton.frame = CGRectMake(_taskButton.frame.origin.x+_taskButton.frame.size.width+10, _matchPositionLabel.frame.origin.y, WIDTH/2-10, 100);
    positionButton.backgroundColor = [UIColor clearColor];
    [positionButton addTarget:self action:@selector(lookPosition) forControlEvents:UIControlEventTouchUpInside];
    [_cardView addSubview:positionButton];

    
    NSUserDefaults *hrPrivilege = [NSUserDefaults standardUserDefaults];
    _user_type = [NSString stringWithFormat:@"%@",[hrPrivilege objectForKey:@"hrPrivilege"]];
    
    
    if ([_user_type isEqualToString:@"0"]) {  // 不是hr

        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"设置",nil];
        
    }else{
        
        _modelListArray = [[NSArray alloc]initWithObjects:
                           @"钱包",@"投递记录和收藏",@"我的好友",@"激活HR特权？",@"设置",nil];
    }

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

    
    _editView = [[UIView alloc]init];
    _editView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _editView.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    _editView.hidden = YES;
    [self.view addSubview:_editView];
    
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 25, 44, 44);
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(hideView)forControlEvents:UIControlEventTouchUpInside];
    [_editView addSubview:_backBtn];
    
//    
//    _waitPhotoImageView = [[UIImageView alloc]init];
////    _waitPhotoImageView.frame = CGRectMake(_userPhotoImageView.frame.origin.x, _userPhotoImageView.frame.origin.y+30, _userPhotoImageView.frame.size.width, _userPhotoImageView.frame.size.height);
//    _waitPhotoImageView.frame = _userPhotoImageView.frame;
//    _waitPhotoImageView.layer.masksToBounds = YES;
//    _waitPhotoImageView.layer.cornerRadius = 50;
//    [_editView addSubview:_waitPhotoImageView];
//
//    
//    UIButton *editPhotoButton = [[UIButton alloc]init];
//    editPhotoButton.frame =CGRectMake(0, _waitPhotoImageView.frame.size.height+_waitPhotoImageView.frame.origin.y+30, WIDTH, 60);
//    [editPhotoButton setTitle:@"修改头像" forState:UIControlStateNormal];
//    [editPhotoButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f)forState:UIControlStateNormal];
//    [editPhotoButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
//    [editPhotoButton setBackgroundImage:[UIImage imageNamed:@"0cell_bg"] forState:UIControlStateHighlighted];
//    editPhotoButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
//    editPhotoButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
//    [editPhotoButton addTarget:self action:@selector(onClickImageView) forControlEvents:UIControlEventTouchUpInside];
//    editPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [_editView addSubview:editPhotoButton];
    
    UIButton *editNameButton = [[UIButton alloc]init];
    editNameButton.frame =CGRectMake(0, _backBtn.frame.size.height+_backBtn.frame.origin.y+65, WIDTH, 60);
    [editNameButton setTitle:@"修改昵称" forState:UIControlStateNormal];
    [editNameButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f)forState:UIControlStateNormal];
    [editNameButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    [editNameButton setBackgroundImage:[UIImage imageNamed:@"0cell_bg"] forState:UIControlStateHighlighted];
    editNameButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    editNameButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [editNameButton addTarget:self action:@selector(editNameAction) forControlEvents:UIControlEventTouchUpInside];
    editNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_editView addSubview:editNameButton];
    
    _waitUsernameLabel = [[UILabel alloc]init];
    _waitUsernameLabel.frame = CGRectMake((WIDTH-200-20), 0, 200, editNameButton.frame.size.height);
    _waitUsernameLabel.textColor =RGBACOLOR(0, 199, 255, 1.0f);
    _waitUsernameLabel.backgroundColor = [UIColor clearColor];
    _waitUsernameLabel.textAlignment = NSTextAlignmentRight;
    [editNameButton addSubview:_waitUsernameLabel];
    
    UIButton *editPasswordButton = [[UIButton alloc]init];
    editPasswordButton.frame =CGRectMake(0, editNameButton.frame.size.height+editNameButton.frame.origin.y, WIDTH, 60);
    [editPasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
    [editPasswordButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f)forState:UIControlStateNormal];
    [editPasswordButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
    [editPasswordButton setBackgroundImage:[UIImage imageNamed:@"0cell_bg"] forState:UIControlStateHighlighted];
    editPasswordButton.backgroundColor = [UIColor clearColor];
    editPasswordButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    editPasswordButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [editPasswordButton addTarget:self action:@selector(editPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    editPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_editView addSubview:editPasswordButton];
    
    
    
    _editNameView = [[UIView alloc]init];
    _editNameView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _editNameView.backgroundColor = [UIColor whiteColor];
    _editNameView.hidden = YES;
    [_editView addSubview:_editNameView];
    
   UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 25, 44, 44);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(hideEditnameView)forControlEvents:UIControlEventTouchUpInside];
    [_editNameView addSubview:backBtn];
    
    
    UILabel *editNameTipLabel = [[UILabel alloc]init];
    editNameTipLabel.frame = CGRectMake(35, backBtn.frame.size.height+backBtn.frame.origin.y+20, self.view.frame.size.width-2*35, 35);
    editNameTipLabel.text = @"新昵称";
    editNameTipLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    editNameTipLabel.textColor = RGBACOLOR(70, 70, 70, 1.0f);
    [_editNameView addSubview:editNameTipLabel];
    
    _editNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(editNameTipLabel.frame.origin.x, editNameTipLabel.frame.size.height+editNameTipLabel.frame.origin.y+10,editNameTipLabel.frame.size.width, 40)];
    [_editNameTextField setBorderStyle:UITextBorderStyleLine];
    //    _editNameTextField.placeholder = @"";
//    _editNameTextField.text = _userNameLabel.text;
    _editNameTextField.delegate = self;
    _editNameTextField.font =[UIFont fontWithName:@"Helvetica" size:14];
    _editNameTextField.layer.borderColor=[RGBACOLOR(0, 203, 251, 1.0f)CGColor];
    _editNameTextField.keyboardType = UIKeyboardTypeDefault;
    _editNameTextField.returnKeyType = UIReturnKeyDone;
    _editNameTextField.delegate = self;
    _editNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _editNameTextField.layer.borderWidth = 1.0f;
    UIView *retractView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _editNameTextField.leftView = retractView;
    _editNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [_editNameView addSubview:_editNameTextField];
    
    
    [self getUserInfo];
    [self timer];
}

#pragma mark -- 键盘 return
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_editNameTextField resignFirstResponder];

    
    [self userUpdateNickname];
    return YES;
    
}

#pragma mark 修改名称接口
-(void)userUpdateNickname{
    
    NSUInteger pLength = 1;
    
    if (_editNameTextField.text.length < pLength) {
        
        [APIClient showMessage:@"亲，新名称不能为空哟～"];
        
    }else{
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
        
        [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
        [dic setObject:_editNameTextField.text forKey:@"nickname"];
        
        [User userUpdateNickname:dic WithBlock:^(User *user, Error *e) {
            
            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];
                
            }else{
                
                int intRes = [user.res intValue];
                if (intRes == 1) {
                    [APIClient showSuccess:@"昵称修改成功" title:@"成功"];
                    
                    [_editNameTextField becomeFirstResponder];
                    _waitUsernameLabel.text = _editNameTextField.text;
                    [_userNameButton setTitle:_editNameTextField.text forState:UIControlStateNormal];
                    [self hideEditnameView];
                }
                
            }
            
        }];
        
    }
    
}

#pragma mark 隐藏编辑姓名的界面
-(void)hideEditnameView{

    _editNameView.hidden = YES;
    [_editNameTextField resignFirstResponder];

}

#pragma mark 查看匹配的职位
-(void)lookPosition{

}

#pragma mark 查看剩余任务
-(void)lookTask{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self.tabBarController.navigationController pushViewController:mainVC animated:true];
}


#pragma mark 修改昵称
-(void)editNameAction{

//    EditNameViewController *editName = [[EditNameViewController alloc]init];
//    editName.editNameString = _userNameLabel.text;
//    [self.navigationController pushViewController:editName animated:YES];
    
    _editNameView.hidden = NO;
    [_editNameTextField becomeFirstResponder];

}

#pragma mark 修改密码
-(void)editPasswordAction{
    
    EditPasswordViewController *editPassword = [[EditPasswordViewController alloc]init];
    [self.navigationController pushViewController:editPassword animated:YES];
}


#pragma mark 安全与隐私
-(void)safeAction{
    
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];

}

#pragma mark  获取 user 模块的用户基本信息
-(void)getUserInfo{
    
        NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
        
        [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        [User getUserInfoData:dic WithBlock:^(User *user, Error *e) {
            
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];

            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];
                
            }else{
                
                [_userPhotoImageView setImageWithURL:[NSURL URLWithString:user.photo_url] placeholderImage:[UIImage imageNamed:@"0logooutapp"]];
                
                [_waitPhotoImageView setImageWithURL:[NSURL URLWithString:user.photo_url]];
                _editNameTextField.text = user.user_name;
                [_userNameButton setTitle:user.user_name forState:UIControlStateNormal];
                _hirelibNumberLabel.text =[@"hirelib No." stringByAppendingFormat:@"%@",user.hirelib_code];
                
                NSString *stringInt = [NSString stringWithFormat:@"%@",user.mission_number];
                _taskLabel.text = user.position_number;//匹配职位
                _matchPositionLabel.text = stringInt;//剩余任务
                
                _walletNumberLabel.text = user.user_intergral;
                _waitUsernameLabel.text = user.user_name;
                
                _hr_url = user.hr_url;
                _pay_url = user.pay_url;
                _user_apply_url = user.user_apply_url;
                _user_friend_url = user.user_friend_url;
                
            }
            
        }];
}

#pragma mark 使用计时器 更新剩余任务数
-(void)timer{

    __block int timeout=12*3600; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),2.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
            });
        }else{

            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                
                [self getUserMissionNumber];
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark  获取 user 剩余任务数
-(void)getUserMissionNumber{
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    
    if ([token objectForKey:@"token"] !=nil) {
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
        
        [User getUserMissionNumber:dic WithBlock:^(User *user, Error *e) {
            
            if (e.info !=nil) {
                
                [APIClient showInfo:e.info title:@"提示"];
                
            }else{
                
                NSString *stringInt = [NSString stringWithFormat:@"%@",user.missionNumber];
                _matchPositionLabel.text = stringInt;//剩余任务
                
            }
            
        }];

    }
    
}


-(void)hideView{
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.1;
    [_editView.layer addAnimation:animation forKey:nil];
    
    _editView.hidden = YES;
    _backBtn.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


-(void)showEditPersonInfoView{
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.1;
    [_editView.layer addAnimation:animation forKey:nil];
    
    self.tabBarController.tabBar.hidden = YES;
    _backBtn.hidden = NO;
    _editView.hidden = NO;

}


// 调用相机
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

// 跳转到相机 或 相册界面
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
    [_waitPhotoImageView setImage:savedImage];
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
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];
    [dic setObject:[token objectForKey:@"token"] forKey:@"token"];
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
    
    return 52.f;
}

#pragma mark -- UITableView cell 个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
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
            
            _walletNumberLabel = [[UILabel alloc]init];
            _walletNumberLabel.frame = CGRectMake(WIDTH-50-20, 10, 50, 30);
            _walletNumberLabel.text = @"1000";
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
            
            _walletNumberLabel = [[UILabel alloc]init];
            _walletNumberLabel.frame = CGRectMake(WIDTH-50-20, 10, 50, 30);
            _walletNumberLabel.text = @"1000";
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
    
    [_userTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    
    if ([_user_type isEqualToString:@"0"]) { //  不是hr
        
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
    
}


//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}



@end
