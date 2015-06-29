//
//  Register.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Register : NSObject


@property(nonatomic,strong)NSString *photo_url;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_phone;


@property(nonatomic,strong)NSString *res;

//用户注册 并 提交基本信息
+(NSURLSessionDataTask *)userRegister:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

// 忘记密码 中  获取验证码
+(NSURLSessionDataTask *)getCaptcha:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block;

// 忘记密码 中  验证手机号码
+(NSURLSessionDataTask *)checkPhone:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block;

// 忘记密码 中  设置新密码
+(NSURLSessionDataTask *)setNewPassword:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block;



@end
