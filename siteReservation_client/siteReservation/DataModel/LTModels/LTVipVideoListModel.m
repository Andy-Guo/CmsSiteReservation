//
//  LTVipVideoListModel.m
//  LetvIphoneClient
//
//  Created by Chen Jianjun on 14-2-11.
//
//

#import "LTVipVideoListModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTVipVideoListModel

@end

@implementation LTVipVideoListBlock

@end

@implementation LTVipVideoListContent

- (NSString*)getIcon
{
    NSString *iconUrl = @"";
#ifdef LT_IPAD_CLIENT
    if ([DeviceManager isRetina]) {
        iconUrl = self.padPic;
    }
#endif
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.pic;
    }
    
    if ([NSString isBlankString:iconUrl]) {
        iconUrl = self.pic_200_150;
    }
    
    return iconUrl;
}

@end

@implementation LTVipVideoListLinkProperty

@end

@implementation LTVipVideoListFilter

@end