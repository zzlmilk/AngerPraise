//
//  HomeViewController.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UIScrollViewDelegate,UIWebViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UICollectionView *homeCollectionView;

@property(nonatomic,strong)UIWebView *homeWebView;
@property(nonatomic,strong)NSString *urlString;

@property(nonatomic,strong)NSMutableArray *collectionArray;

@property(nonatomic,strong)UILabel *tipNumberLabel;


@end
