//
//  Resume.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Resume.h"
#import "ApIClient.h"

@implementation Resume

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    

    if ([dic objectForKey:@"resume"]) {
        
        NSDictionary *resumeDic =[dic objectForKey:@"resume"];
        _create_resume_url = [resumeDic objectForKey:@"create_resume_url"];
        _resume_perfect_url =[resumeDic objectForKey:@"resume_perfect_url"];
        _resume_preview_url =[resumeDic objectForKey:@"resume_preview_url"];

        _compensation_name = [resumeDic objectForKey: @"compensation_name"];
        _objective_functions = [resumeDic objectForKey: @"objective_functions"];
        _user_dynamic_number = [resumeDic objectForKey: @"user_dynamic_number"];
        _resume_update_time = [resumeDic objectForKey: @"resume_update_time"];
        _user_position = [resumeDic objectForKey: @"user_position"];
        
        _user_resume_synthesize_grade = [resumeDic objectForKey: @"user_resume_synthesize_grade"];
        _resume_status = [[resumeDic objectForKey: @"resume_status"]boolValue];
        
        
    }else{
        
     _res = [dic objectForKey:@"res"];
        
    }
    
    return self;
}

//获取简历信息
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *))block{
    
    return [[APIClient sharedClient]GET:@"user/resume" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Resume *r;
            block(r,error);
            
        }else{
            
            Resume *p = [[Resume alloc]initWithDic:responseObject];
            
            block(p,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            NSLog(@"%@",error);
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];
}


//问答式创建简历
+(NSURLSessionDataTask *)qACreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/resume_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"error_status"];
            
            Resume *r;
            
            block(r,error);
            
        }else{
            
            Resume *r = [[Resume alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];
}


//预览简历
+(NSURLSessionDataTask *)previewResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/get_resume_perview_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"error_status"];
            
            Resume *r;
            
            block(r,error);
            
        }else{
            
            Resume *r = [[Resume alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];
}



//完善简历
+(NSURLSessionDataTask *)perfectResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *resume, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/get_resume_perfect_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"error_status"];
            
            Resume *r;
            
            block(r,error);
            
        }else{
            
            Resume *r = [[Resume alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];
}




//从51 导入
+(NSURLSessionDataTask *)importResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *, Error *))block{
    
    return  [[APIClient sharedClient]POST:@"resume/collect" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"error_status"];
            
            Resume *r;
            
            block(r,error);
            
        }else{
            
            Resume *r = [[Resume alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}


//应用内创建
+(NSURLSessionDataTask *)appCreatedResume:(NSDictionary *)parameters WithBlock:(void (^)(Resume *, Error *))block{
    
    return [[APIClient sharedClient]POST:@"resume/create" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"error_status"];
            
            Resume *r;
            
            block(r,error);
            
        }else{
            
            Resume *r = [[Resume alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];

}

@end
