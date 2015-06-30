//
//  InitPassword.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/6.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "InitPassword.h"
#import "ApIClient.h"

@implementation InitPassword

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"validation_inital"] == nil) {
        
        _password = [dic objectForKey:@"password"];
        _phone = [dic objectForKey:@"phone"];
//        _user_id =[dic objectForKey:@"user_id"];
        _token =[dic objectForKey:@"token"];
        
    }else{
    
        _validation_inital =[dic objectForKey:@"validation_inital"];
    
    }
    
    
    return self;
    
}


//获取初始密码
+(NSURLSessionDataTask *)getInitPassword:(NSDictionary *)parameters WithBlock:(void (^)(InitPassword *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/get_password" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            InitPassword *h;
            block(h,error);
            
        }else{
            
            InitPassword *i= [[InitPassword alloc]initWithDic:responseObject];
            block(i,nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (nsDugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}

//验证初始密码
+(NSURLSessionDataTask *)isInitPassword:(NSDictionary *)parameters WithBlock:(void (^)(InitPassword *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/check_password" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            InitPassword *h;
            block(h,error);
            
        }else{
        
        InitPassword *i= [[InitPassword alloc]initWithDic:responseObject];
        block(i,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (nsDugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}

@end
