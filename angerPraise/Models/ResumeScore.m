//
//  ResumeScore.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "ResumeScore.h"
#import "ApIClient.h"

@implementation ResumeScore

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    
    return self;
    
}


//从简历中获取用户昵称和简历完善度 竞争力以及综合评分评分
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(ResumeScore *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/resume" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"网络异常");
        
    }];
}

@end
