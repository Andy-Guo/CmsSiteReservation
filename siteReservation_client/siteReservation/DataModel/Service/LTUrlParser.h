//
//  LTUrlParser.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 12-12-3.
//
//

#import <Foundation/Foundation.h>

@protocol LTUrlParserDelegate;

typedef NS_ENUM(NSInteger, LTUrlParserComefrom){
    LTUrlParserComefromPlay             = 0,
    LTUrlParserComefromDownload         = 1
};

typedef NS_ENUM(NSInteger, LTUrlParserErcode){
    LTUrlParserErcodeSuccess            = 0,//请求成功
    LTUrlParserErcodeExpetion           = 428,//LinkShell防盗链时间过期
    LTUrlParserErcodeValidateFaild      = 429//LinkShell防盗链验证失败
};

@interface LTUrlParser : NSObject{
    
	id <LTUrlParserDelegate> __weak _delegate;
    
}

@property (nonatomic, weak) id <LTUrlParserDelegate> delegate;
- (BOOL)parserUrl:(NSString*)strUrl;
- (BOOL)parserUrl:(NSString *)strUrl completion: (void(^)(NSInteger startPlaybackTime, NSInteger endPlaybackTime, NSInteger currentPlaybackTime, NSInteger timeShift)) completion;
- (void)cancelParse;
- (BOOL)parserUrl:(NSString*)strUrl from:(LTUrlParserComefrom)parserState;
- (BOOL)parserUrl:(NSString *)strUrl
      finishBlock:(void (^)(bool isSuccess, bool isExpired, NSArray * finalUrls))finishBlock;

- (BOOL)parserUrlNew:(NSString *)strUrl
         finishBlock:(void (^)(bool isSuccess, bool isExpired, NSInteger startPlaybackTime,NSInteger endPlaybackTime,NSInteger curentPlaybackTime,NSInteger timeShift, NSArray * finalUrls))finishBlock;
@end


@protocol LTUrlParserDelegate<NSObject>

@optional
- (void)LTUrlParser:(LTUrlParser *)urlParser
          isSuccess:(BOOL)success
          isExpired:(BOOL)expired
               urls:(NSArray *)arrUrls;

- (void)LTUrlParser:(LTUrlParser *)urlParser
          isSuccess:(BOOL)success
          isExpired:(BOOL)expired
               urls:(NSArray *)arrUrls
     ddurlLinkShell:(NSString *)ddurlLinkShell;
/*
 * ZhangQigang: 直播添加时移功能以后需要从调度地址获取直播流的开始时间,当前时间,结束时间.
 */
- (void) LTUrlParser: (LTUrlParser*) urlParser
           isSuccess: (BOOL) success
           isExpired: (BOOL) expired
   startPlaybackTime: (NSInteger) startPlaybackTime
     endPlaybackTime: (NSInteger) endPlaybackTime
 currentPlaybackTime: (NSInteger) currentPlaybackTime
           timeShift: (NSInteger) timeShift;

@end
