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
    
    _res = [dic objectForKey:@"res"];
    
    return self;
    
}


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



@end
