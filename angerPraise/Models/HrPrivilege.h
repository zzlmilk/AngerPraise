//
//  HrPrivilege.h
//  angerPraise
//
//  Created by 单好坤 on 15/5/5.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface HrPrivilege : NSObject


@property(nonatomic,strong)NSString *interview_url; // hr对面试者点评的url
@property(nonatomic,strong)NSString *photo_url; //头像url
@property(nonatomic,strong)NSString *user_name; //名称
@property(nonatomic,strong)NSString *user_phone; //应聘者电话



//hr特权  hr对应聘者的点评
+(NSURLSessionDataTask *)hrReviewAppalyList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *hrReviewAppalyArray, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

//@property(nonatomic,strong)NSString *webUrl;

@end
