//
//  LTAlbumDetailBatchModel.m
//  LetvIpadClient
//
//  Created by bob on 14-9-16.
//
//

#import "LTAlbumDetailBatchModel.h"


@implementation LTAlbumDetailBatchModel

- (NSString *)getIDs {
    __block NSMutableString *ids = nil;
    
    [self.data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MovieDetailModel *item = (MovieDetailModel *)obj;
        
        if (![NSString empty:item.pid]) {
            if (ids == nil) {
                ids = [NSMutableString stringWithString:item.pid];
            }
            else {
                ids = [NSMutableString stringWithFormat:@"%@,%@", ids, item.pid];
            }
        }
    }];
    
    if (ids == nil) {
        return @"";
    }
    
    return ids;
}


@end
