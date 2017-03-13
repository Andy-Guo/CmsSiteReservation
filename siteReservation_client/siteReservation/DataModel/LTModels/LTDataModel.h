//
//  LTDataModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTDataModelCommDef.h>

/**
 *  开始声明一个 JSONKeyMapper 的单例.
 *  @param objectMapping 单例变量名称
 *  @return None
 *  @see LT_DECLARE_KEYMAPPER_ONCE_END
 *  @code
 *  +(JSONKeyMapper*) keyMapper
 *  {
 *      LT_DECLARE_KEYMAPPER_ONCE_BEGIN(jsonKeyMapper);
 *      jsonKeyMapper = [[JSONKeyMapper alloc] initWithDictionary: @{
 *                                                                  @"serverKey", @"modelKey",
 *                                                                 }];
 *      LT_DECLARE_KEYMAPPER_ONCE_END();
 *      return jsonKeyMapper;
 *  }
 *  @endcode
 */
#define LT_DECLARE_KEYMAPPER_ONCE_BEGIN(objectMapping) \
static JSONKeyMapper * objectMapping = nil; \
static dispatch_once_t _onceToken ## objectMapping = 0; \
dispatch_once (&_onceToken ## objectMapping, ^ () { \
(void) (0)
/**
 *  JSONKeyMapper 单例声明结束.
 *  @return None
 *  @see LT_DECLARE_KEYMAPPER_ONCE_BEGIN
 */
#define LT_DELCARE_KEYMAPPER_ONCE_END() \
})

// 返回数据状态
typedef NS_ENUM (NSInteger, LTDataStatus) {
    LTDataStatusNormal = 1,       // 数据正常
    LTDataStatusEmpty = 2,        // 数据为空
    LTDataStatusAbnormal = 3,     // 数据异常
    LTDataStatusNotChange = 4,    // 数据无变化
    LTDataStatusTokenExpired = 5,  //tv_token过期
    LTDataStatusIPShield = 6,     // IP被屏蔽
};

#define LTHeaderModel LeTVMobileSDK_LTHeaderModel
@protocol LTDataModel @end
@protocol LTHeaderModel @end

@interface LTHeaderModel : JSONModel

@property (assign, nonatomic) LTDataStatus status;    // string	接口返回状态：1-正常，2-无数据，3-服务异常，4-数据无变化，5-参数错误 6-IP被屏蔽
@property (strong, nonatomic) NSString<Optional>* markid;     // string	内容唯一标示,随数据节点内容变化而变

@end

@interface LTDataModel : JSONModel

@property (strong, nonatomic) LTHeaderModel* header;    // object	接口信息节点
@property (strong, nonatomic) NSDictionary* body;       // object	接口返回数据节点

@end
