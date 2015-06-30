//
//  CommentFriend.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "CommentFriend.h"
#import "ApIClient.h"

@implementation CommentFriend

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];

    _friend_number =[dic objectForKey: @"friend_number"];
    _synthesize_grade =[dic objectForKey: @"synthesize_grade"];
    _synthesize_grade_url =[dic objectForKey: @"synthesize_grade_url"];
    _today_award_total =[dic objectForKey: @"today_award_total"];
    _today_receive_award =[dic objectForKey: @"today_receive_award"];
    _interview_number =[dic objectForKey: @"interview_number"];
    
    //friend_list
    if ([dic objectForKey:@"friend_list"]) {
        NSArray *friend_listArray =[dic objectForKey:@"friend_list"];
        
        _commentFriendArray = [NSMutableArray array];
        for (int i =0; i<friend_listArray.count; i++) {

            Review *r =[[Review alloc]init];
            r.friend_evluation_status = [[friend_listArray objectAtIndex:i] objectForKey:@"friend_evluation_status"];
            r.friend_evluation_url = [[friend_listArray objectAtIndex:i] objectForKey:@"friend_evluation_url"];
            r.photo_url = [[friend_listArray objectAtIndex:i] objectForKey:@"photo_url"];
            r.user_name = [[friend_listArray objectAtIndex:i] objectForKey:@"user_name"];
            
            [_commentFriendArray addObject:r];
        }
        
    }
    
    return self;
    
}

//获取首页数据信息
+(NSURLSessionDataTask *)getCommentFriendList:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block{

    return [[APIClient sharedClient]GET:@"home/index" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            CommentFriend *c;
            block(c,error);
            
        }else{
        
            CommentFriend *c = [[CommentFriend alloc]initWithDic:responseObject];
            
            block(c,nil);
        
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}


//Hr 接口数据
+(NSURLSessionDataTask *)getHrReviewInfo:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block{

    return [[APIClient sharedClient]GET:@"home/hr_interview" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            CommentFriend *c;
            block(c,error);
            
        }else{
            
            CommentFriend *c = [[CommentFriend alloc]initWithDic:responseObject];
            
            block(c,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
    
}



//点评成功后 重新获取 金币和 综合评分
+(NSURLSessionDataTask *)reviewSuccess:(NSDictionary *)parameters WithBlock:(void (^)(CommentFriend *commentFriend, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"home/indexs" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // NSLog(@"%@",responseObject);
        
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            CommentFriend *c;
            block(c,error);
            
        }else{
            
            CommentFriend *c = [[CommentFriend alloc]initWithDic:responseObject];
            
            block(c,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}


@end
