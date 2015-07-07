//
//  User.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "User.h"
#import "ApIClient.h"

@implementation User

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super initWithDic:dic];
    
    if ([dic objectForKey:@"user"]) {
        
        NSDictionary *userDic =[dic objectForKey:@"user"];
        
        _hirelib_code =[userDic objectForKey:@"hirelib_code"];
        _hr_privilege = [userDic objectForKey:@"hr_privilege"];
        _mission_number = [userDic objectForKey:@"mission_number"];
        _photo_url =[userDic objectForKey:@"photo_url"];
        _resume_status =[userDic objectForKey:@"resume_status"];
        _synthesize_grade =[userDic objectForKey: @"synthesize_grade"];
        _synthesize_grade_url =[userDic objectForKey: @"synthesize_grade_url"];
        _user_name =[userDic objectForKey:@"user_name"];
        _user_id =[userDic objectForKey:@"user_id"];
        _user_intergral = [userDic objectForKey:@"user_intergral"];

        
        _res = [userDic objectForKey:@"res"];
        _position_number = [userDic objectForKey:@"position_number"];
        _hr_interview_number =[userDic objectForKey: @"hr_interview_number"];

    }
    
    _user_token = [dic objectForKey:@"token"];
    _today_award_total =[dic objectForKey: @"today_award_total"];
    _today_receive_award =[dic objectForKey: @"today_receive_award"];

    
    _hr_url =[dic objectForKey:@"hr_url"];
    _pay_url =[dic objectForKey:@"pay_url"];
    _user_apply_url =[dic objectForKey:@"user_apply_url"];
    _user_friend_url =[dic objectForKey:@"user_friend_url"];
    
    _res =[dic objectForKey: @"res"];

    
    //friend_list
    if ([dic objectForKey:@"review_friend_list"]) {
        NSArray *friend_listArray =[dic objectForKey:@"review_friend_list"];

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



// 用户注册
+(NSURLSessionDataTask *)userRegister:(NSDictionary *)parameters WithBlock:(void (^)(User *reg, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/register" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *l;
            
            block(l,error);
            
        }else{
            
            User *l = [[User alloc]initWithDic:responseObject];
            
            block(l,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}

//获取首页数据
+(NSURLSessionDataTask *)getHomeData:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

   
    APIClient *client =    [APIClient sharedClient];
    [[client requestSerializer] setValue:[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN] forHTTPHeaderField:@"Authorization"];
  
    
    
    return [client GET:@"home/index" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        User *l = [[User alloc]initWithDic:responseObject];
        block(l,nil);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

//用户登录
+(NSURLSessionDataTask *)userLogin:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    return [[APIClient sharedClient]GET:@"user/login" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *l;
            
            block(l,error);
            
        }else{
            
            User *l = [[User alloc]initWithDic:responseObject];
            
            block(l,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

            
//获取 我的模块 信息
+(NSURLSessionDataTask *)getUserInfoData:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/info" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
           
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    
    }];

}


// 用户退出登录
+(NSURLSessionDataTask *)userLoginOut:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/logout" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
            //用户信息 销毁
            // token , user_id ,hr属性type  
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }

        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}


//用户修改名称
+(NSURLSessionDataTask *)userUpdateNickname:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/update_nickname" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}


//用户修改密码
+(NSURLSessionDataTask *)userUpdatePassword:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/update_password" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}

//获取剩余任务数
+(NSURLSessionDataTask *)getUserMissionNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/mission" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];

}

//获取推荐职位数
+(NSURLSessionDataTask *)getRecommendPositionNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/user_position_number" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
    
}

//获取钱包赏银数量
+(NSURLSessionDataTask *)getWalletNumber:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/integral" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            
            block(u,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (NZ_DugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];

}

//发送用户设备信息
+(NSURLSessionDataTask *)sendDeviceInfo:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/device" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (NZ_DugSet) {
            NSLog(@"%@",error);
        }
        
    }];

}

#pragma mark -- 获取钱包 url
+(NSURLSessionDataTask *)getWalletUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/pay_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
        
            User *u = [[User alloc]initWithDic:responseObject];
            block(u,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (NZ_DugSet) {
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

#pragma mark -- 获取投递记录和收藏 url
+(NSURLSessionDataTask *)getCollectUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/user_apply_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            block(u,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (NZ_DugSet) {
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

#pragma mark -- 我的好友 url
+(NSURLSessionDataTask *)getFriendUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/user_friend_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            block(u,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (NZ_DugSet) {
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
    }];
}

            
#pragma mark -- hr特权 url
+(NSURLSessionDataTask *)getHrUrl:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{
    
    return [[APIClient sharedClient]GET:@"user/user_hr_url" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        if ([responseObject objectForKey:@"error"]) {
            Error *error = [[Error alloc]init];
            
            error.code =[[responseObject objectForKey:@"error"] objectForKey:@"code"];
            error.info =[[responseObject objectForKey:@"error"] objectForKey:@"info"];
            
            User *u;
            block(u,error);
            
        }else{
            
            User *u = [[User alloc]initWithDic:responseObject];
            block(u,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (NZ_DugSet) {
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
            }
        }];
    }
            

            
    
@end

