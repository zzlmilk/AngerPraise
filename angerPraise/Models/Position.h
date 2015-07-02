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
@property(nonatomic,strong)NSString *companyName;//公司名称
@property(nonatomic,strong)NSString *workPlace;//地区
@property(nonatomic,strong)NSString *education; //学历
@property(nonatomic,strong)NSString *matchNumber;//匹配度
@property(nonatomic,strong)NSString *rank;//排名
@property(nonatomic,strong)NSString *competitionNumber;//竞争人数
@property(nonatomic,strong)NSString *type; // 1精确推荐 2关联推荐 3特长推荐
@property(nonatomic,strong)NSString *creatTime;//发布时间
@property(nonatomic,strong)NSString *webUrl; //职位详情url
@property(nonatomic,strong)NSString *subsidiesInterview;//是否有面试补贴 1有 0 没有
@property(nonatomic,strong)NSString *hot_job_status; // 是否有热门职位 0 否，1 是
@property(nonatomic,strong)NSString *now_hiring_status; // 是否急招 0 否，1 是
@property(nonatomic,strong)NSString *high_salary_status; // 是否高薪 0 否，1 是
@property(nonatomic,strong)NSString *company_map_status; //是否有地图 0 否，1 是
@property(nonatomic,strong)NSString *company_video_status; //是否有视频 0 否，1 是
@property(nonatomic,strong)NSMutableArray *hot_words; //热词


@property(nonatomic,strong)NSString *recommended_number; //推荐职位的数量





//申请职位
@property(nonatomic,strong)NSString *res;

//获取 推荐的 职位列表
+(NSURLSessionDataTask *)getPositionList:(NSDictionary *)parameters WithBlock:(void (^)(NSMutableArray *positionArray, Error *e))block;

//申请职位
+(NSURLSessionDataTask *)applyPosition:(NSDictionary *)parameters WithBlock:(void (^)(Position *position, Error *e))block;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
