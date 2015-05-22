//
//  AddressBook.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/12.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "AddressBook.h"
#import "ApIClient.h"

@implementation AddressBook


-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];
    
    
    return self;
    
}


+(NSURLSessionDataTask *)uploadAddressBook:(NSDictionary *)parameters WithBlock:(void (^)(AddressBook *, Error *))block{

    return [[APIClient sharedClient]GET:@"user/phone_book" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [APIClient showInfo: @"请稍后再试..." title:@"网络异常"];
        
    }];


}



@end
