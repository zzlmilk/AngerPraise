//
//  Login.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Login : NSObject


//@property(nonatomic,strong)NSString *user_id;
//@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_phone;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *user_status_type;




//用户基本属性
@property(nonatomic,strong)NSString *hirelib_code; //id
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_token;


@property(nonatomic,strong)NSString *user_intergral; //用户赏银数
@property(nonatomic,strong)NSString *photo_url; //用户头像url地址


//关于综合评分
@property(nonatomic,strong)NSString *synthesize_grade_url; //综合评分web url 地址
@property(nonatomic,strong)NSString *synthesize_grade;  //用户的综合评分

//用户简历状态
@property (nonatomic)BOOL resume_status;

//关于用户剩余任务数
@property(nonatomic,strong) NSString *mission_number;

//用户是否是hr 1=hr ，0非hr
@property (nonatomic)BOOL hr_privilege;

//推荐职位数
@property(nonatomic,strong)NSString *position_number;


//用户注册 并 提交基本信息
+(NSURLSessionDataTask *)userLogin:(NSDictionary *)parameters WithBlock:(void (^)(Login *login, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
