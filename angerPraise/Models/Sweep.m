//
//  Sweep.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/13.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Sweep.h"
#import "ApIClient.h"
#import "SMS_MBProgressHUD.h"

@implementation Sweep

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"res"]!=nil) {
        
        _res = [dic objectForKey:@"res"];
        
    }else{
    
        _qrCodeUrl = [dic objectForKey:@"code_url"];
    
    }
    
    return self;
    
}

//扫一扫 在web端修改 简历
+(NSURLSessionDataTask *)sweepEditResume:(NSDictionary *)parameters WithBlock:(void (^)(Sweep *, Error *))block{

    return [[APIClient sharedOtherClient]GET:@"home/bind_qcode" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Sweep *s;
            block(s,error);
            
        }else{
            
            Sweep *s = [[Sweep alloc]initWithDic:responseObject];
            
            block(s,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];

    }];


}

//获取用户二维码
+(NSURLSessionDataTask *)getUserQrCode:(NSDictionary *)parameters WithBlock:(void (^)(Sweep *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/code" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Sweep *s;
            block(s,error);
            
        }else{
            
            Sweep *s = [[Sweep alloc]initWithDic:responseObject];
            
            block(s,nil);
            
        }

        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];
}

@end
