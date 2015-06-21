//
//  User.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "User.h"
#import "ApIClient.h"

@implementation User

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"res"] == nil) {
        
        _hirelib_code =[dic objectForKey:@"hirelib_code"];
        _hr_url =[dic objectForKey:@"hr_url"];
        _pay_url =[dic objectForKey:@"pay_url"];
        _photo_url =[dic objectForKey:@"photo_url"];
        _position_number =[dic objectForKey:@"position_number"];
        _user_apply_url =[dic objectForKey:@"user_apply_url"];
        _user_friend_url =[dic objectForKey:@"user_friend_url"];
        _user_intergral =[dic objectForKey:@"user_intergral"];
        _user_name =[dic objectForKey:@"user_name"];
        _user_resume_synthesize_grade = [dic objectForKeyedSubscript:@"user_resume_synthesize_grade"];
        _mission_number =[dic objectForKeyedSubscript:@"mission_number"];
        
    }else{
        
        _res = [dic objectForKey:@"res"];
    
    }
    
    
    return self;
    
}

//获取 我的模块 信息
+(NSURLSessionDataTask *)getUserInfo:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/info" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",responseObject);

        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //[APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        [APIClient showMessage:@"无网络连接"];
    }];


}


// 用户退出登录
+(NSURLSessionDataTask *)userLoginOut:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/logout" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }

        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];
    
}


//用户修改名称
+(NSURLSessionDataTask *)userUpdateNickname:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/update_nickname" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];
    
}


//用户修改密码
+(NSURLSessionDataTask *)userUpdatePassword:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/update_password" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];
    
}


@end
