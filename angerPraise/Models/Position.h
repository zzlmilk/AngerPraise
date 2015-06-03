//
//  Position.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/14.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface Position : NSObject

//获取 推荐的 职位列表
@property(nonatomic,strong)NSString *position_id;
@property(nonatomic,strong)NSString *positionName;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *workPlace;
@property(nonatomic,strong)NSString *education;
@property(nonatomic,strong)NSString *creatTime;
@property(nonatomic,strong)NSString *matchNumber;//匹配度
@property(nonatomic,strong)NSString *competitionNumber;//竞争人数
@property(nonatomic,strong)NSString *rank;//排名
@property(nonatomic,strong)NSString *subsidiesInterview;//是否有面试补贴 1有 0 没有
@property(nonatomic,strong)NSString *webUrl; //职位详情
@property(nonatomic,strong)NSString *type; // 1精确推荐 2关联推荐 3特长推荐


//申请职位
@property(nonatomic,strong)NSString *res;

//获取 推荐的 职位列表
+(NSURLSessionDataTask *)getPositionList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *positionArray, Error *e))block;

//申请职位
+(NSURLSessionDataTask *)applyPosition:(NSDictionary *)parameters WithBlock:(void (^)(Position *position, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
