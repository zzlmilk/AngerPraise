//
//  Error.h
//  VehicleMounted_BMW
//
//  Created by 单好坤 on 14-8-19.
//  Copyright (c) 2014年 单好坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NZAlertView.h"

@interface Error : NSObject

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *info;

-(id)initWith:(NSString *)error_code;
-(NSString*)errorString:(NSString *)error_code;
@end
