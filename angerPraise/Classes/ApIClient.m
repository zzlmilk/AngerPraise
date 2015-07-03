//
//  ApIClient.m
//  WeiBoApi_pro
//
//  Created by 单好坤 on 14-5-29.
//  Copyright (c) 2014年 单好坤. All rights reserved.
//

#import "NZAlertView.h"
#import "APIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"http://app.hirelib.com/noozan_api/v1/";

//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.0.110:3000/v1/";

//

//other  备用
static NSString * const AFAppDotNetAPIBaseURLStringOther = @"http://app.hirelib.com/website/";

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    
    
    return _sharedClient;
}



+(NSString *)sharedBaseURL{
    return AFAppDotNetAPIBaseURLString;
}

-(id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    // [self setDefaultHeader:@"Accept" value:@"application/json"];
    
 //   NSString *user_id =[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    NSString *user_token =[[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];    
    if (user_token != nil) {
        [[self requestSerializer] setValue:user_token forHTTPHeaderField:@"Authorization"];
    }

    return self;
}


+ (instancetype)sharedOtherClient{
    static APIClient *_sharedOther = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedOther = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLStringOther]];
        _sharedOther.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedOther;

}







//自定义弹框 － 成功
+ (void)showSuccess:(NSString *)msg title:(NSString *)title {

    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess
                                                      title:title
                                                    message:msg
                                                   delegate:nil];
    
    [alert show];
}

//自定义弹框 － 失败
+ (void)showError:(NSString *)msg title:(NSString *)title {
    
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                      title:title
                                                    message:msg
                                                   delegate:nil];
    
    [alert show];
}


//自定义弹框 － 提示消息
+ (void)showInfo:(NSString *)msg title:(NSString *)title {
    
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleInfo
                                                      title:title
                                                    message:msg
                                                   delegate:nil];
    
    [alert show];
}



//默认弹框
+ (void)showMessage:(NSString *)msg title:(NSString *)title {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确认", nil) otherButtonTitles:nil, nil];
    [av show];
}


+ (void)showMessage:(NSString *)msg {
    if (msg.length == 0 || [msg isEqualToString:@""]) {
        msg = @"网络不太给力哦亲!";
    }
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确认", nil) otherButtonTitles:nil, nil];
    [av show];
}



@end

