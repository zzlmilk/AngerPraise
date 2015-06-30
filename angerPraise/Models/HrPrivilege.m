//
//  HrPrivilege.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "HrPrivilege.h"
#import "ApIClient.h"

@implementation HrPrivilege

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    _interview_url = [dic objectForKey: @"interview_url"];
    _photo_url = [dic objectForKey: @"photo_url"];
    _user_phone = [dic objectForKey: @"user_phone"];
    _user_name = [dic objectForKey: @"user_name"];
    
    return self;
    
}

+(NSURLSessionDataTask *)hrReviewAppalyList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *, Error *))block{

    return [[APIClient sharedClient]GET:@"home/hr_interview" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        NSMutableArray *positionArray = [responseObject objectForKey:@"interview_list"];
        
        NSMutableArray *positionList = [NSMutableArray array];
        
        for (int i=0; i<positionArray.count; i++) {
            NSDictionary *statusDic = [positionArray objectAtIndex:i];
            HrPrivilege * s = [[HrPrivilege alloc]initWithDic:statusDic];
            [positionList addObject:s];
        }
        
        block(positionList,nil);
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (nsDugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}

@end
