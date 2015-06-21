//
//  Setting.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/4.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Setting : NSObject

+(NSURLSessionDataTask *)getSettingUrl:(NSDictionary *)parameters WithBlock:(void (^)(Setting *setting, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


@property(nonatomic,strong)NSString *about_url;
@property(nonatomic,strong)NSString *privacy_url;
@property(nonatomic,strong)NSString *review_app_url;
@property(nonatomic,strong)NSString *version_url;


@end
