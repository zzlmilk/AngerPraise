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
//getUserInfoData
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


//即将舍弃
@property(nonatomic,strong)NSString *hr_url;   //hr特权的URL地址
@property(nonatomic,strong)NSString *pay_url;  //钱包地址
@property(nonatomic,strong)NSString *user_apply_url;
@property(nonatomic,strong)NSString *user_friend_url;
@property(nonatomic,strong)NSString *user_resume_synthesize_grade;



-(instancetype)initWithDic:(NSDictionary *)dic;


//退出登录
+(NSURLSessionDataTask *)userLoginOut:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//getUserInfoData
+(NSURLSessionDataTask *)getUserInfoData:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//修改名称
+(NSURLSessionDataTask *)userUpdateNickname:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//修改密码
+(NSURLSessionDataTask *)userUpdatePassword:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//获取剩余任务数
+(NSURLSessionDataTask *)getUserMissionNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//获取匹配职位数
+(NSURLSessionDataTask *)getRecommendPositionNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//获取钱包赏银数量
+(NSURLSessionDataTask *)getWalletNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//发送用户设备信息
+(NSURLSessionDataTask *)sendDeviceInfo:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;



@end
