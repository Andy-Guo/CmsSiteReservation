//
//  LTDataCenterCommDef.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-9-2.
//
//

#ifndef LetvIphoneClient_LTDataCenterCommDef_h
#define LetvIphoneClient_LTDataCenterCommDef_h
#import <LetvMobileFoundation/LetvMobileFoundation.h>

#define LT_URL_DC_NEW_TEST_HEAD     @"http://dc.app.m.letv.com/m/"
#define LT_URL_DC_NEW_TEST_KV_HEAD  @"http://dc.app.m.letv.com/"

#ifdef DEVELOP_MODE_FOR_STATISTICS
    #define LT_URL_DC_HEAD              @"http://dev.dc.letv.com/m/"    // 测试接口

#ifndef LT_MERGE_FROM_IPAD_CLIENT
    #define LT_URL_DC_KV_HEAD           @"http://develop.bigdata.letv.com/0na7/"    // 测试接口 2.0
#else
    #define LT_URL_DC_KV_HEAD           @"http://develop.bigdata.letv.com/0mc8/"      // 大数据部测试接口
#endif

    #define LT_URL_DC_KV_HEAD_AD           @"http://dev.dc.letv.com/"      // 测试接口
#else
    #define LT_URL_DC_HEAD              @"http://apple.www.letv.com/m/"        // 正式接口
    #define LT_URL_DC_KV_HEAD           @"http://apple.www.letv.com/"          // 正式接口 2.0
#endif

#define LT_URL_DC_LOGIN_FLAG            @"l?"  // 登录
#define LT_URL_DC_PLAY_FLAG             @"p?"  // 播放
#define LT_URL_DC_ACTION_RT_FLAG        @"d?"  // 动作日志，实时
#define LT_URL_DC_ACTION_AD_PLAY_FLAG   @"c?"  // 贴片广告日志

// key-value格式上报
#define LT_URL_DC_KV_ACTION_FLAG        @"op/?"     // 动作
#define LT_URL_DC_KV_LOGIN_FLAG         @"lg/?"     // 登录
#define LT_URL_DC_KV_ENV_FLAG           @"env/?"    // 环境
#define LT_URL_DC_KV_PLAY_FLAG          @"pl/?"     // 播放
#define LT_URL_DC_KV_AD_FLAG            @"pad/?"    // 广告
#define LT_URL_DC_KV_QUERY_FLAG         @"qy/?"     // 搜索
#define LT_URL_DC_KV_ERROR_FLAG         @"er/?"     // 错误


#define LT_DEVICE_BRAND @"apple"
// 缓存日志filename，类型与时间分隔符
#define LT_DC_CACHE_FILENAME_SEPARATOR  (@",")
// 统计空值用"-"表示
#define EMPTY_PARAM_VALUE @"-"
// 一次启动间隔时间，1分钟
#define LT_DC_VALID_LOGIN_INTERVAL  (1 * 60)

// 统计版本
#define LT_DATA_CENTER_VERSION      @"1.6"
#define LT_DATA_CENTER_KV_VERSION   @"3.0"
#define LT_DATA_CENTER_KV_VERSION_3 @"3.0"

// 一级业务线代码 -- 移动部
#define LT_DATA_CENTER_P1VALUE  @"0"
// 二级业务线代码 -- 乐视视频
#define LT_DATA_CENTER_P2VALUE  @"00"

// 三级产品线代码 -- 乐视视频iphone002，ipad004
#ifdef LT_IPAD_CLIENT
#define LT_DATA_CENTER_P3VALUE  @"004"
#else
#define LT_DATA_CENTER_P3VALUE  @"002"
#endif

// 浏览器名称
#define LT_DATA_CENTER_BROWSER  @"safa"
// 操作系统名称
#define LT_DATA_CENTER_OPSYSTEM @"ios"
// 终端品牌
#define LT_DATA_CENTER_BRAND    @"apple"

// 终端型号
#ifdef LT_IPAD_CLIENT
#define LT_DATA_CENTER_TERMINALTYPE @"pad"
#else
#define LT_DATA_CENTER_TERMINALTYPE @"phone"
#endif

// 应用版本号
#define LT_DATA_CENTER_APPVERSION   CURRENT_VERSION

// 空值
#define LT_DATA_CENTER_EMPTY_REQUIRED   @"-"
// property 分隔符号
#define LT_DATA_CENTER_PROPERTY_SEPARATOR   (@"&")
// key value参数 分隔符号
#define LT_DATA_CENTER_PARAM_SEPARATOR      (@"&")
// key value连接符
#define LT_DATA_CENTER_KV_CONNECTOR         (@"=")

//错误日志文件名
#define ErrorLogText @"errorLogText.txt"
#define CDELogText   @"cde.log"
#define APP_NAME_ForData  @"LetvIOSPhoneClient"

#define LT_DC_FIELD_DEFINE(statisticsTypeName, fieldName) \
    NSString *s_##statisticsTypeName##_##fieldName = [NSString stringWithFormat:@"%s", #fieldName];


#endif
