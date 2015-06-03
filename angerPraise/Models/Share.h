//
//  Share.h
//  angerPraise
//
//  Created by 单好坤 on 15/6/1.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Share : NSObject

//应用内创建
+(NSURLSessionDataTask *)getShareInfo:(NSDictionary *)parameters WithBlock:(void (^)(Share *share, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;


@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *content;

@end
