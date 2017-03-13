//
//  LTLetvPlayerCommDef.h
//  LetvIpadClient
//
//  Created by Ji Pengfei on 14-9-10.
//
//

#import <LetvMobileDataModel/LTMoviePlayerCommDef.h>    //#import "LTMoviePlayerCommDef.h"

enum {
    LetvPlayerShowTypeNormal,  //正常的Navigation push的播放器类型
    LetvPlayerShowTypeModal,     // 模态图方式建立在keyWindow上的播放器类型
    LetvPlayerShowTypeFloat   //浮窗形式的播放器类型
};
typedef NSInteger LetvPlayerShowType;


enum {
    LetvPlayerScreenTypeHalf,  //半屏播放器
    LetvPlayerScreenTypeFull,     // 全屏播放器
};
typedef NSInteger LetvPlayerScreenType;

/* 播放器类型 */
enum
{
    LetvPlayerTypeMPMoviePlayer,    // 系统播放器 MPMoviePlayerController
    LetvPlayerTypeAVPlayer,  //系统播放器 AVPlayer
    LetvPlayerTypeLETV,   // letv本地播放器
    
    LetvPlayerTypeH265
};
typedef NSInteger LetvPlayerType;


/* 播放器进入播放类型 */
enum{
    LetvPlayerEnterTypeNormal,  //通过pid，vid等参数进入点播播放器，默认进入方式
    LetvPlayerEnterTypeSubject,  //通过zid进入专题播放器
    LetvPlayerEnterTypeDownload, //通过缓存进入播放器
    LetvPlayerEnterTypeiTunesFile,  //通过itune导入进入的本地播放器
    LetvPlayerEnterTypeLive,  //进入直播播放器
    LetvPlayerEnterTypePushOrdingCode,  //通过push传入的code直接进行直播播放，适用于直播预约
    LetvPlayerEnterTypePushScode,  ////通过push传入的channel_ename直接进行直播播放
};
typedef NSInteger LetvPlayerEnterType;
