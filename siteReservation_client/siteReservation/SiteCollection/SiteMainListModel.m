//
//  SiteMainListModel.m
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteMainListModel.h"
#import "DataModelCommDef.h"

@implementation SiteMainListModel

- (NSString *)getDefaultIconBySiteID:(SiteID)siteId
                       forSelectedState:(BOOL)isSelected {
    switch (siteId) {
//        case ChannelAnime:
//            return isSelected ? @"dongman_selected.png" : @"dongman_normal.png";
//        case ChannelDocumentary:
//            return isSelected ? @"jilupian_selected.png" : @"jilupian_normal.png";
//        case ChannelEntertainment:
//            return isSelected ? @"yule_selected.png" : @"yule_normal.png";
//        case ChannelFashion:
//            return isSelected ? @"fengshang_selected.png" : @"fengshang_normal.png";
//        case ChannelMovie:
//            return isSelected ? @"dianying_selected.png" : @"dianying_normal.png";
//        case ChannelSport:
//            return isSelected ? @"tiyu_selected.png" : @"tiyu_normal.png";
//        case ChannelTV:
//            return isSelected ? @"dianshiju_selected.png" : @"dianshiju_normal.png";
//        case ChannelTVProgram:
//            return isSelected ? @"zongyi_selected.png" : @"zongyi_normal.png";
//        case ChannelVip:
//            return isSelected ? @"huiyuan_selected.png" : @"huiyuan_normal.png";
//        case ChannelCar:
//            return isSelected ? @"qiche_selected.png" : @"qiche_normal.png";
    }
    return @"";
}

#pragma mark - properties
- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
//            _type = ChannelAnime;
            break;
    
        default:
            break;
    }
}




@end
