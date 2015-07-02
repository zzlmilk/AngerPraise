//
//  ResumeScore.h
//  angerPraise
//
//  Created by 单好坤 on 15/4/10.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Error.h"

@interface ResumeScore : NSObject

@property(nonatomic,strong)NSString *compensation_name;
@property(nonatomic,strong)NSString *objective_functions;
@property(nonatomic,strong)NSString *user_dynamic_number;
@property(nonatomic,strong)NSString *resume_update_time;
@property(nonatomic,strong)NSString *user_position;
@property(nonatomic,strong)NSString *user_resume_synthesize_grade;

//0为用户未上传简历  1为用户已上传简历
@property(nonatomic,strong)NSString *resume_status;

//@property(nonatomic,strong)NSString *user_resume_competitiveness;
//@property(nonatomic,strong)NSString *user_resume_perfect;
//@property(nonatomic,strong)NSString *user_resume_synthesize_grade;



//从简历中获取用户昵称和简历完善度 竞争力以及综合评分评分
+(NSURLSessionDataTask *)getResumeScoer:(NSDictionary *)parameters WithBlock:(void (^)(ResumeScore *resumeScore, Error *e))block;



@end
