//
//  Home.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Home.h"
#import "ApIClient.h"

@implementation Home

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _friend_number = [dic objectForKey: @"friend_number"];
    _hr_interview_number = [dic objectForKey: @"hr_interview_number"];
    _interview_number = [dic objectForKey: @"interview_number"];
    _synthesize_grade = [dic objectForKey: @"synthesize_grade"];
    _synthesize_grade_url = [dic objectForKey: @"synthesize_grade_url"];
    
    return self;
    
}

+(NSURLSessionDataTask *)getHomeInfo:(NSDictionary *)parameters WithBlock:(void (^)(Home *, Error *))block{

    return [[APIClient sharedClient]GET:@"home/index" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Home *h;
            block(h,error);
            
        }else{
            
            Home *h = [[Home alloc]initWithDic:responseObject];
            
            block(h,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];


}



@end
