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
    
    _friend_evluation_status = [dic objectForKey: @"friend_evluation_status"];
    _friend_evluation_url = [dic objectForKey: @"friend_evluation_url"];
    _photo_url = [dic objectForKey: @"photo_url"];
    _user_name = [dic objectForKey: @"user_name"];
    
    return self;
    
}

+(NSURLSessionDataTask *)getCommentFriendList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *commentFriendArray, Error *))block{

    return [[APIClient sharedClient]GET:@"home/friend" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        
        NSMutableArray *dataArray = [responseObject objectForKey:@"friend_list"];
        
        NSMutableArray *commentFriendList = [NSMutableArray array];
        
        for (int i=0; i<dataArray.count; i++) {
            NSDictionary *commDic = [dataArray objectAtIndex:i];
            CommentFriend * c = [[CommentFriend alloc]initWithDic:commDic];
            [commentFriendList addObject:c];
        }
        
        block(commentFriendList,nil);

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        
    }];

}

@end
