//
//  MyDynamic.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface MyDynamic : NSObject


@property(nonatomic,strong)NSString *dynamic_url;





//获取首页数据信息
+(NSURLSessionDataTask *)getMyDynamic:(NSDictionary *)parameters WithBlock:(void (^)(MyDynamic *myDynamic, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
