//
//  Error.m
//  VehicleMounted_BMW
//
//  Created by 单好坤 on 14-8-19.
//  Copyright (c) 2014年 单好坤. All rights reserved.
//

/*
 
 
 $error_List[102] = 'token不能为空'
 
 $error_List[104] = 'token已过期'
 
 $error_List[105] = 'token不合法'
 
 
 
 
 $error_List[101] = '参数不全或参数为空,请检查字段是否按照要求传输'
 
 $error_List[10001] = '用户手机已被注册'
 
 $error_List[10000] = '手机或密码为空'
 
 $error_List[10002] = '手机号码已被注册'
 
 $error_List[10003] = '手机号码或密码错误'
 
 $error_List[10004] = '用户不存在'
 
 $error_List[10005] = '用户ID为空'
 
 $error_List[10006] = '初始密码不存在'
 
 $error_List[10007] = '该初始密码已过期,请重新获取'
 
 $error_List[10008] = '初始密码不能重复获取，请在60秒后获取'
 
 $error_List[10009] = '手机号码不存在'
 
 $error_List[20000] = '该职位不存在'
 
 $error_List[30000] = '公司不存在'
 
 $error_List[40000] = '抓取内容不存在'
 
 $error_List[40001] = '该用户已进行过虚拟投递'
 
 
 $error_List[40004] = '我们未发现你的职业信息'
 
 $error_List[50000] = '验证码不符合'
 
 $error_List[50001] = '二次密码不一致'
 
 */
#import "Error.h"

#import "NoozanAppdelegate.h"



@implementation Error

-(id)initWith:(NSString *)error_code{
        self = [super init];
        [self errorString:error_code];
    
        return self;
}

-(NSString*)errorString:(NSString *)error_code{
    NSString *errorString;
    NSInteger code = 0;
    
        code = [error_code integerValue];
    
    switch (code) {
        case 0:
        errorString = @"error code 不是一个数字";
            break;
            
        case 102:
            errorString =@"token不能为空";

        case 104:
            errorString =@"token已过期";

        case 105:
            errorString =@"token不合法";
        {
            NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                              title:@"错误提示"
                                                            message:errorString
                                                           delegate:nil];
            
            [alert showWithCompletion:^{
                 [[NoozanAppdelegate getAppDelegate]getIndexVC];
                 [[NoozanAppdelegate getAppDelegate]clearUserInfo];

            }];

           // [[NoozanAppdelegate getAppDelegate]getIndexVC];
           // [[NoozanAppdelegate getAppDelegate]clearUserInfo];
        }
            break;
            

        default:
        {
            NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleInfo
                                                              title:@"提示"
                                                            message:errorString
                                                           delegate:nil];
            
            [alert showWithCompletion:^{
               
                
            }];
        }

            break;
    }
    
    _info = errorString;
    return errorString;
    
}



@end
