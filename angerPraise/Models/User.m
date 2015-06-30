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
    
    _missionNumber =[dic objectForKeyedSubscript:@"mission_number"];

    return self;
    
}

//获取 我的模块 信息
+(NSURLSessionDataTask *)getUserInfoData:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/info" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",responseObject);

        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
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
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
            //用户信息 销毁
            // token , user_id ,hr属性type  
            
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
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
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
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
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

//获取剩余任务数
+(NSURLSessionDataTask *)getUserMissionNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/mission" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
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
