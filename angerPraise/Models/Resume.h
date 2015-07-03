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

@property(nonatomic,strong)NSString *compensation_name;
@property(nonatomic,strong)NSString *objective_functions;
@property(nonatomic,strong)NSString *user_dynamic_number;
@property(nonatomic,strong)NSString *resume_update_time;
@property(nonatomic,strong)NSString *user_position;
@property(nonatomic,strong)NSString *user_resume_synthesize_grade;
//0为用户未上传简历  1为用户已上传简历
@property(nonatomic)BOOL resume_status;


//从简历中获取用户昵称和简历完善度 竞争力以及综合评分评分
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block;

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
