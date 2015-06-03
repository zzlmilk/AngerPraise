//
//  User.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface User : NSObject

@property(nonatomic,strong)NSString *res;


//退出登录
+(NSURLSessionDataTask *)userLoginOut:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


//获取 user模块信息
+(NSURLSessionDataTask *)getUserInfo:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

@property(nonatomic,strong)NSString *hirelib_code;
@property(nonatomic,strong)NSString *photo_url;
@property(nonatomic,strong)NSString *hr_url;
@property(nonatomic,strong)NSString *pay_url;
@property(nonatomic,strong)NSString *user_apply_url;
@property(nonatomic,strong)NSString *user_friend_url;
@property(nonatomic,strong)NSString *position_number;
@property(nonatomic,strong)NSString *user_intergral;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_resume_synthesize_grade;


@property(nonatomic,strong)NSString *mission_number;
@end
