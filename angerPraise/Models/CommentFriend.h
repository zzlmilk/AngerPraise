//
//  CommentFriend.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface CommentFriend : NSObject

@property(nonatomic,strong)NSString *friend_evluation_status; // 点评状态 0 不可点评  1 可点评
@property(nonatomic,strong)NSString *friend_evluation_url; // 点评页面url
@property(nonatomic,strong)NSString *photo_url; //头像url
@property(nonatomic,strong)NSString *user_name; //名称



//获取待点评好友列表
+(NSURLSessionDataTask *)getCommentFriendList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *commentFriendArray, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
