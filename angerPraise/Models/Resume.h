//
//  Resume.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Resume : NSObject

@property(nonatomic,strong)NSString *res;
@property(nonatomic,strong)NSString *create_resume_url;


//问答式创建简历
+(NSURLSessionDataTask *)qACreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

//从51 虚拟投递
+(NSURLSessionDataTask *)importResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

//应用内创建
+(NSURLSessionDataTask *)appCreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
