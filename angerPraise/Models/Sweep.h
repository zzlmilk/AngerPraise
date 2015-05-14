//
//  Sweep.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/13.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Sweep : NSObject

@property(nonatomic,strong)NSString *res;

@property(nonatomic,strong)NSString *qrCodeUrl;

//扫一扫 在web端修改 简历
+(NSURLSessionDataTask *)sweepEditResume:(NSDictionary *)parameters WithBlock:(void (^)(Sweep *sweep, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;



//获取用户二维码
+(NSURLSessionDataTask *)getUserQrCode:(NSDictionary *)parameters WithBlock:(void (^)(Sweep *sweep, Error *e))block;


@end
