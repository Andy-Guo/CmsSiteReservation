//
//  LTDataModelCommDef.h
//  LetvIphoneClient
//
//  Created by zhaochunyan on 13-1-25.
//
//

#import "LoginView.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIButton.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>
#import "Global.h"

// 返回数据状态
typedef enum
{
    DataStatusNormal    = 1,    // 数据正常
    DataStatusEmpty     = 2,    // 数据为空
    DataStatusAbnormal  = 3,    // 数据异常
    DataStatusNotChange = 4,    // 数据无变化
    DataStatusTokenExpired = 5, // tv_token过期
    DataStatusIPShield  = 6,    // IP被屏蔽
    
} DataStatus;

// 场地标识
typedef enum
{
    SR1,                // 1#屏蔽室
    SR2,                // 2#屏蔽室
    AutoSR,             // 汽车屏蔽室
    SAC3m,              // 暗室3M
    SAC10m,             // 暗室10M
    ESD,                // 静电房
    Surge,              // 浪涌
    EFT,                // 脉冲群
    CI,                 // 注入电流
    Har,                // 谐波
    LfCI,               // 低频传导抗扰度
} SiteID;
