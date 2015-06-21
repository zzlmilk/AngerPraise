//
//  Login.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Login.h"
#import "ApIClient.h"

@implementation Login

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _token = [dic objectForKey:@"token"];
    _user_id = [dic objectForKey:@"user_id"];
    _user_name = [dic objectForKey:@"user_name"];
    _user_phone = [dic objectForKey:@"user_phone"];
    
    _hr_privilege =[dic objectForKey:@"hr_privilege"];
    _resume_status =[dic objectForKey:@"resume_status"];
    _user_status_type =[dic objectForKey:@"user_status_type"];

    
    return self;
    
}



+(NSURLSessionDataTask *)userLogin:(NSDictionary *)parameters WithBlock:(void (^)(Login *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/login" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Login *l;
            
            
            //登陆成功 UserID 存
            block(l,error);
            
            
            
        }else{
            
            Login *l = [[Login alloc]initWithDic:responseObject];
            
            block(l,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];
    

}
@end
