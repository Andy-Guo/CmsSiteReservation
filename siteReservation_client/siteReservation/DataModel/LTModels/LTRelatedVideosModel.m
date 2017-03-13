//
//  LTRelatedVideosModel.m
//  LetvIpadClient
//
//  Created by liuxuan on 14-9-12.
//
//

#import "LTRelatedVideosModel.h"

@implementation LTRelatedVideoItem

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id"  : @"vid",
                                                       }];
}

#pragma mark - properties
-(void)setJumpWithNSString:(NSString*)jump
{
    _jump = ([jump integerValue] == 1) ? TRUE : FALSE;
}

-(void)setPlayWithNSString:(NSString*)play
{
    _play = ([play integerValue] == 1) ? TRUE : FALSE;
}

-(void)setPayWithNSString:(NSString*)pay
{
    _pay = ([pay integerValue] == 1) ? TRUE : FALSE;
}

-(void)setDownloadWithNSString:(NSString*)download
{
    _download = ([download integerValue] == 1) ? TRUE : FALSE;
}

@end

@implementation LTRelatedVideosModel


@end
