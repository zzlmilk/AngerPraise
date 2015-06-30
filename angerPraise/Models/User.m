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
    self =[super init];
    
<<<<<<< HEAD
    if ([dic objectForKey:@"hirelib_code"]) { // userinfo
        
=======
    if ([dic objectForKey:@"res"] == nil) {
>>>>>>> 3029c53fe6a14750fb13615fc55abc46f3b2a847
        _hirelib_code =[dic objectForKey:@"hirelib_code"];
        _user_name =[dic objectForKey:@"user_name"];
        _photo_url =[dic objectForKey:@"photo_url"];
        _user_id =[dic objectForKey:@"user_id"];

        
//        _hr_url =[dic objectForKey:@"hr_url"];
//        _pay_url =[dic objectForKey:@"pay_url"];
//        _position_number =[dic objectForKey:@"position_number"];
//        _user_apply_url =[dic objectForKey:@"user_apply_url"];
//        _user_friend_url =[dic objectForKey:@"user_friend_url"];
//        _user_intergral =[dic objectForKey:@"user_intergral"];
//        _user_resume_synthesize_grade = [dic objectForKeyedSubscript:@"user_resume_synthesize_grade"];
//        _mission_number =[dic objectForKeyedSubscript:@"mission_number"];
        
    }
    
    if ([dic objectForKey:@"res"]) { // 退出登录
        
        _res = [dic objectForKey:@"res"];
        
    }
    if ([dic objectForKey:@"mission_number"]) { // 剩余任务
        
        _mission_number = [dic objectForKey:@"mission_number"];
    }

    if ([dic objectForKey:@"position_number"]) {// 推荐职位
        
        _position_number = [dic objectForKey:@"position_number"];

    }
    
    if ([dic objectForKey:@"user_intergral"]) {// 推荐职位
        
        _user_intergral = [dic objectForKey:@"user_intergral"];
        
    }
    
    
    return self;
    
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
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
        
        if (nsDugSet) {
            
            [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
        }
        
    }];

}

//发送用户设备信息
+(NSURLSessionDataTask *)sendDeviceInfo:(NSDictionary *)parameters WithBlock:(void (^)(User *user, Error *e))block{

    return [[APIClient sharedClient]GET:@"user/device" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

}


@end
