//
//  ApIClient.m
//  WeiBoApi_pro
//
//  Created by 单好坤 on 14-5-29.
//  Copyright (c) 2014年 单好坤. All rights reserved.
//

#import "APIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"http://115.231.94.156:3000/AngerPraises/v1/";

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

