//
//  CommentFriendViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/30.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CommentFriendViewController.h"
#import "CommentFriendWebViewController.h"
#import "CommentFriendCell.h"
#import "CommentFriend.h"

#import "InviteFriendViewController.h"
#import "SMS_MBProgressHUD.h"

@interface CommentFriendViewController ()

@end

@implementation CommentFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"n1"]];

    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 44, 44);
    [_backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self getCommentFriendInfo];
    
    
    UILabel *stayReviewLabel = [[UILabel alloc]init];
    stayReviewLabel.frame = CGRectMake(20, _backBtn.frame.size.height+_backBtn.frame.origin.y+30, WIDTH, 35);
    stayReviewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    stayReviewLabel.backgroundColor = [UIColor clearColor];
    stayReviewLabel.text = @"待点评好友";
    [self.view addSubview:stayReviewLabel];
    
    UILabel *stayReviewTipLabel = [[UILabel alloc]init];
    stayReviewTipLabel.frame = CGRectMake(20, stayReviewLabel.frame.size.height+stayReviewLabel.frame.origin.y-10, WIDTH, 35);
    stayReviewTipLabel.textColor = [UIColor grayColor];
    stayReviewTipLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    stayReviewTipLabel.backgroundColor = [UIColor clearColor];
    stayReviewTipLabel.text = @"点评您的好友, 获取红包奖励";
    [self.view addSubview:stayReviewTipLabel];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(15, stayReviewTipLabel.frame.size.height+stayReviewTipLabel.frame.origin.y+1, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel];
    
    
    
    UIButton *InviteFriendButton = [[UIButton alloc]init];
    InviteFriendButton.frame = CGRectMake(0, 40, WIDTH, 35);
    [InviteFriendButton addTarget:self action:@selector(inviteFriend) forControlEvents:UIControlEventTouchUpInside];
    [InviteFriendButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    [InviteFriendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    InviteFriendButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:InviteFriendButton];
    
    
    _commentFriendTableView = [[UITableView alloc]init];
    _commentFriendTableView.frame = CGRectMake(0, lineLabel.frame.size.height+lineLabel.frame.origin.y+1, WIDTH,HEIGHT);
    _commentFriendTableView.delegate = self;
    _commentFriendTableView.dataSource = self;
    [self.view addSubview:_commentFriendTableView];
    
    [self setExtraCellLineHidden:_commentFriendTableView];

}


//隐藏多余分割线
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)getCommentFriendInfo{

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [CommentFriend getCommentFriendList:dic WithBlock:^(NSMutableArray *commentFriendArray, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
       // NSLog(@"%@",commentFriendArray);
        _commentFriendArray = commentFriendArray;
        
        [_commentFriendTableView reloadData];
        
    }];

    

}

//邀请好友
-(void)inviteFriend{

    InviteFriendViewController *inviteFriendVC = [[InviteFriendViewController alloc]init];
    [self.navigationController pushViewController:inviteFriendVC animated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentFriendArray.count;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId = @"cellId";
    
    CommentFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    CommentFriend *c = [_commentFriendArray objectAtIndex:indexPath.row];
    
    cell.commentFriendList = c;
    
    if (cell == nil)
    {
        cell = [[CommentFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.f;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    CommentFriend *c = [_commentFriendArray objectAtIndex:indexPath.row];
    
    CommentFriendWebViewController *commentFriendWebVC = [[CommentFriendWebViewController alloc]init];
    commentFriendWebVC.commentFriendUrl = c.friend_evluation_url;
    
    [self.navigationController pushViewController:commentFriendWebVC animated:YES];
    
}


-(void)doBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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
