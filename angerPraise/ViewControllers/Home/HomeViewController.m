//
//  HomeViewController.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HomeViewController.h"
#import "InfiniteScrollPicker.h"
#import "SMS_MBProgressHUD.h"

#import "CommentFriendCell.h"
#import "CommentFriend.h"
#import "UIImageView+AFNetworking.h"

@interface HomeViewController ()
{
    InfiniteScrollPicker *isp;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBACOLOR(20, 20, 20, 1.0f);
    
    [self getCommentFriendInfo];
    
    _titleView = [[UIView alloc]init];
    _titleView.frame =CGRectMake(0, 0, WIDTH, 50);
    _titleView.backgroundColor = RGBACOLOR(40, 40, 40, 1.0f);
    [self.view addSubview:_titleView];
    
    UIButton *titleButton= [[UIButton alloc]init];
    titleButton.frame = CGRectMake(100, 0, WIDTH-2*100, _titleView.frame.size.height);
    [titleButton setTitle:@"怒 赞" forState:UIControlStateNormal];
    [titleButton setTitleColor:RGBACOLOR(255, 255, 255, 1.0f) forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    titleButton.backgroundColor = [UIColor clearColor];
    [_titleView addSubview:titleButton];
    
    
    //滑动圆球 开始
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(10, 50, self.view.frame.size.width-2*10, 80);
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.delegate = self;
    //_scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width+185, 70)];
    [self.view addSubview:_scrollView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(60, 60)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
    
    _homeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width/7, 5, self.view.frame.size.width+100, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _homeCollectionView.dataSource = self;
    _homeCollectionView.delegate = self;
    _homeCollectionView.backgroundColor = [UIColor clearColor];
    [_homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_scrollView addSubview:_homeCollectionView];
    //滑动圆球 结束
    
    _homeWebView = [[UIWebView alloc] init];
    _homeWebView.frame = CGRectMake(10, _scrollView.frame.size.height+_scrollView.frame.origin.y+5,WIDTH-2*10, HEIGHT - _scrollView.frame.size.height-_scrollView.frame.origin.y-60);
    _homeWebView.layer.cornerRadius = 10.f;
    [_homeWebView setClipsToBounds:YES];
    [[_homeWebView layer]setBorderColor:[UIColor blackColor].CGColor];
    [[_homeWebView layer]setBorderWidth:1.0f];
    _homeWebView.delegate = self;

    [_homeWebView setUserInteractionEnabled:YES];
    [self.view addSubview:_homeWebView];
    
}

-(void)getCommentFriendInfo{
    
    //    NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
    //    [userId setObject:login.user_id forKey:@"userId"];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"user_id"];
    
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [CommentFriend getCommentFriendList:dic WithBlock:^(NSMutableArray *commentFriendArray, Error *e) {
        
        [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // NSLog(@"%@",commentFriendArray);
        _collectionArray = commentFriendArray;
        [_homeCollectionView reloadData];
    }];
    
}


#pragma mark - collectionView dataSource Or delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionArray.count+2;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(indexPath.section==0)
    {
        cell.backgroundColor = [UIColor redColor];
        cell.layer.cornerRadius = 30.f;
    }
    
    //CommentFriend *commtDic = [_collectionArray objectAtIndex:indexPath.row];


    if (indexPath.row ==0) {
        cell.backgroundColor = [UIColor yellowColor];
        UILabel *payLabel = [[UILabel alloc]init];
        payLabel.frame= CGRectMake(0, 15, 60, 30);
        payLabel.text = @"125";
        payLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:payLabel];
    }else if (indexPath.row ==1){
        
        UIImageView *bgImageView = [[UIImageView alloc]init];
        bgImageView.frame = CGRectMake(0, 0, 60, 60);
        [bgImageView setImageWithURL:
         [NSURL URLWithString:@"http://app.hirelib.com/photo/149.jpg"]];
        bgImageView.layer.cornerRadius = 30.f;
        bgImageView.layer.masksToBounds=YES;
        [cell addSubview:bgImageView];
    
    }else if(indexPath.row ==2){

        UIImageView *bgImageView = [[UIImageView alloc]init];
        bgImageView.frame = CGRectMake(0, 0, 60, 60);
        [bgImageView setImageWithURL:[NSURL URLWithString:@"http://wx.qlogo.cn/mmopen/kr1yFKtaMQaloVm9RVLrWru3pzE2MiblxeJpN2CxMuIiauRzefSMU8d7FzjXRHRfZ1iae1ojUQKyr5hicxpDDmTg8uOGKkjeH3f5/0"]];
        bgImageView.layer.cornerRadius = 30.f;
        bgImageView.layer.masksToBounds=YES;
        [cell addSubview:bgImageView];
        
    }else if(indexPath.row==3){
        
        UILabel *payLabel = [[UILabel alloc]init];
        payLabel.frame= CGRectMake(0, 15, 60, 30);
        payLabel.text = @"65%";
        payLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:payLabel];
    
    }
    
    
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    cell.backgroundColor = [UIColor yellowColor];
    NSLog(@"row=======%ld",(long)indexPath.row);
    NSLog(@"section===%ld",(long)indexPath.section);
    
    if (indexPath.row ==3) {
        
        NSURL *url=[NSURL URLWithString:@"http://app.hirelib.com/website/user/user_resume?user_id=1"];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        [_homeWebView loadRequest:request];
        
    }else{
        
        CommentFriend *commtDic = [_collectionArray objectAtIndex:indexPath.row-1];

        if (indexPath.row ==1) {
            
            NSURL *url=[NSURL URLWithString:commtDic.friend_evluation_url];
            NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
            [_homeWebView loadRequest:request];
            
        }else if (indexPath.row ==2) {
            
            NSURL *url=[NSURL URLWithString:commtDic.friend_evluation_url];
            NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
            [_homeWebView loadRequest:request];
        }
    
    }

}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        return NO;
    }
    return YES;
}



//网页 刚开始加载
- (void)webViewDidStartLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

//网页 加载完成
- (void)webViewDidFinishLoad:(UIWebView  *)webView{
    
    [SMS_MBProgressHUD hideHUDForView:self.view animated:YES];
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
