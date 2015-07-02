//
//  EditPhoto.m
//  angerPraise
//
//  Created by 单好坤 on 15/5/6.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "EditPhoto.h"
#import "Error.h"
#import "ApIClient.h"


@implementation EditPhoto

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =[super init];

    _res = [dic objectForKey:@"res"];
    
    return self;
    
}


+(void)uploadUserProfileImageParameters:(NSDictionary *)parameters WithBlock:(void (^)(EditPhoto *e))block{
    
//    UIImage *image = [UIImage imageNamed:@"image1"];
//    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSData *imageData = [parameters objectForKey:@"imageData"];
    NSString *  AFAppDotNetAPIBaseURLString = @"http://app.hirelib.com/noozan_api/v1/";
    NSString* URLTmp = [NSString stringWithFormat:@"%@/user/update_photo",AFAppDotNetAPIBaseURLString];
    
    NSString *URLTmps = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request =  [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:@"POST" URLString:URLTmps parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"images" fileName:@"images.png" mimeType:@"image/png"];
        
    } error:nil];
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            
            if (NZ_DugSet) {
                
                [APIClient showInfo:@"请检查网络状态" title:@"网络异常"];
            }
        } else {
            //解析
            //NSLog(@"%@ ", responseObject);
            EditPhoto *b = [[EditPhoto alloc]initWithDic:responseObject];
            block(b);
            
        }
        
    }];
    [uploadTask resume];
    
}



@end
