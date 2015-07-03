//
//  Register.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Register.h"
#import "ApIClient.h"
#import "User.h"


@implementation Register

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"res"]) {
        
        _res = [dic objectForKey:@"res"];
        
    }else{
    
        _photo_url = [dic objectForKey:@"photo_url"];
        _user_id = [dic objectForKey:@"user_id"];
        _user_name = [dic objectForKey:@"user_name"];
        _user_phone = [dic objectForKey:@"user_phone"];
        
        _u = [[User alloc]initWithDic:dic];
        
    
    }
    
    return self;
    
}

#pragma mark -- 用户注册
//+(NSURLSessionDataTask *)userRegister:(NSDictionary *)parameters WithBlock:(void (^)(Register *, Error *))block{
//
//    return [[APIClient sharedClient]GET:@"user/register" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//      //  NSLog(@"%@",responseObject);
//        
//        if ([responseObject objectForKey:@"error"]) {
//            Error *error = [[Error alloc]init];
//            
//            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
//            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
//            
//            Register *r;
//            block(r,error);
//            
//        }else{
//            
//            Register *r = [[Register alloc]initWithDic:responseObject];
//            
//            block(r,nil);
//            
//        }
//
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        if (NZ_DugSet) {
//            
//            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
//        }
//    }];
//
//}

#pragma mark -- 忘记密码  获取验证码
+(NSURLSessionDataTask *)getCaptcha:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/apply_password_check" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Register *r;
            block(r,error);
            
        }else{
            
            Register *r = [[Register alloc]initWithDic:responseObject];
            
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

#pragma mark -- 忘记密码  验证手机号码
+(NSURLSessionDataTask *)checkPhone:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/forget_password_check" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Register *r;
            block(r,error);
            
        }else{
            
            Register *r = [[Register alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}

#pragma mark -- 忘记密码  验证手机号码
+(NSURLSessionDataTask *)setNewPassword:(NSDictionary *)parameters WithBlock:(void (^)(Register *reg, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/update_password" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Register *r;
            block(r,error);
            
        }else{
            
            
            
            Register *r = [[Register alloc]initWithDic:responseObject];
            block(r,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}


@end
