//
//  Position.m
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "Position.h"
#import "ApIClient.h"

@implementation Position

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    if ([dic objectForKey:@"position_name"]) {
        
        NSDictionary *positionDic =[dic objectForKey:@"position"];
        //获取 推荐的 职位列表
        _position_id = [positionDic objectForKey: @"position_id"];
        _positionName = [positionDic objectForKey: @"name"];
        _workPlace = [positionDic objectForKey: @"work_place"];
        _companyName = [positionDic objectForKey: @"company_name"];
        _education = [positionDic objectForKey: @"education"];
        _matchNumber = [positionDic objectForKey: @"match_number"];
        _rank = [positionDic objectForKey: @"rank"];
        _competitionNumber = [positionDic objectForKey:@"competition_number"];
        _type = [positionDic objectForKey: @"type"];
        _creatTime = [positionDic objectForKey:@"create_time"];
        _webUrl = [positionDic objectForKey:@"web_url"];
        _subsidiesInterview = [positionDic objectForKey:@"subsidies_interview_status"];
        _hot_job_status = [positionDic objectForKey:@"hot_job_status"];
        _now_hiring_status = [positionDic objectForKey:@"now_hiring_status"];
        _high_salary_status = [positionDic objectForKey:@"high_salary_status"];
        _company_map_status = [positionDic objectForKey:@"company_map_status"];
        _company_video_status = [positionDic objectForKey:@"company_video_status"];
        _hot_words =[[NSMutableArray alloc]initWithArray:[positionDic objectForKey:@"hot_word"]];

        
    }
    if ([dic objectForKey:@"recommended_number"]) {
        
        _recommended_number = [dic objectForKey:@"recommended_number"];

    }
    
    //申请职位
    if ([dic objectForKey:@"res"]) {
        
        _res =[dic objectForKey:@"res"];

    }
    
    return self;
    
}

//获取 推荐的 职位列表
+(NSURLSessionDataTask *)getPositionList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *positionArray, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"position/recommended" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
//        NSUserDefaults *recommendPosition= [[NSUserDefaults alloc]init];
//        [recommendPosition setObject:[responseObject objectForKey:@"recommended_number"] forKey:@"recommendPosition"];
        
        if ([responseObject objectForKey:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            NSMutableArray *p;
            
            block(p,error);
            
        }else{

            NSMutableArray *positionArray = [responseObject objectForKey:@"position"];
            
            NSMutableArray *positionList = [NSMutableArray array];
            
            for (int i=0; i<positionArray.count; i++) {
                NSDictionary *statusDic = [positionArray objectAtIndex:i];
                Position * s = [[Position alloc]initWithDic:statusDic];
                [positionList addObject:s];
            }
            
            block(positionList,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}

//申请职位
+(NSURLSessionDataTask *)applyPosition:(NSDictionary *)parameters WithBlock:(void (^)(Position *, Error *))block{

    return [[APIClient sharedClient]GET:@"position/apply" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            Position *p;
            
            block(p,error);
            
        }else{
            
            Position *p = [[Position alloc]initWithDic:responseObject];
            
            block(p,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}



@end
