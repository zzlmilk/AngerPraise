//
//  ApIClient.h
//  WeiBoApi_pro
//
//  Created by 单好坤 on 14-5-29.
//  Copyright (c) 2014年 单好坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface APIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

+ (instancetype)sharedOtherClient;


+ (void)showSuccess:(NSString *)msg title:(NSString *)title;
+ (void)showInfo:(NSString *)msg title:(NSString *)title;
+ (void)showError:(NSString *)msg title:(NSString *)title;

//默认弹框
+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg title:(NSString *)title;


@end
