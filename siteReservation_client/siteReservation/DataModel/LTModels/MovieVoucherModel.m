//
//  MovieVoucherModel.m
//  LetvIphoneClient
//
//  Created by pdh on 14-2-8.
//
//

#import "MovieVoucherModel.h"

@implementation MovieVoucherModel

@end
@implementation MovieVoucherTicketShows
- (BOOL)expired{
    if (self.isExpired == nil)
    {
        return YES;
    }
    return [self.isExpired integerValue] == 1;
}
@end
@implementation ServletInfoModel

@end
@implementation MovieVoucherValue
- (NSInteger)total{
    return [[NSString safeString:self.totalSize] integerValue];
}
@end
@implementation MovieVoucherListModel

@end