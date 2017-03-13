//
//  LTMySelfFocusImageModel.m
//  LetvIphoneClient
//
//  Created by LC on 14-8-4.
//
//

#import "LTMySelfFocusImageModel.h"

@implementation BlockPicList

-(NSString*)getPic
{
    if (![NSString isBlankString:self.pic_400_250]) {
        return self.pic_400_250;
    }else{
        return self.pic_400_225;
    }
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"400x250":@"pic_400_250",
                                                       @"400x225":@"pic_400_225",
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation  BlockContent

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation LTMySelfFocusImageModel

//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"jump":@"__jump",
//                                                       @"play":@"__play",
//                                                       @"pay":@"__pay",
//                                                       @"isEnd"        : @"__isEnd",
//                                                       @"episode"      : @"__episode",
//                                                       @"nowEpisodes"  : @"__nowEpisodes",
//                                                       }];
//}

@end
