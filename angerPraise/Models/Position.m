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
    
    //获取 推荐的 职位列表
    _positionName = [dic objectForKey: @"name"];
    _competitionNumber = [dic objectForKey: @"competition_number"];
    _education = [dic objectForKey: @"education"];
    _matchNumber = [dic objectForKey: @"match_number"];
    _position_id = [dic objectForKey: @"position_id"];
    _rank = [dic objectForKey: @"rank"];
    _workPlace = [dic objectForKey: @"work_place"];
    _companyName = [dic objectForKey: @"company_name"];
    _type = [dic objectForKey: @"type"];
    _subsidiesInterview = [dic objectForKey:@"subsidies_interview"];
    _webUrl = [dic objectForKey:@"web_url"];
    _creatTime = [dic objectForKey:@"create_time"];
    
    //申请职位
    _res =[dic objectForKey:@"res"];
    
    return self;
    
}

//获取 推荐的 职位列表
+(NSURLSessionDataTask *)getPositionList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *positionArray, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"position/recommended" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
        NSUserDefaults *recommendPosition= [[NSUserDefaults alloc]init];
        [recommendPosition setObject:[responseObject objectForKey:@"recommended_number"] forKey:@"recommendPosition"];
        
        if ([responseObject objectForKeyedSubscript:@"error"]) {
            
            Error *error = [[Error alloc]init];
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            NSMutableArray *p;
            
            block(p,error);
            
        }else{

            
            NSMutableArray *positionArray = [responseObject objectForKey:@"position_object"];
            
            NSMutableArray *positionList = [NSMutableArray array];
            
            for (int i=0; i<positionArray.count; i++) {
                NSDictionary *statusDic = [positionArray objectAtIndex:i];
                Position * s = [[Position alloc]initWithDic:statusDic];
                [positionList addObject:s];
            }
            
            block(positionList,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo: @"请稍后再试..." title:@"网络异常"];
        
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
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];

    }];

}



@end
