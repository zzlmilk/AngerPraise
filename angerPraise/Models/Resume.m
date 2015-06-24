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
    
    if ([dic objectForKey:@"create_resume_url"]) {
        
        _create_resume_url = [dic objectForKey:@"create_resume_url"];

        
    }else{
        
     _res = [dic objectForKey:@"res"];
        
    }
    
    return self;
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
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
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
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
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
        
        [APIClient showInfo: @"请稍后再试..." title:@"网络异常"];
//         NSLog(@"网络异常");
        
    }];

}

@end
