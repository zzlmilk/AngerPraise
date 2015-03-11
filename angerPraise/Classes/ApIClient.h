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


+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg title:(NSString *)title;


@end
