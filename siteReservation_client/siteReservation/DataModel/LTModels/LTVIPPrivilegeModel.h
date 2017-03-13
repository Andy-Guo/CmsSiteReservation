//
//  LTVIPPrivilegeModel.h
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 13-11-8.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

#ifdef LT_IPAD_CLIENT
@interface LTVIPFocusInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *url; //ç¦ç¹é¾æ¥å°å
@property (nonatomic, strong) NSString<Optional> *id; //ä¸è¾id/è§é¢id
@property (nonatomic, strong) NSString<Optional> *type; //å½±çæ¥æºæ ç¤ºï¼1-ä¸è¾,3-è§é¢
@property (nonatomic, strong) NSString<Optional> *mobilePic; //ç¦ç¹å¾é¾æ¥
@property (nonatomic, strong) NSString<Optional> *pic1;
@property (nonatomic, strong) NSString<Optional> *padPic; //iPadå¾ç
@property (nonatomic, strong) NSString<Optional> *pic2;
@property (nonatomic, strong) NSString<Optional> *tvPic;
@end

@interface LTVIPSupperInfo : JSONModel

@property (nonatomic, strong) NSArray<Optional> *contents; //å
@property (nonatomic, strong) NSString<Optional> *name; //æ é¢

@end


@interface LTVIPPrivilegeModel : JSONModel

@property (nonatomic, strong) LTVIPFocusInfo<Optional> *focusInfo; //ä¼åç¦ç¹å¾ä¿¡æ¯
@property (nonatomic, strong) LTVIPSupperInfo<Optional> *supperInfo; //ä¼åç¹æä¿¡æ¯
@end

@interface LTprivilegeList : JSONModel
@property (nonatomic, strong) NSString<Optional> *mobilePic; //内容
@property (nonatomic, strong) NSString<Optional> *title; //标题
@end

#else



@interface LTVIPFocusInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *url; //焦点链接地址
@property (nonatomic, strong) NSString<Optional> *mobilePic; //焦点图链接
@property (nonatomic, strong) NSString<Optional> *pic1;
@property (nonatomic, strong) NSString<Optional> *padPic; //iPad图片
@property (nonatomic, strong) NSString<Optional> *pic2;
@property (nonatomic, strong) NSString<Optional> *tvPic;
@property (nonatomic, strong) NSString<Optional> *id;  //根据type 判断：专辑id 或 视频id
@property (nonatomic, strong) NSString<Optional> *type; //1.视频 2.专辑
@end

@protocol LTVIPSupperInfo <NSObject>
@end
@interface LTVIPSupperInfo : JSONModel

@property (nonatomic, strong) NSString<Optional> *mobilePic; //内容
@property (nonatomic, strong) NSString<Optional> *title; //标题

@end

@protocol LTprivilegeList<NSObject>
@end

@interface LTprivilegeList : JSONModel
@property (nonatomic, strong) NSString<Optional> *mobilePic; //内容
@property (nonatomic, strong) NSString<Optional> *title; //标题
@end


@interface LTVIPPrivilegeModel : JSONModel
@property(nonatomic, readwrite, strong)   LTVIPFocusInfo   *focusInfo;      //会员焦点图信息
@property(nonatomic, readwrite, strong)   LTVIPSupperInfo   *supperInfo;    //会员特权信息
// |privilegeList| contains |LTprivilegeListPB|
@property(nonatomic, readwrite, strong)   NSMutableArray<LTprivilegeList> *privilegeList;      //特权列表

@end
#endif
