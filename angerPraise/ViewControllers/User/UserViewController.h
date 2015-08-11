//
//  UserViewController.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "CardView.h"

@interface UserViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,HomeViewControllerDelegate>
{
    User *user;
}

//UI

@property(nonatomic,strong)CardView *cardView; 

@property(nonatomic,strong)UITableView *userTableView;

//
@property NSArray *modelListArray;// tableView中的cell content

@property(nonatomic,strong)NSString *user_type; //用户类型 是否 HR

@property(nonatomic,strong)NSString *editedNameString;//用户修改昵称后 接收新的昵称

@property(nonatomic,strong)UILabel *walletNumberLabel; //tableView 钱包上显示的赏银数量

@property(nonatomic,strong)UIImage *savedImage; // 用户从相册选中的带上传图片
@property(nonatomic,strong)NSString *userPhotoUrlSting; //用户上传头像的URL地址 如果为空 则读取头像缓存



@end
