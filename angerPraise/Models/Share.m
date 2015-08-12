//
//  Share.m
//  angerPraise
//
//  Created by 单好坤 on 15/6/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Share.h"
#import "ApIClient.h"

@implementation Share

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _title = [dic objectForKey:@"title"];
    _content = [dic objectForKey:@"content"];
    
    return self;
    
}


+(NSURLSessionDataTask *)getShareInfo:(NSDictionary *)parameters WithBlock:(void (^)(Share *, Error *))block{

    return [[APIClient sharedClient]GET:@"weixin/share" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Share *s;
            block(s,error);
            
        }else{
            
            Share *s = [[Share alloc]initWithDic:responseObject];
            
            block(s,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showMessage:@"请检查网络状态" title:@"网络异常"];
        }
    }];


}

@end
