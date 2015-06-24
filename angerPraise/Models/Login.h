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

@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *user_phone;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *hr_privilege;
@property(nonatomic,strong)NSString *resume_status;
@property(nonatomic,strong)NSString *user_status_type;

//用户注册 并 提交基本信息
+(NSURLSessionDataTask *)userLogin:(NSDictionary *)parameters WithBlock:(void (^)(Login *login, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


@end
