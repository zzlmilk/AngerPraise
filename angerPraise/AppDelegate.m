//
//  AppDelegate.m
//  angerPraise
//
//  Created by zhilingzhou on 15/3/9.
//  Copyright (c) 2015年 Rex. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "MainViewController.h"
#import "MCCore.h"
//#import "WXApi.h"

#define kAppId           @"5bfTGENWJv7KSD7OXA1H42"
#define kAppKey          @"Zp5B5XHl7w96aXTbhihdj3"
#define kAppSecret       @"2uNJCR09ExA7rbYJjWgXj5"


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface AppDelegate ()

@end

@implementation AppDelegate


@synthesize gexinPusher = _gexinPusher;
@synthesize appKey = _appKey;
@synthesize appSecret = _appSecret;
@synthesize appID = _appID;
@synthesize clientId = _clientId;
@synthesize sdkStatus = _sdkStatus;
@synthesize lastPayloadIndex = _lastPaylodIndex;
@synthesize payloadId = _payloadId;


//个推 开始
- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

- (NSString *)currentLogFilePath
{
    NSMutableArray * listing = [NSMutableArray array];
    NSString *docsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray * fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDirectory error:nil];
    if (!fileNames) {
        return nil;
    }
    
    for (NSString * file in fileNames) {
        if (![file hasPrefix:@"_log_"]) {
            continue;
        }
        
        NSString * absPath = [docsDirectory stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:absPath isDirectory:&isDir]) {
            if (isDir) {
                [listing addObject:absPath];
            } else {
                [listing addObject:absPath];
            }
        }
    }
    
    [listing sortUsingComparator:^(NSString *l, NSString *r) {
        return [l compare:r];
    }];
    
    if (listing.count) {
        return [listing objectAtIndex:listing.count - 1];
    }
    
    return nil;
}
// 以上 个推



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //美洽
    [MCCore initWithAppkey:@"558a5b764eae356666000003" expcetionDelegate:nil];
    NSUserDefaults* userData = [NSUserDefaults standardUserDefaults];
    if (![userData objectForKey:@"cookie"]) {
        int random = (arc4random() % 99999) + 10000;
        [userData setObject:[NSString stringWithFormat:@"006600%qu%i",(unsigned long long)([[NSDate date] timeIntervalSince1970] * 1000),random] forKey:@"cookie"];
    }
    
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    // [2-EXT]: 获取启动时收到的APN
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        //NSString *payloadMsg = [message objectForKey:@"payload"];
        //NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        //[_viewController logMsg:record];
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 以上 个推
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(253, 68, 64, 1.0f)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(68, 102, 153, 1.0)];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    

    // 判断token 如果存在 storyborder中 页面跳转到Home
    
    NSUserDefaults *token = [NSUserDefaults standardUserDefaults];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyBoard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *storyBoard2 = [UIStoryboard storyboardWithName:@"Index" bundle:nil];
    if([token objectForKey:@"token"]){
        
        self.window.rootViewController = [storyBoard1 instantiateInitialViewController];
        
    }else{
        
        self.window.rootViewController = [storyBoard2 instantiateInitialViewController];
    }
    

    [WXApi registerApp:@"wx97dbb5b24f24c791"];
    

    return YES;
}


//第二步 重写 两个方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

// onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// 如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
//        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
        NSMutableString* cardStr = [[NSMutableString alloc] init];
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%u\n",cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//  其中req参数为SendMessageToWXReq类型。
-(BOOL) sendReq:(BaseReq*)req{
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // [EXT] 切后台关闭SDK，让SDK第一时间断线，让个推先用APN推送
    [self stopSdk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    // [EXT] 重新上线
    [self startSdkWith:_appID appKey:_appKey appSecret:_appSecret];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 一下 个推

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    _deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", _deviceToken);
    
    
    // [3]:向个推服务器注册deviceToken
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:_deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    // [3-EXT]:如果APNS注册失败，通知个推服务器
    if (_gexinPusher) {
        [_gexinPusher registerDeviceToken:@""];
    }
    
    //[_viewController logMsg:[NSString stringWithFormat:@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    //[_viewController logMsg:record];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
    //[_viewController logMsg:record];
    
     completionHandler(UIBackgroundFetchResultNewData);
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret
{
    if (!_gexinPusher) {
        _sdkStatus = SdkStatusStoped;
        
        self.appID = appID;
        self.appKey = appKey;
        self.appSecret = appSecret;
        
        _clientId = nil;
        
        NSError *err = nil;
        _gexinPusher = [GexinSdk createSdkWithAppId:_appID
                                             appKey:_appKey
                                          appSecret:_appSecret
                                         appVersion:@"0.0.0"
                                           delegate:self
                                              error:&err];
        if (!_gexinPusher) {
           // [_viewController logMsg:[NSString stringWithFormat:@"%@", [err localizedDescription]]];
        } else {
            _sdkStatus = SdkStatusStarting;
        }
        
        //[_viewController updateStatusView:self];
    }
}

- (void)stopSdk
{
    if (_gexinPusher) {
        [_gexinPusher destroy];
        _gexinPusher = nil;
        
        _sdkStatus = SdkStatusStoped;
        
        _clientId = nil;
        
       // [_viewController updateStatusView:self];
    }
}

- (BOOL)checkSdkInstance
{
    if (!_gexinPusher) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"SDK未启动" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)setDeviceToken:(NSString *)aToken
{
    if (![self checkSdkInstance]) {
        return;
    }
    
    [_gexinPusher registerDeviceToken:aToken];
}

- (BOOL)setTags:(NSArray *)aTags error:(NSError **)error
{
    if (![self checkSdkInstance]) {
        return NO;
    }
    
    return [_gexinPusher setTags:aTags];
}

- (NSString *)sendMessage:(NSData *)body error:(NSError **)error {
    if (![self checkSdkInstance]) {
        return nil;
    }
    
    return [_gexinPusher sendMessage:body error:error];
}

- (void)bindAlias:(NSString *)aAlias {
    if (![self checkSdkInstance]) {
        return;
    }
    
    return [_gexinPusher bindAlias:aAlias];
}

- (void)unbindAlias:(NSString *)aAlias {
    if (![self checkSdkInstance]) {
        return;
    }
    
    return [_gexinPusher unbindAlias:aAlias];
}

- (void)testSdkFunction
{
//    UIViewController *funcsView = [[TestFunctionController alloc] initWithNibName:@"TestFunctionController" bundle:nil];
//    [_naviController pushViewController:funcsView animated:YES];
}

//- (void)testSendMessage
//{
//    UIViewController *sendMessageView = [[SendMessageController alloc] initWithNibName:@"SendMessageController" bundle:nil];
//    [_naviController pushViewController:sendMessageView animated:YES];
//    [sendMessageView release];
//}

- (void)testGetClientId {
    NSString *clientId = [_gexinPusher clientId];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前的CID" message:clientId delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - GexinSdkDelegate
- (void)GexinSdkDidRegisterClient:(NSString *)clientId
{
    // [4-EXT-1]: 个推SDK已注册
    _sdkStatus = SdkStatusStarted;
    _clientId = clientId;
    //[_viewController updateStatusView:self];
    
    //    [self stopSdk];
}

- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId
{
    // [4]: 收到个推消息
    _payloadId = payloadId;
    
    NSData *payload = [_gexinPusher retrivePayloadById:payloadId];
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
    }
    NSString *record = [NSString stringWithFormat:@"%d, %@, %@", ++_lastPaylodIndex, [NSDate date], payloadMsg];
    //[_viewController logMsg:record];
}

- (void)GexinSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    //[_viewController logMsg:record];
}

- (void)GexinSdkDidOccurError:(NSError *)error
{
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    //[_viewController logMsg:[NSString stringWithFormat:@">>>[GexinSdk error]:%@", [error localizedDescription]]];
}




@end
