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
@property(nonatomic,strong)NSString *create_resume_url;// 创建简历
@property(nonatomic,strong)NSString *resume_perfect_url;// 完善简历
@property(nonatomic,strong)NSString *resume_preview_url;// 预览简历



//问答式创建简历
+(NSURLSessionDataTask *)qACreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

//预览简历
+(NSURLSessionDataTask *)previewResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

//完善简历
+(NSURLSessionDataTask *)perfectResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;


//从51 虚拟投递
+(NSURLSessionDataTask *)importResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

//应用内创建
+(NSURLSessionDataTask *)appCreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
