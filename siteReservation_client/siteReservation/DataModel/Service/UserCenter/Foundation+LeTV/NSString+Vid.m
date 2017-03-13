//
// Created by Kerberos Zhang on 14-11-18.
//

#import "NSString+Vid.h"
#import "NSString+UserCenter.h"


@implementation NSString (Vid)
+ (NSString *)getVidFromWebUrlString:(NSString*)urlString
{
    NSRange letvRange = [urlString rangeOfString:@"letv"];
    NSRange vidRange = [urlString rangeOfString:@"vplay_"];
    NSRange endRange = [urlString rangeOfString:@".html"];
    NSString *vid = @"";

    if ((letvRange.location != NSNotFound) &&
            (vidRange.location != NSNotFound) &&
            (endRange.location != NSNotFound) &&
            (endRange.location > vidRange.location))
    {
        NSUInteger location = vidRange.location + vidRange.length;
        vid = [urlString substringWithRange:NSMakeRange(location, endRange.location - location)];
        if (![NSString isValidNumber:vid]) {
            vid = @"";
        }
    }

    return vid;
}
@end