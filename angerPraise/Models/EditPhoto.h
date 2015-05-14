//
//  EditPhoto.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/6.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface EditPhoto : NSObject

+(void)uploadUserProfileImageParameters:(NSDictionary *)parameters WithBlock:(void (^)(EditPhoto *e))block;


-(instancetype)initWithDic:(NSDictionary *)dic;

@property(nonatomic,strong)NSString *res;

@end
