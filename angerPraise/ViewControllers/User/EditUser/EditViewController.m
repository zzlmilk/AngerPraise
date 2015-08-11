//
//  EditViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/8/11.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "EditViewController.h"
#import "EditPasswordViewController.h"
#import "EditNameViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
        UIButton *editNameButton = [[UIButton alloc]init];
        editNameButton.frame =CGRectMake(0, 70, WIDTH, 60);
        [editNameButton setTitle:@"修改昵称" forState:UIControlStateNormal];
        [editNameButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f)forState:UIControlStateNormal];
        [editNameButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
        [editNameButton setBackgroundImage:[UIImage imageNamed:@"0cell_bg"] forState:UIControlStateHighlighted];
        editNameButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
        editNameButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [editNameButton addTarget:self action:@selector(editNameAction) forControlEvents:UIControlEventTouchUpInside];
        editNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:editNameButton];
    
        _waitUserNameLabel = [[UILabel alloc]init];
        _waitUserNameLabel.frame = CGRectMake((WIDTH-200-20), 0, 200, editNameButton.frame.size.height);
        _waitUserNameLabel.textColor =RGBACOLOR(0, 199, 255, 1.0f);
        _waitUserNameLabel.backgroundColor = [UIColor clearColor];
        _waitUserNameLabel.textAlignment = NSTextAlignmentRight;
        _waitUserNameLabel.text = _waitUserNameString;
        [editNameButton addSubview:_waitUserNameLabel];
    
        _editPasswordButton = [[UIButton alloc]init];
        _editPasswordButton.frame =CGRectMake(0, editNameButton.frame.size.height+editNameButton.frame.origin.y, WIDTH, 60);
        [_editPasswordButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [_editPasswordButton setTitleColor:RGBACOLOR(252, 254, 253, 1.0f)forState:UIControlStateNormal];
        [_editPasswordButton setTitleColor:btnHighlightedColor forState:UIControlStateHighlighted];
        [_editPasswordButton setBackgroundImage:[UIImage imageNamed:@"0cell_bg"] forState:UIControlStateHighlighted];
        _editPasswordButton.backgroundColor = [UIColor clearColor];
        _editPasswordButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
        _editPasswordButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [_editPasswordButton addTarget:self action:@selector(editPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        _editPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:_editPasswordButton];
    
}


#pragma mark 修改密码
-(void)editPasswordAction{
    
    EditPasswordViewController *editPassword = [[EditPasswordViewController alloc]init];
    [self.navigationController pushViewController:editPassword animated:YES];
}

#pragma mark 修改昵称
-(void)editNameAction{
    
    EditNameViewController *editName = [[EditNameViewController alloc]init];
    [editName.editNameTextField becomeFirstResponder];
    editName.editNameString = _waitUserNameString;
    
    [self.navigationController pushViewController:editName animated:YES];
    
    
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
