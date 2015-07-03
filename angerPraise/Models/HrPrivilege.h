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
@interface HrPrivilege : NSObject

@property(nonatomic,strong)NSString *friend_number;  //可点评好友数
@property(nonatomic,strong)NSString *synthesize_grade; //综合评分
@property(nonatomic,strong)NSString *synthesize_grade_url; //综合评分url
//@property(nonatomic,strong)NSString *user_intergral;  //赏银数量
@property(nonatomic,strong)NSString *today_award_total;
@property(nonatomic,strong)NSString *today_receive_award;

@property(nonatomic,strong)NSString *interview_number;

@property(nonatomic,strong)NSMutableArray *commentFriendArray;

@property Review *review;


//HR接口
+(NSURLSessionDataTask *)getHrReviewInfo:(NSDictionary *)parameters WithBlock:(void (^)(HrPrivilege *hr, Error *e))block;


-(instancetype)initWithDic:(NSDictionary *)dic;


@end