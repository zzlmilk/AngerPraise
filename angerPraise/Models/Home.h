//
//  Home.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Home : NSObject


@property(nonatomic,strong)NSString *friend_number; //待点评好友
@property(nonatomic,strong)NSString *interview_number; //面试补贴
@property(nonatomic,strong)NSString *synthesize_grade; //简历综合评分
@property(nonatomic,strong)NSString *synthesize_grade_url; //简历综合评分的详情 URL
@property(nonatomic,strong)NSString *hr_interview_number; // HR特权  hr对应聘者点评



//获取首页数据信息
+(NSURLSessionDataTask *)getHomeInfo:(NSDictionary *)parameters WithBlock:(void (^)(Home
 *home, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
