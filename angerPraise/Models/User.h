//
//  User.h
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"
#import "Review.h"
#import "NZBase.h"

@interface User : NZBase

@property Review *review;


@property(nonatomic,strong)NSString *res;
//getUserInfoData
//用户基本属性
@property(nonatomic,strong)NSString *hirelib_code; //id
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_token;

@property(nonatomic,strong)NSString *user_intergral; //用户赏银数
@property(nonatomic,strong)NSString *photo_url; //用户头像url地址

//关于点评
@property(nonatomic,strong)NSString *today_award_total;// 今日可赚取赏银
@property(nonatomic,strong)NSString *today_receive_award;// 今日已赚取赏银


//关于综合评分
@property(nonatomic,strong)NSString *synthesize_grade_url; //综合评分web url 地址
@property(nonatomic,strong)NSString *synthesize_grade;  //用户的综合评分

//用户简历状态
@property (strong, nonatomic)NSString *resume_status;

//关于用户剩余任务数
@property(nonatomic,strong) NSString *mission_number;

//用户是否是hr 1=hr ，0非hr
@property (strong, nonatomic)NSString* hr_privilege;
//hr用户是否有 未读消息
@property (nonatomic)NSString *hr_interview_number;

//推荐职位数
@property(nonatomic,strong)NSString *position_number;


@property(nonatomic,strong)NSMutableArray *commentFriendArray;

@property(nonatomic,strong)NSString *hr_url;   //hr特权的URL地址
@property(nonatomic,strong)NSString *pay_url;  //钱包地址
@property(nonatomic,strong)NSString *user_apply_url;//收藏
@property(nonatomic,strong)NSString *user_friend_url;//我的好友



-(instancetype)initWithDic:(NSDictionary *)dic;


//用户注册 并 提交基本信息
+(NSURLSessionDataTask *)userRegister:(NSDictionary *)parameters WithBlock:(void (^)(User *reg, Error *e))block;


//获取首页数据
+(NSURLSessionDataTask *)getHomeData:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//用户登录
+(NSURLSessionDataTask *)userLogin:(NSDictionary *)parameters WithBlock:
(void (^)(User *user, Error *e))block;

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

//获取钱包 url
+(NSURLSessionDataTask *)getWalletUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//获取投递纪录和收藏 url
+(NSURLSessionDataTask *)getCollectUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//我的好与 url
+(NSURLSessionDataTask *)getFriendUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;

//hr特权 url
+(NSURLSessionDataTask *)getHrUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block;



@end
