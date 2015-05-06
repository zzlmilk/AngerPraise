//
//  InviteFriendViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "InviteFriendCell.h"

@interface InviteFriendViewController ()

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"k1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UILabel *stayReviewLabel = [[UILabel alloc]init];
    stayReviewLabel.frame = CGRectMake(20, backBtn.frame.size.height+backBtn.frame.origin.y+30, WIDTH, 35);
    stayReviewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    stayReviewLabel.backgroundColor = [UIColor clearColor];
    stayReviewLabel.text = @"邀请好友";
    [self.view addSubview:stayReviewLabel];
    
    UILabel *stayReviewTipLabel = [[UILabel alloc]init];
    stayReviewTipLabel.frame = CGRectMake(20, stayReviewLabel.frame.size.height+stayReviewLabel.frame.origin.y-10, WIDTH, 35);
    stayReviewTipLabel.textColor = [UIColor grayColor];
    stayReviewTipLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    stayReviewTipLabel.backgroundColor = [UIColor clearColor];
    stayReviewTipLabel.text = @"邀请更多好友, 增加点评数量";
    [self.view addSubview:stayReviewTipLabel];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(15, stayReviewTipLabel.frame.size.height+stayReviewTipLabel.frame.origin.y+1, WIDTH, 0.5);
    lineLabel.backgroundColor = RGBACOLOR(204, 204, 204, 1.0f);
    [self.view addSubview:lineLabel];
    
    
    _inviteFriendTableView = [[UITableView alloc]init];
    _inviteFriendTableView.frame = CGRectMake(0,  lineLabel.frame.size.height+lineLabel.frame.origin.y+1, WIDTH,HEIGHT);
    _inviteFriendTableView.delegate = self;
    _inviteFriendTableView.dataSource = self;
    [self.view addSubview:_inviteFriendTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark -- UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellId = @"cellId";
    
    InviteFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    InviteFriend *i = [_inviteFriendArray objectAtIndex:indexPath.row];
    
    cell.inviteFriendList = i;
    
    if (cell == nil)
    {
        cell = [[InviteFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellId];
        
    }
    
    _inviteButton = [[UIButton alloc]init];
    _inviteButton.frame = CGRectMake(250, 15, 100, 70);
    [_inviteButton addTarget:self action:@selector(inviteFriend:) forControlEvents:UIControlEventTouchUpInside];
    _inviteButton.tag = indexPath.row;
    _inviteButton.backgroundColor = [UIColor clearColor];
    [_inviteButton setTitleColor:RGBACOLOR(75, 90, 247, 1.0f) forState:UIControlStateNormal];
    [_inviteButton setTitle:@"邀请" forState:UIControlStateNormal];
    [cell.contentView addSubview:_inviteButton];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)inviteFriend:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    NSLog(@"%ld",(long)button.tag);
}


#pragma mark -- UITableView height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.f;
}

#pragma mark -- UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"indexPath.row:%ld",(long)indexPath.row);
//    CommentFriend * p = [_commentFriendArray objectAtIndex:indexPath.row];
//    
//    CommentFriendWebViewController *commentFriendWebVC = [[CommentFriendWebViewController alloc]init];
//    //    commentFriendWebVC.positionDetailUrl = p.webUrl;
//    [self.navigationController pushViewController:commentFriendWebVC animated:YES];
    
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
