//
//  MyDynamic.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "MyDynamic.h"
#import "ApIClient.h"

@implementation MyDynamic

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _dynamic_url = [dic objectForKey:@"dynamic_url"];

    return self;
    
}


+(NSURLSessionDataTask *)getMyDynamic:(NSDictionary *)parameters WithBlock:(void (^)(MyDynamic *, Error *))block{

        return [[APIClient sharedClient]GET:@"home/dynamic" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
           // NSLog(@"%@",responseObject);
            if ([responseObject objectForKey:@"error"]) {
                Error *error = [[Error alloc]init];
                
                error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
                error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
                
                MyDynamic *m;
                block(m,error);
                
            }else{
                
                MyDynamic *m = [[MyDynamic alloc]initWithDic:responseObject];
                
                block(m,nil);
                
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            if (NZ_DugSet) {
                
                [APIClient showMessage:@"请检查网络状态" title:@"网络异常"];
            }
        }];

    
}

@end
