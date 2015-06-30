//
//  Setting.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Setting.h"
#import "ApIClient.h"

@implementation Setting

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];

    _about_url = [dic objectForKey:@"about_url"];
    _privacy_url = [dic objectForKey:@"privacy_url"];
    _review_app_url = [dic objectForKey:@"review_app_url"];
    _version_url = [dic objectForKey:@"version_url"];
    
    return self;
    
}

+(NSURLSessionDataTask *)getSettingUrl:(NSDictionary *)parameters WithBlock:(void (^)(Setting *setting, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"about/setting" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Setting *s;
            block(s,error);
            
        }else{
            
            Setting *s = [[Setting alloc]initWithDic:responseObject];
            
            block(s,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (nsDugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}

@end
