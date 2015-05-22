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
    _resume_perfect_url = [dic objectForKey: @"resume_perfect_url"];
    _resume_preview_url = [dic objectForKey: @"resume_preview_url"];
    _user_dynamic_number = [dic objectForKey: @"user_dynamic_number"];
    _resume_update_time = [dic objectForKey: @"resume_update_time"];
    _live = [dic objectForKey: @"live"];
    _user_photo_url = [dic objectForKey: @"user_photo_url"];
    _user_position = [dic objectForKey: @"user_position"];
    _user_resume_competitiveness = [dic objectForKey: @"user_resume_competitiveness"];
    _user_resume_perfect = [dic objectForKey: @"user_resume_perfect"];
    _user_resume_synthesize_grade = [dic objectForKey: @"user_resume_synthesize_grade"];
    return self;
    
}


//从简历中获取用户昵称和简历完善度 竞争力以及综合评分评分
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(ResumeScore *resumeScore, Error *))block{

    return [[APIClient sharedClient]GET:@"user/resume" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"code"] objectForKey:@"error"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            ResumeScore *r;
            block(r,error);
            
        }else{
            
            ResumeScore *p = [[ResumeScore alloc]initWithDic:responseObject];
            
            block(p,nil);
            
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //NSLog(@"网络异常");
        [APIClient showInfo: @"请稍后再试..." title:@"网络异常"];
        
    }];
}

@end
