//
//  HomeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeOldViewController.h"
#import "ZCAddressBook.h"

#import "Home.h"
#import "SMS_MBProgressHUD.h"
#import "AddressBook.h"
#import "InfiniteScrollPicker.h"


@interface HomeOldViewController ()
{
    InfiniteScrollPicker *isp;
}
@property int section;

@end

@implementation HomeOldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *set1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"s1_%d.png", i]]];
    }
  
    isp = [[InfiniteScrollPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [isp setItemSize:CGSizeMake(50, 50)];
    isp.backgroundColor = [UIColor blackColor];
    [isp setImageAry:set1];
    [isp setSelectedItem:5];
    [self.view addSubview:isp];

    
    
    
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
       // _hrPrivilegeView.hidden = YES;
        
    }

}



-(void)getHomeInfo{
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"4" forKey:@"user_id"];

    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Home getHomeInfo:dic WithBlock:^(Home *home, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];

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
