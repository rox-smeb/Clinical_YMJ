//
//  MacroDefine.h
//
//  Created by AnYanbo on 16/6/6.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#ifndef _____Macro_h
#define _____Macro_h

/**
 *  登陆检测
 */
#define LOGIN_CHECK                                  \
do                                                   \
{                                                    \
    if ([UserInfo isLogin] == NO)                    \
    {                                                \
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NEED_LOGIN object:nil]; \
        return;                                      \
    }                                                \
} while(0)

#define LOGIN_CHECK_BOOL                             \
do                                                   \
{                                                    \
    if ([UserInfo isLogin] == NO)                    \
    {                                                \
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NEED_LOGIN object:nil]; \
        return NO;                                   \
    }                                                \
} while(0)


#define NET_INTERFACE_STATE_LOGIN_ILLEGALITY        (10)                                    // 非法登陆状态码

#define URL_TYPE_LOCAL                              (1)                                     // 本地接口
#define URL_TYPE_NETWORK                            (2)                                     // 网络接口
#define URL_TYPE                                    URL_TYPE_NETWORK

#if URL_TYPE == URL_TYPE_LOCAL
    #define URL_BASE                                (@"192.168.0.237")                      // 本地服务器地址
    #define URL_PORT_NUM                            (@"8057")                               // 端口号
#elif URL_TYPE == URL_TYPE_NETWORK
    #define URL_BASE                                (@"115.28.133.3")                       // 远程服务器地址
    #define URL_PORT_NUM                            (@"8057")                               // 端口号
#endif

#define IS_APP_USED                                 (@"IsAppUsed")                          // APP是否初次使用
#define USE_ANIMATE_FROM_INTRO_TO_MAIN              (0)                                     // 引导页->主页(是否使用动画)

#define RMB                                         (@"¥")
#define RMB1                                        (@"元")

#define DEFAULT_IMAGE_HEIGHT_2_WIDTH_RATIO          (3.0f / 4.0f)                           // 图片宽高比例
#define DEFAULT_IMAGE_HEIGHT_2_WIDTH_RATIO1         (3.0f / 5.0f)                           // 图片宽高比例1
#define DEFAULT_IMAGE_NAME                          (@"yjws")
#define DEFAULT_IMAGE                               ([UIImage imageNamed:DEFAULT_IMAGE_NAME])
#define DEFAULT_HEAD_IMAGE_NAME                     (@"head")
#define DEFAULT_HEAD_IMAGE                          ([UIImage imageNamed:DEFAULT_HEAD_IMAGE_NAME])
#define DEFAULT_HEAD_IMAGE_NAME1                    (@"默认头像1")
#define DEFAULT_HEAD_IMAGE1                         ([UIImage imageNamed:DEFAULT_HEAD_IMAGE_NAME1])

#define DEFAULT_AREA_VOICE_DOWNLOAD_DIR             (@"Download")                           // 景区语音下载位置
#define DEFAULT_AREA_VOICE_SAVE_DIR                 (@"Voices")                             // 景区语音存放位置

#define NAV_TITLE_FONT_SIZE                         (18.0f)                                 // 导航栏标题字体大小
#define COMMON_COLOR                                (UIColorMake(12, 91, 200))              // APP主色调
//#define COMMON_COLOR                                ([UIColor whiteColor])              // APP主色调

#define COMMON_COLOR1                               (UIColorMake(12, 91, 200))              // APP主色调1
#define COMMON_TEXT_COLOR                           (UIColorMake(80, 80, 80))               // APP文字颜色
#define STRING_LOADING                              (@"正在加载...")
#define STRING_PROCESSING                           (@"正在处理...")

#define URL_USER_AGREEMENT                          ([NSString stringWithFormat:@"http://%@:%@/UserAgreement.html", URL_BASE, URL_PORT_NUM])

/**
 *  支付方式
 */
#define PAY_TYPE_ALIPAY                             (@"alipay")
#define PAY_TYPE_WX                                 (@"wx")
#define PAY_TYPE_UPACP                              (@"upacp")
#define PAY_TYPE_CASH                               (@"cashpay")

/**
 *  Bugly AppID
 */
#define BUGLY_APP_ID                                (@"f2a7ba2838")

/**
 *  蒲公英 AppID
 */
#define PGY_APP_ID                                  (@"a89de604b1b60aff3c43f9bd695b7374")

/**
 *  极光推送AppKey
 */
#define JPUSH_APP_KEY                               (@"c8eb53c6c1dcb1921f660358")

/**
 *  极光推送渠道
 */
#define JPUSH_CHANNEL                               (@"Publish channel")

/**
 *  友盟推送AppKey
 */
#define UMESSAGE_APP_KEY                            (@"557fed2667e58eb0b600044c")

/**
 *  讯飞AppKey
 */
#define IFLY_APP_KEY                                (@"572fe524")

/**
 *  高德地图AppKey
 */
#define AMAP_APP_KEY                                (@"4d65fa04d98593b662c49cba4fb0e881")

/**
 *  友盟AppKey
 */
#define UMENG_APP_KEY                               (@"57303038e0f55a7519000f2c")

/**
 *  支付宝url scheme
 */
#define ALIPAY_SCHEME                               (@"CLWgarage")

/**
 *  微信
 */
#define WECHAT_APP_KEY                              (@"wxe9cb60aeda66521a")

/**
 *  QQ
 */
#define QQ_APP_ID                                   (@"1105309041")
#define QQ_APP_ID_HEX                               (@"41E1AD71")
#define QQ_APP_KEY                                  (@"XRaCJuyaDuC1ZkPb")

/**
 *  新浪微博
 */
#define SINA_APP_KEY                                (@"")
#define SINA_APP_SECRET                             (@"")

#endif
