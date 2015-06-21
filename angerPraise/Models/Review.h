//
//  Review.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/27.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property(nonatomic,strong)NSString *friend_evluation_status; // 点评状态 0 不可点评  1 可点评
@property(nonatomic,strong)NSString *friend_evluation_url; // 点评页面url
@property(nonatomic,strong)NSString *photo_url; //头像url
@property(nonatomic,strong)NSString *user_name; //名称

@end
