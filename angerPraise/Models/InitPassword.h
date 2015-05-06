//
//  InitPassword.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/6.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface InitPassword : NSObject

@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *phone;


@property(nonatomic,strong)NSString *validation_inital;

-(instancetype)initWithDic:(NSDictionary *)dic;

//获取初始密码
+(NSURLSessionDataTask *)getInitPassword:(NSDictionary *)parameters WithBlock:(void (^)(InitPassword *initPassword, Error *e))block;

+(NSURLSessionDataTask *)isInitPassword:(NSDictionary *)parameters WithBlock:(void (^)(InitPassword *initPassword, Error *e))block;


@end
