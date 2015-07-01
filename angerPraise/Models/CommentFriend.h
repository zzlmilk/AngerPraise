//
//  CommentFriend.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"
#import "Review.h"

//点评好友模型
@interface CommentFriend : NSObject

@property(nonatomic,strong)NSString *friend_number;  //可点评好友数
@property(nonatomic,strong)NSString *synthesize_grade; //综合评分
@property(nonatomic,strong)NSString *synthesize_grade_url; //综合评分url
//@property(nonatomic,strong)NSString *user_intergral;  //赏银数量
@property(nonatomic,strong)NSString *today_award_total;
@property(nonatomic,strong)NSString *today_receive_award;

@property(nonatomic,strong)NSString *interview_number;

@property(nonatomic,strong)NSMutableArray *commentFriendArray;

@property Review *review;

//获取首页接口信息
//+(NSURLSessionDataTask *)getCommentFriendList:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block;

//HR接口
+(NSURLSessionDataTask *)getHrReviewInfo:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block;

////点评成功后 重新获取 金币和 综合评分
//+(NSURLSessionDataTask *)reviewSuccess:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
