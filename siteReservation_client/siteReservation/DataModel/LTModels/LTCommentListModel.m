//
//  LTCommentListModel.m
//  LetvIphoneClient
//
//  Created by bob on 14-3-26.
//
//

#import "LTCommentListModel.h"

@implementation LTCommentImagePack

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"180"  : @"image_180",
                                                       @"310"  : @"image_310",
                                                       @"O"    : @"image_O"
                                                       }];
}

@end

@implementation LTCommentUser

+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end

@implementation LTCommentDataElem
+(BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end

@implementation LTCommentListModel
@end

@implementation LTCommentNumberModel

@end

@implementation LTReplyListModel

@end

@implementation LTCommentAnnouncementElem


@end
