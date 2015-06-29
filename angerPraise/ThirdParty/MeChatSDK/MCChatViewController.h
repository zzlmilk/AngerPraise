//
//  MCChatViewController.h
//  MeChatSDK
//
//  Created by Injoy on 14-8-25.
//  Copyright (c) 2014年 MeChat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMessage.h"
#import "MCEvent.h"
#import "MCService.h"

#define SERVICE_ONLINE_TIP @"客服上线啦~" //在留言状态时，客服上线的提示（为空则不提醒）
#define NOT_SERVICE_ONLINE_TIP @"暂时没有客服在线，请留言" //没有客服在线时的提醒（为空则不提醒）
#define BLACKLIST_TIP @"你已被客服拉进黑名单" //被拉入黑名单时的提醒（为空则不提醒）


#define URL_REGULAR @"(((http[s]?://)|(ftp://))*([a-zA-Z0-9]+)\\.)+((com)|(net)|(im)|(cn)|(us)|(me)|(org)|(edu)|(cc)|(biz)|(info)|(tv)|(co)|(so)|(tel)|(mobi))+(((/)|(#)|(\\?))([a-zA-Z0-9]*)([a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/|=<>]*))*"
#define PHONE_REGULAR @"\\d{8,14}|\\d{3,4}-\\d{3,4}-\\d{3,4}|\\d{2,4}-\\d{7,11}"
#define EMAIL_REGULAR @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"

#define LINK_COLOR [UIColor colorWithRed:59/255. green:136/255. blue:195/255. alpha:1]

//设置MCChatViewController的regexs默认值
#define MESSAGE_REGULAR @{ \
URL_REGULAR                     : LINK_COLOR, \
PHONE_REGULAR                   : LINK_COLOR, \
EMAIL_REGULAR                   : LINK_COLOR \
}

@protocol MCChatViewDelegate <NSObject>
@optional
/**
 * 客服改变。分配客服成功时返回客服对象；客服下线等情况返回nil，并返回错误或异常(请求超时、用户在黑名单、没有客服在线、未知错误)
 */
-(void)serviceChange:(MCService*)service expcetion:(kMCExceptionStatus)expcetion;

/**
 * 用户即将关闭视图
 */
-(void)chatViewWillDisappear;

/**
 * 用户关闭视图后
 */
-(void)chatViewDidDisappear;

/**
 * 用户在客服视图中时收到消息，如果用户退出视图，则不会再收到消息。
 * @warning 注意不要与MCMessageDelegate中的-(void)receiveMessage:混淆，两者的参数类型不同。
 */
-(void)receiveMessage:(MCMessage*)message;

/**
 * 用户在客服视图中时收到事件，如果用户退出视图，则不会再收到事件。
 */
-(void)receiveEvent:(MCEvent*)event;

/**
 * 消息里被regexs中的正则表达式匹配上的某个段落被点击（若regexs使用默认值，可以不用实现该方法）
 * @param paragraph 被点击的段落
 * @param range 该段落在消息中的范围
 */
-(void)selectionMessageParagraph:(NSString*)paragraph selectionRange:(NSRange)range NS_AVAILABLE_IOS(7_0);

/**
 * 「用户准备录音」和「结束录音」的代理函数
 * 如果使用了美洽的语音功能，建议在开始录音时暂停APP的音频播放，结束录音时恢复播放
 */
-(void)recordWillBegin;
-(void)recordDidEnd;
@end


@interface MCChatViewController : UIViewController

@property(nonatomic,strong) id<MCChatViewDelegate> delegate;

//正则表达式组，用于匹配消息，满足条件段落会以超链接的形式展现，并且可以被用户点击。键为正则表达式字符串(NSString)，值为段落的文字颜色(UIColor)。
//注意：如果段落颜色与消息颜色相同，将无法点击。
@property (nonatomic,strong) NSDictionary* regexs NS_AVAILABLE_IOS(7_0);

//每次分页加载的消息数量，默认为20
@property (nonatomic       ) int        messageLength;

//设备唯一标识符。当视图控制器关闭，则将顾客离线并开启推送
@property (nonatomic,strong) NSString   * deviceToken;

//是否同步顾客在其他客户端产生的消息记录，默认NO
//如果同步，将会产生一定网络请求。所以建议顾客端只使用美洽SDK的用户保持默认值
@property (nonatomic       ) BOOL       syncNetworkMessage;

//是否显示事件提示（默认YES）
@property (nonatomic       ) BOOL       showEventEnable;

//是否允许发送语音消息（默认YES）
@property (nonatomic       ) BOOL       sendAudioEnable;

//是否隐藏提示（默认NO，当网络异常时总会提示）
@property (nonatomic       ) BOOL       hideTipView;

//用户的消息颜色（默认黑色）
@property (nonatomic,strong) UIColor    * userMessageColor;
//客服的消息颜色（默认黑色）
@property (nonatomic,strong) UIColor    * serverMessageColor;
//时间、事件描述文字颜色（默认灰色）
@property (nonatomic,strong) UIColor    * tipTextColor;

//navigationBar的tintColor
@property (nonatomic,strong) UIColor    * navigationBarTintColor;

//在当前frame的基础上修改frame。如右移5px,高度缩小20px: CGRectMake(5, 0, 0, -20);
@property (nonatomic       ) CGRect     putFrame;


//titleView
@property (nonatomic,strong) UIView     * titleView;

//气泡的容器是UITableView（请勿修改frame等信息）
@property (nonatomic,strong) UIView     * chatTableView;

//footerBar（请勿修改frame等信息）
@property (nonatomic,strong) UIView     * footerBar;

//footerBar中的TextView（请勿修改frame等信息）
@property (nonatomic,strong) UITextView * textView;


@end
