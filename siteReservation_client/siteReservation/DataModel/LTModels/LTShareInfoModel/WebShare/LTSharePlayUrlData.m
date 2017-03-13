
//create by lixing

#import <LeTVMobileFoundation/LeTVMobileFoundation.h>
#import <LeTVMobileDataModel/LeTVMobileDataModel.h>
#import "LTSharePlayUrlData.h"
//#import <LeTVMobileFoundation/SettingDefine.h>
//#import <LeTVMobileFoundation/SettingManager.h>
//#import <LeTVMobileDataModel/LTDataModelEngine.h>

#define KDefaultAblumSharePlayUrl   @"http://www.letv.com/ptv/pplay/{aid}.html"
#define KDefaultMovieSharePlayUrl    @"http://m.letv.com/vplay_{vid}.html"//旧：http://www.letv.com/ptv/vplay/{vid}.html

#define kShareAlbumUrl @"album_url"
#define kShareMovieUrl @"video_url"


@interface LTSharePlayUrlData ( Private )

- (void)setDefaultSharePlayUrl;
- (void)setDefaultShareAblumPlayUrl;
- (void)setDefaultShareMoviePlayUrl;
- (void)setDefaultSharePlayUrl:(NSString *)defaultPlayUrl withKey:(NSString *)key;

- (void)saveSharePlayUrl;
- (void)saveShareAblumPlayUrl;
- (void)saveShareMoviePlayUrl;

- (void)saveSharePlayUrl:(NSString *)playUrl withKey:(NSString *)key;

@end


@implementation LTSharePlayUrlData


- (void)startRequest
{
    [self setDefaultSharePlayUrl];
//    NSString *requestUrl = [LTRequestURLManager formatRequestURLByModule:LTURLModule_Share_PlayUrl
//                                                                             andDynamicValues:nil];
    
    [LTDataModelEngine refreshTaskWithUrlModule:LTURLModule_Share_PlayUrl
                               andDynamicValues:nil
                              completionHandler:^(NSDictionary *bodyDict, NSString *markid) {
                                  self.dataDictionary =[NSDictionary dictionaryWithDictionary:bodyDict];
                                   [self saveSharePlayUrl];
                              }
                                nochangeHandler:^{
                                    
                                }
                                   emptyHandler:^{
                                       
                                   }
                                   errorHandler:^(NSError *error) {
                                       
                                   }];
}


- (void)setDefaultSharePlayUrl
{
    [self setDefaultShareAblumPlayUrl];
    [self setDefaultShareMoviePlayUrl];
}


- (void)setDefaultShareAblumPlayUrl
{
    [self setDefaultSharePlayUrl:KDefaultAblumSharePlayUrl withKey:KAblumSharePlayUrlKey];
}


- (void)setDefaultShareMoviePlayUrl
{
    [self setDefaultSharePlayUrl:KDefaultMovieSharePlayUrl withKey:KMovieSharePlayUrlKey];
}


- (void)setDefaultSharePlayUrl:(NSString *)defaultPlayUrl withKey:(NSString *)key
{
    NSString *localPlayUrl = [SettingManager getStringValueFromUserDefaults:key];
    if ( [localPlayUrl isEqualToString:@""] )
    {
        [SettingManager saveStringValueToUserDefaults:defaultPlayUrl ForKey:key];
    }
}


- (void)saveSharePlayUrl
{
    [self saveShareAblumPlayUrl];
    [self saveShareMoviePlayUrl];
}


- (void)saveShareAblumPlayUrl
{
    NSString *playUrl = [self.dataDictionary valueForKey:kShareAlbumUrl];
    [self saveSharePlayUrl:playUrl withKey:KAblumSharePlayUrlKey];
}


- (void)saveShareMoviePlayUrl
{
    NSString *playUrl = [self.dataDictionary valueForKey:kShareMovieUrl];
    [self saveSharePlayUrl:playUrl withKey:KMovieSharePlayUrlKey];
}


- (void)saveSharePlayUrl:(NSString *)playUrl withKey:(NSString *)key
{
    NSString *localPlayUrl = [SettingManager getStringValueFromUserDefaults:key];
    if ( ![playUrl isEqualToString:localPlayUrl] )
    {
        [SettingManager saveStringValueToUserDefaults:playUrl ForKey:key];
    }
}


@end
