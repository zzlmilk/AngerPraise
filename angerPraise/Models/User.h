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


@end
