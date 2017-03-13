//
//  LTPlayRecommendModel.m
//  LetvIphoneClient
//
//  Created by zhaocy on 14-5-19.
//
//

#import "LTPlayRecommendModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation LTPlayRecommendItem

- (BOOL)isValidVideo
{
    // 产品定义，有vid就可以支持
    if (    [NSString isBlankString:self.vid]
        ||  [self.vid isEqualToString:@"0"]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isItemRecommendedByMachine
{
    if ([NSString isBlankString:self.is_rec]) {
        return NO;
    }
    
    if (    [[self.is_rec lowercaseString] isEqualToString:@"true"]
        ||  [self.is_rec isEqualToString:@"1"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isValidItemByHuman
{
    return (    ![self isItemRecommendedByMachine]
            &&  ([self isValidVideo])
            );
}

- (BOOL)isValidItemByMachine
{
    return (    [self isItemRecommendedByMachine]
            &&  [self isValidVideo]
            );
}

- (BOOL)isRecommendItemSupported
{
    return (    [self isValidItemByHuman]
            ||  [self isValidItemByMachine]);
}

@end

@implementation LTPlayRecommendBlock

@end

@implementation LTPlayRecommendModel

- (LTPlayRecommendItem *)nextValidRecommendItem
{
    if (    !self.block
        ||  self.block.count <= 0) {
        return nil;
    }
    
    LTPlayRecommendBlock *blockItem = self.block.firstObject;
    if (    !blockItem
        ||  !blockItem.list
        ||  blockItem.list.count <= 0) {
        return nil;
    }
    
    LTPlayRecommendItem *recommendItem = blockItem.list.firstObject;
    while (recommendItem) {
        if ([recommendItem isRecommendItemSupported]) {
            break;
        }
        [blockItem.list removeObject:recommendItem];
        if (blockItem.list.count <= 0) {
            recommendItem = nil;
            break;
        }
        recommendItem = blockItem.list.firstObject;
    }
    
    return recommendItem;
}

- (void)removeRecommendItem
{
    if (    !self.block
        ||  self.block.count <= 0) {
        return;
    }
    
    LTPlayRecommendBlock *blockItem = self.block.firstObject;
    if (    !blockItem
        ||  !blockItem.list
        ||  blockItem.list.count <= 0) {
        return;
    }
    
    [blockItem.list removeObjectAtIndex:0];
    
    return;
}

- (NSString *)getReid {
    LTPlayRecommendBlock *blockItem = self.block.firstObject;
    
    return [NSString safeString:blockItem.reid];
}

@end
