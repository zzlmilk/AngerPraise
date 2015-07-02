//
//  Base.m
//  angerPraise
//
//  Created by zhilingzhou on 15/7/2.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "NZBase.h"
#import "Error.h"
#import "NoozanAppdelegate.h"


@implementation NZBase

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    
    
    
    
    if ([dic objectForKey:@"error"]){
        NSString* code =[[dic objectForKey:@"error"] objectForKey:@"code"];
        NSString* info =[[dic objectForKey:@"error"] objectForKey:@"info"];
        
        Error *e = [[Error alloc]init];
        e.info = info;
        [e errorString:code];
        
        
    }
    
    return self;
    
}



@end
