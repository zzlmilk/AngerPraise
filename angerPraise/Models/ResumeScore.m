//
//  ResumeScore.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ResumeScore.h"
#import "ApIClient.h"

@implementation ResumeScore

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"resume"]) {
        
        NSDictionary *resumeDic =[dic objectForKey:@"resume"];
        
        _compensation_name = [resumeDic objectForKey: @"compensation_name"];
        _objective_functions = [resumeDic objectForKey: @"objective_functions"];
        _user_dynamic_number = [resumeDic objectForKey: @"user_dynamic_number"];
        _resume_update_time = [resumeDic objectForKey: @"resume_update_time"];
        _user_position = [resumeDic objectForKey: @"user_position"];

        _user_resume_synthesize_grade = [resumeDic objectForKey: @"user_resume_synthesize_grade"];
        _resume_status = [resumeDic objectForKey: @"resume_status"];
    }

    return self;
    
}


//获取简历信息
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(ResumeScore *resumeScore, Error *))block{

    return [[APIClient sharedClient]GET:@"user/resume" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            ResumeScore *r;
            block(r,error);
            
        }else{
            
            ResumeScore *p = [[ResumeScore alloc]initWithDic:responseObject];
            
            block(p,nil);
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            NSLog(@"%@",error);
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];
}

@end
