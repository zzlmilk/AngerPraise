//
//  Register.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/7.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Register.h"
#import "ApIClient.h"

@implementation Register

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _photo_url = [dic objectForKey:@"photo_url"];
    _user_id = [dic objectForKey:@"user_id"];
    _user_name = [dic objectForKey:@"user_name"];
    _user_phone = [dic objectForKey:@"user_phone"];
    
    
    return self;
    
}


+(NSURLSessionDataTask *)userRegister:(NSDictionary *)parameters WithBlock:(void (^)(Register *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/register" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
      //  NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Register *r;
            block(r,error);
            
        }else{
            
            Register *r = [[Register alloc]initWithDic:responseObject];
            
            block(r,nil);
            
        }

        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];


}
@end
