//
//  AddressBook.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/12.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface AddressBook : NSObject


//应用内创建
+(NSURLSessionDataTask *)uploadAddressBook:(NSDictionary *)parameters WithBlock:(void (^)(AddressBook *addressBook, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
