//
//  HomeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeViewController.h"
#import "ZCAddressBook.h"

#import "NZAlertView.h"

#import "ResumeScoreViewController.h"
#import "MyDynamicViewController.h"
#import "CommentFriendViewController.h"
#import "InterviewPayViewController.h"
#import "HrPrivilegeViewController.h"

#import "Home.h"
#import "SMS_MBProgressHUD.h"
#import "AddressBook.h"


@interface HomeViewController ()

@property int section;

@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getHomeInfo];
    
    [self userAttributes];
    
    //首页的 简历综合评分
    _resumeScoreView = [[UIView alloc]init];
    _resumeScoreView.frame = CGRectMake(0, 0, WIDTH/2, (HEIGHT-49)/_section);
    _resumeScoreView.backgroundColor = RGBACOLOR(66, 146, 198, 1.0f);
    [self.view addSubview:_resumeScoreView];
    
    _resumeScoreData = [[UILabel alloc]init];
    _resumeScoreData.frame = CGRectMake(0, 20, _resumeScoreView.bounds.size.width, 35);
//    _resumeScoreData.text = @"65";
    _resumeScoreData.backgroundColor = [UIColor yellowColor];
    [_resumeScoreView addSubview:_resumeScoreData];
    
    UILabel *resumeScoreLabel = [[UILabel alloc]init];
    resumeScoreLabel.frame = CGRectMake(0, _resumeScoreData.frame.size.height+_resumeScoreData.frame.origin.y+10, _resumeScoreView.bounds.size.width, 35);
    resumeScoreLabel.text = @"简历综合评分";
    resumeScoreLabel.backgroundColor = [UIColor yellowColor];
    [_resumeScoreView addSubview:resumeScoreLabel];

    UIButton *resumeScoreButton = [[UIButton alloc]init];
    resumeScoreButton.frame = _resumeScoreView.frame;
    [resumeScoreButton addTarget:self action:@selector(resumeScoreAction) forControlEvents:UIControlEventTouchUpInside];
//    resumeScoreButton.backgroundColor =RGBACOLOR(222, 235, 247, 1.0f);
    [_resumeScoreView addSubview:resumeScoreButton];
    
    
    
    // 分割线
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(_resumeScoreView.frame.size.width, 0, 2, (HEIGHT-49)/4);
    lineLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineLabel];
    
    //我的动态统计
    _myDynamicInfoView = [[UIView alloc]init];
    _myDynamicInfoView.frame = CGRectMake(lineLabel.frame.size.width+lineLabel.frame.origin.x, 0, WIDTH/2, (HEIGHT-49)/_section);
    _myDynamicInfoView.backgroundColor = RGBACOLOR(66, 146, 198, 1.0f);
    [self.view addSubview:_myDynamicInfoView];
    
    UILabel *myDynamicInfoLabel = [[UILabel alloc]init];
    myDynamicInfoLabel.frame = CGRectMake(0, 20, _myDynamicInfoView.bounds.size.width, 35);
    myDynamicInfoLabel.text = @"我的动态统计";
    myDynamicInfoLabel.backgroundColor = [UIColor yellowColor];
    [_myDynamicInfoView addSubview:myDynamicInfoLabel];
    
    UIButton *myDynamicInfoButton = [[UIButton alloc]init];
    myDynamicInfoButton.frame = _myDynamicInfoView.frame;
    [myDynamicInfoButton addTarget:self action:@selector(myDynamicInfoAction) forControlEvents:UIControlEventTouchUpInside];
//    myDynamicInfoButton.backgroundColor = RGBACOLOR(198, 219, 239, 1.0f);
    [self.view addSubview:myDynamicInfoButton];
    
    
    //待点评好友
    _commentFriendView = [[UIView alloc]init];
    _commentFriendView.frame = CGRectMake(0, _myDynamicInfoView.frame.size.height+_myDynamicInfoView.frame.origin.y, WIDTH, (HEIGHT-49)/_section);
    _commentFriendView.backgroundColor = RGBACOLOR(107, 174, 214, 1.0f);
    [self.view addSubview:_commentFriendView];
    
    _commentFriendData = [[UILabel alloc]init];
    _commentFriendData.frame = CGRectMake(0, 20, _commentFriendView.bounds.size.width, 35);
//    _commentFriendData.text = @"5";
    _commentFriendData.backgroundColor = [UIColor yellowColor];
    [_commentFriendView addSubview:_commentFriendData];
    
    UILabel *commentFriendLabel = [[UILabel alloc]init];
    commentFriendLabel.frame = CGRectMake(0, _commentFriendData.frame.size.height+_commentFriendData.frame.origin.y+10, _commentFriendView.bounds.size.width, 35);
    commentFriendLabel.text = @"待点评好友";
    commentFriendLabel.backgroundColor = [UIColor yellowColor];
    [_commentFriendView addSubview:commentFriendLabel];
    
    UIButton *commentFriendButton = [[UIButton alloc]init];
    commentFriendButton.frame = _commentFriendView.frame;
    [commentFriendButton addTarget:self action:@selector(commentFriendAction) forControlEvents:UIControlEventTouchUpInside];
//    commentFriendButton.backgroundColor =RGBACOLOR(158, 202, 225, 1.0f);
    [self.view addSubview:commentFriendButton];
    
    
    
    //面试补贴
    _interviewPayView= [[UIView alloc]init];
    _interviewPayView.frame = CGRectMake(0, _commentFriendView.frame.size.height+_commentFriendView.frame.origin.y, WIDTH, (HEIGHT-49)/_section);
    _interviewPayView.backgroundColor = RGBACOLOR(158, 202, 225, 1.0f);
    [self.view addSubview:_interviewPayView];
    
    _interviewPayData = [[UILabel alloc]init];
    _interviewPayData.frame = CGRectMake(0, 20, _interviewPayView.bounds.size.width, 35);
//    _interviewPayData.text = @"2";
    _interviewPayData.backgroundColor = [UIColor yellowColor];
    [_interviewPayView addSubview:_interviewPayData];
    
    UILabel *interviewPayLabel = [[UILabel alloc]init];
    interviewPayLabel.frame = CGRectMake(0, _interviewPayData.frame.origin.y+_interviewPayData.frame.size.height+10, _interviewPayView.bounds.size.width, 35);
    interviewPayLabel.text = @"面试补贴";
    interviewPayLabel.backgroundColor = [UIColor yellowColor];
    [_interviewPayView addSubview:interviewPayLabel];
    
    UIButton *interviewPayButton = [[UIButton alloc]init];
    interviewPayButton.frame = _interviewPayView.frame;
    [interviewPayButton addTarget:self action:@selector(interviewPayAction) forControlEvents:UIControlEventTouchUpInside];
    //interviewPayButton.backgroundColor = RGBACOLOR(107, 174, 214, 1.0f);
    [self.view addSubview:interviewPayButton];
    
    
    //HR特权
    _hrPrivilegeView= [[UIView alloc]init];
    _hrPrivilegeView.frame = CGRectMake(0, _interviewPayView.frame.size.height+_interviewPayView.frame.origin.y, WIDTH, (HEIGHT-49)/_section);
    _hrPrivilegeView.backgroundColor = RGBACOLOR(198, 219, 235, 1.0f);
    [self.view addSubview:_hrPrivilegeView];
    
    _hrPrivilegeData = [[UILabel alloc]init];
    _hrPrivilegeData.frame = CGRectMake(0, 20, _hrPrivilegeView.bounds.size.width, 35);
//    _hrPrivilegeData.text = @"3";
    _hrPrivilegeData.backgroundColor = [UIColor yellowColor];
    [_hrPrivilegeView addSubview:_hrPrivilegeData];
    
    UILabel *hrPrivilegeLabel = [[UILabel alloc]init];
    hrPrivilegeLabel.frame = CGRectMake(0, _hrPrivilegeData.frame.size.height+_hrPrivilegeData.frame.origin.y+10, _hrPrivilegeView.bounds.size.width, 35);
    hrPrivilegeLabel.text = @"HR特权";
    hrPrivilegeLabel.backgroundColor = [UIColor yellowColor];
    [_hrPrivilegeView addSubview:hrPrivilegeLabel];
    
    UIButton *hrPrivilegeButton = [[UIButton alloc]init];
    hrPrivilegeButton.frame = _hrPrivilegeView.frame;
    [hrPrivilegeButton addTarget:self action:@selector(hrPrivilegeAction) forControlEvents:UIControlEventTouchUpInside];
//    hrPrivilegeButton.backgroundColor =RGBACOLOR(198, 219, 2391, 1.0F);
    [self.view addSubview:hrPrivilegeButton];
    
    _resumeScoreUrlLabel = [[UILabel alloc]init];
    _resumeScoreUrlLabel.frame = CGRectMake(20, 100, WIDTH, 30);
    _resumeScoreUrlLabel.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_resumeScoreUrlLabel];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(30, 360, 90, 35);
    [btn setTitle:@"读取通讯录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getAddressBook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}



#pragma 判断用户属性
-(void)userAttributes{
    
    NSString *user_type=@"4";  //4 hr   1 普通用户
    
    NSUserDefaults *userType = [NSUserDefaults standardUserDefaults];
    [userType setObject:user_type forKey:@"userType"];
    
    if ([user_type isEqualToString:@"4"]) { //HR
        
        _section =4;
        
    }else{  //非HR
    
        _section =3;
        _hrPrivilegeView.hidden = YES;
        
    }

}



-(void)getHomeInfo{

    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"user_id"];

    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Home getHomeInfo:dic WithBlock:^(Home *home, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        _resumeScoreData.text = home.synthesize_grade;
        _commentFriendData.text = home.friend_number;
        _interviewPayData.text = home.interview_number;
        _hrPrivilegeData.text = home.hr_interview_number;
        _resumeScoreUrlLabel.text = home.synthesize_grade_url;
    }];    

}

#pragma 获取通讯录信息
-(void)getAddressBook{
    //获得Vcard
    NSMutableDictionary* dick= [[ZCAddressBook shareControl]getPersonInfo];
    //获得序列索引
    NSArray *array=[[ZCAddressBook shareControl]sortMethod];
    NSLog(@"Vcard%@~~~序列%@",dick,array);
    
    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
//    [userId setObject:login.user_id forKey:@"userId"];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:dick forKey:@"phone_book"];
    [dic setObject:[userId objectForKey:@"userId"] forKey:@"user_id"];
    
    [AddressBook uploadAddressBook:dic WithBlock:^(AddressBook *addressBook, Error *e) {
       
        
    }];
    
    
    
    
    
//    _dicBook = [[NSMutableDictionary alloc]init];
//    
//    ABAddressBookRef tmpAddressBook = nil;
//    tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
//    dispatch_semaphore_t sema=dispatch_semaphore_create(0);
//    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
//
//        dispatch_semaphore_signal(sema);
//    });
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    
//    //取得通讯录失败
//
//    if (tmpAddressBook==nil) {
//        return ;
//
//    }else{
//    
//        //将通讯录中的信息用数组方式读出
//        NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
//    
//        for(id tmpPerson in tmpPeoples){
//            
//            //获取的联系人单一属性:First name
//            NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
//            NSLog(@"First name:%@", tmpFirstName);
//
//            //获取的联系人单一属性:Last name
//            NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
//            NSLog(@"Last name:%@", tmpLastName);
//            
//
//            //获取的联系人单一属性:Nickname
//            NSString* tmpNickname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNicknameProperty);
//            NSLog(@"Nick__bridge name:%@", tmpNickname);
//
//
//            //获取的联系人单一属性:Company name
//            NSString* tmpCompanyname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonOrganizationProperty);
//            NSLog(@"Company name:%@", tmpCompanyname);
//
//            
//            
//            //获取的联系人单一属性:Job Title
//            NSString* tmpJobTitle= (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonJobTitleProperty);
//            NSLog(@"Job Title:%@", tmpJobTitle);
//
//
//            //获取的联系人单一属性:Department name
//            NSString* tmpDepartmentName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonDepartmentProperty);
//            NSLog(@"Department name:%@", tmpDepartmentName);
//
//
//            //获取的联系人单一属性:Email(s)
//            ABMultiValueRef tmpEmails = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonEmailProperty);
//            for(NSInteger j = 0; ABMultiValueGetCount(tmpEmails); j++)
//
//            {
//
//                NSString* tmpEmailIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, j);
//                NSLog(@"Emails%ld:%@", (long)j, tmpEmailIndex);
//
//                
//            }
//
//            CFRelease(tmpEmails);
//
//            //获取的联系人单一属性:Birthday
//
//            NSDate* tmpBirthday = (__bridge NSDate*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonBirthdayProperty);
//            NSLog(@"Birthday:%@", tmpBirthday);
//
//
//            //获取的联系人单一属性:Note
//
//            NSString* tmpNote = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNoteProperty);
//            NSLog(@"Note:%@", tmpNote);
//
//
//            //获取的联系人单一属性:Generic phone number
//
//            ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
//
//            for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
//
//            {
//
//                NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
//
//                NSLog(@"tmpPhoneIndex%ld:%@", (long)j, tmpPhoneIndex);
//
//
//            }
//            
//            CFRelease(tmpPhones);
//            
////            NSString *fullNameString = [NSString initWithFormat:@"%@,%@", tmpFirstName, tmpLastName ];
//            
//            
//            [_dicBook setObject:(__bridge id)(tmpPhones) forKey:@"user_id"];
//            
//        }
//
//        
//    }
//    
}


//简历综合评分
-(void)resumeScoreAction{
    
    

    ResumeScoreViewController *resumeScoreVC = [[ResumeScoreViewController alloc]init];
    resumeScoreVC.resumeScoreUrl = _resumeScoreUrlLabel.text;
    [self.navigationController pushViewController:resumeScoreVC animated:YES];
    
}

//我的动态统计
-(void)myDynamicInfoAction{
    
    MyDynamicViewController *myDynamicVC = [[MyDynamicViewController alloc]init];
    [self.navigationController pushViewController:myDynamicVC animated:YES];
    
}

//待点评好友
-(void)commentFriendAction{
    
    CommentFriendViewController *commentFriendVC = [[CommentFriendViewController alloc]init];
    [self.navigationController pushViewController:commentFriendVC animated:YES];
    
}

//面试补贴
-(void)interviewPayAction{
    
    InterviewPayViewController *interviewPayVC = [[InterviewPayViewController alloc]init];
    [self.navigationController pushViewController:interviewPayVC animated:YES];
    
}

//HR特权
-(void)hrPrivilegeAction{
    
    HrPrivilegeViewController *hrPrivilegeVC = [[HrPrivilegeViewController alloc]init];
    [self.navigationController pushViewController:hrPrivilegeVC animated:YES];
    
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
