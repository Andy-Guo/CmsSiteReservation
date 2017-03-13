
//
//  LTNewChannelModel.m
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-8-20.
//
//

#import "LTNewChannelModel.h"
#import "LTDataCenter.h"


@implementation LTNewChannelMainListModel

#pragma mark - properties
- (void)setTypeWithNSString:(NSString*)type
{
    switch ([type integerValue]) {
        case 1:
            _type = ChannelIntroType_ALBUM;
            break;
        case 2:
            _type = ChannelIntroType_VIDEO;
            break;
        case 3:
            _type = ChannelIntroType_RECOMMEND;
            break;
        default:
            break;
    }
}


- (NSString *)getPicStringSelected:(BOOL)selected
{
#ifdef LT_MERGE_FROM_IPAD_CLIENT
    // 涉及字段：pic1(未选中1倍图)、pic2(未选中2倍图)、pic(选中1倍图)、padPic(选中2倍图)
    NSString *ret=nil;
    if (selected) {
        if ([DeviceManager isRetina]) {
            ret = self.padPic;
        }else {
            ret = self.pic;
        }
    }else {
        if ([DeviceManager isRetina]) {
            ret = self.pic2;
        }else {
            ret = self.pic1;
        }
    }
    return ret;
#else
    NSString *pic = nil;
    if (selected) {
        if (iPhone6plus) {
            pic = self.padPic;
        } else {
            pic = self.pic2;
        }
    } else {
        if (iPhone6plus) {
            pic = self.pic;
        } else {
            pic = self.pic1;
        }
    }
    return pic;
#endif
}


@end

@implementation LTNewChannelModel

#ifdef LT_IPAD_CLIENT

- (NSInteger)getChannelCount {
    NSInteger channelCount = 0;
    
    if ([self.channel count] > 0) {
#ifndef LT_MERGE_FROM_IPAD_CLIENT
                channelCount = [self.channel count] + 2; // 添加上直播和专题，放到最后2个
#else
                channelCount = [self.channel count] + 1;//5.5版本去掉了专题
#endif
    }
    
    return channelCount;
}

- (NSInteger)getChannelIDByIndexInner:(NSInteger)index {
    NSInteger channelID = -1;
    
    if (index < [self.channel count]) {
        LTNewChannelMainListModel *model = [self.channel objectAtIndex:index];
        channelID = [model.mzcid integerValue];
    }
    
    return channelID;
}

- (BOOL)isAlbumByIndex:(NSInteger)index {
    BOOL isAlbum = NO;
    
    if (index < [self.channel count]) {
        LTNewChannelMainListModel *model = [self.channel objectAtIndex:index];
        if (model.type == ChannelIntroType_ALBUM) {
            isAlbum = YES;
        }
    }
             
    return isAlbum;
}

- (ChannelID)getChannelIDByIndex:(NSInteger)index{
    
    if (index >= [self.channel count]) {
        if (index == [self.channel count]) {
            return ChannelLive;
        }
        else if (index == [self.channel count] + 1) {
            return ChannelSubject;
        }
    }
    
    NSInteger cid = [self getChannelIDByIndexInner:index];
    
    if (cid == NewCID_Anime) {
        return ChannelAnime;
    }
    if (cid ==NewCID_Documentary) {
        return ChannelDocumentary;
    }
    if (cid == NewCID_Entertainment) {
        return ChannelEntertainment;
    }
    if (cid == NewCID_Fasion) {
        return ChannelFashion;
    }
    if (cid == NewCID_LetvProduce) {
        return ChannelLetvProduce;
    }
    if (cid == NewCID_MOVIE) {
        return ChannelMovie;
    }
    if (cid == NewCID_OpenClass) {
        return ChannelOpenClass;
    }
    if (cid == NewCID_Sport) {
        return ChannelSport;
    }
    if (cid == NewCID_TV) {
        return ChannelTV;
    }
    if (cid == NewCID_TVProgram) {
        return ChannelTVProgram;
    }
    if (cid == NewCID_Tour) {
        return ChannelTravel;
    }
    if (cid == NewCID_Car) {
        return ChannelCar;
    }
    if (cid == NewCID_Finacial) {
        return ChannelFinance;
    }
    if (cid == NewCid_Vip) {
        return ChannelVip;
    }
    if (cid == NewCID_News) {
        return ChannelNews;
    }
    if (cid == NewCID_Kids) {
        return ChannelKids;
    }
    if (cid == NewCID_Music) {
        return ChannelMusic;
    }
    if (cid == NewCID_NBA) {
        return ChannelNBA;
    }
    if (cid == NewCID_AdaptivieChanel) {
        return ChannelAdapter;
    }
    if (cid == Newcid_F1) {
        return ChannelF1;
    }
    if (cid == Newcid_AmericanDrama) {
        return ChannelEnglish;
    }
    if (cid == Newcid_Game) {
        return ChannelGame;
    }
    if (cid == Newcid_Advertise) {
        return ChannelAdvertise;
    }
    if (cid == Newcid_EPL) {
        return ChannelEPL;
    }
    
    return ChannelUnDefine;
}

- (NSString *)getDefaultIconByChannelID:(ChannelID)channelId
                       forSelectedState:(BOOL)isSelected{
    
    switch (channelId) {
        case ChannelAnime:
            return isSelected ? @"dongman_selected.png" : @"dongman_normal.png";
        case ChannelDocumentary:
            return isSelected ? @"jilupian_selected.png" : @"jilupian_normal.png";
        case ChannelEntertainment:
            return isSelected ? @"yule_selected.png" : @"yule_normal.png";
        case ChannelFashion:
            return isSelected ? @"fengshang_selected.png" : @"fengshang_normal.png";
        case ChannelLetvMake:
            return isSelected ? @"leshizhizao_selected.png" : @"leshizhizao_normal.png";
        case ChannelLetvProduce:
            return isSelected ? @"leshichupin_selected.png" : @"leshichupin_normal.png";
        case ChannelMovie:
            return isSelected ? @"dianying_selected.png" : @"dianying_normal.png";
        case ChannelOpenClass:
            return isSelected ? @"gongkaike_selected.png" : @"gongkaike_normal.png";
        case ChannelSport:
            return isSelected ? @"tiyu_selected.png" : @"tiyu_normal.png";
        case ChannelTV:
            return isSelected ? @"dianshiju_selected.png" : @"dianshiju_normal.png";
        case ChannelTVProgram:
            return isSelected ? @"zongyi_selected.png" : @"zongyi_normal.png";
        case ChannelVip:
            return isSelected ? @"huiyuan_selected.png" : @"huiyuan_normal.png";
        case ChannelCar:
            return isSelected ? @"qiche_selected.png" : @"qiche_normal.png";
        case ChannelTravel:
            return isSelected ? @"lvyou_selected.png" : @"lvyou_normal.png";
        case ChannelFinance:
            return isSelected ? @"caijing_selected.png" : @"caijing_normal.png";
        case ChannelSubject:
            return isSelected ? @"zhuanti_selected.png" : @"zhuanti_normal.png";
        case ChannelLive:
            return isSelected ? @"zhibo_selected.png" : @"zhibo_normal.png";
        case ChannelKids:
            return isSelected ? @"qinzi_selected.png" : @"qinzi_normal.png";
        case ChannelMusic:
            return isSelected ? @"yinyue_selected.png" : @"yinyue_normal.png";
        case ChannelNBA:
            return isSelected ? @"nba_selected.png" : @"nba_normal.png";
        case ChannelUnDefine:
        default:
            break;
    }
    
    return @"";
    
}

#endif

- (BOOL)isShouldCache
{
    __block BOOL isNeedCache = NO;
    if (self.channel.count > 0) {
        [self.channel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LTChannelDataModel *dataModel = (LTChannelDataModel *)obj;
            if (dataModel.data.count > 0) {
                isNeedCache = YES;
            }
        }];
    }
    
    if (!isNeedCache) {
        NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙 LTChannelIndexModel check data exception, blockCount:%ld", (unsigned long)[self.channel count]];
        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
    }
    
    return isNeedCache;
}

@end


@implementation LTChannelDataModel

@end

// iPhone 6.5 频道墙model
@implementation LTChannelWallModel
- (BOOL)isShouldCache
{
    __block BOOL isNeedCache = NO;
    if (self.channel.count > 0) {
   
        isNeedCache = YES;
    }
    if (!isNeedCache) {
        NSString *errorCodeInfo = [NSString stringWithFormat:@"频道墙 LTChannelIndexModel check data exception, blockCount:%ld", (unsigned long)[self.channel count]];
        [LTDataCenter writeToErrorLogFile:errorCodeInfo];
    }
    
    return isNeedCache;
}

- (void)saveDefaultNameAndPageID
{
    NSMutableDictionary *pageids = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *names = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *types = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < self.channel.count; i ++) {
        LTNewChannelMainListModel *obj = self.channel[i];
        
        //保存频道pageid和name用于更多跳转
        if (![NSString isBlankString:obj.mzcid] && ![NSString isBlankString:obj.pageid]) {
            [pageids setObject:obj.pageid forKey:obj.mzcid];
        }
        if (![NSString isBlankString:obj.mzcid] && ![NSString isBlankString:obj.name]) {
            [names setObject:obj.name forKey:obj.mzcid];
        }
        if (![NSString isBlankString:obj.mzcid] && obj.type != ChannelIntroType_UNKOWN) {
            [types setObject:[NSString stringWithFormat:@"%d", obj.type] forKey:obj.mzcid];
        }
    }
    
    [SettingManager setChannelName:names];
    [SettingManager setChannelPageID:pageids];
    [SettingManager setChannelType:types];
}

- (void)checkData:(NSDictionary *)dictionary
{
#ifdef LT_IPAD_CLIENT
    NSString *sandboxPath = [FileManager appNavigationDataPath];
#else
    NSString *sandboxPath = [FileManager appNavigationDataDocumentPath];
#endif

    NSString *endPath = [sandboxPath stringByAppendingPathComponent:NSLocalizedString(kChannelDefault, nil)];
    NSDictionary *jsonObject = [NSDictionary dictionaryWithContentsOfFile:endPath];
 
    LTLog(@"endPath %@", endPath);
    NSString *isEdit = jsonObject[@"isEdit"];
    BOOL result = NO;
    
    NSMutableArray *newLocks = [[NSMutableArray alloc] initWithCapacity:10];    // 网络数据 锁住的
    
    if (![NSObject empty:jsonObject]) {
        
        if ([dictionary isEqualToDictionary:jsonObject]) {
            // 如果网络数据和本地数据相等就不需要更新了
            return;
        }
        LTChannelWallModel *tmpChannelModel = [[LTChannelWallModel alloc] initWithDictionary:jsonObject error:nil];
        
        NSMutableArray *newAdds = [[NSMutableArray alloc] initWithCapacity:10];     // 新增的
        
        NSMutableArray *tmpItems = [[NSMutableArray alloc] initWithCapacity:10];    // 沙盒保存，用于合并两个数组
        
        // 合并两个数组方便遍历
        if (tmpChannelModel.channel.count > 0) {
            [tmpItems addObjectsFromArray:tmpChannelModel.channel];
            if (tmpChannelModel.otherChannel.count > 0) {
                [tmpItems addObjectsFromArray:tmpChannelModel.otherChannel];
            }
        }
        
        for (NSInteger i = 0; i < self.channel.count; i ++) {
            
            LTNewChannelMainListModel *listModel = self.channel[i];
            
            if ([listModel.lock boolValue]) {
                // 网络数据锁住的
                [newLocks addObject:listModel];
                continue;
            }
            
            // 是否是新添加的频道
            BOOL isNew = YES;
            for (NSInteger j = 0; j < tmpItems.count; j ++) {
                LTNewChannelMainListModel *tmpListModel = tmpItems[j];
                if ([tmpListModel.mzcid isEqualToString:listModel.mzcid]) {
                    isNew = NO;
                    break;
                }
            }
            if (isNew) {
                [newAdds addObject:listModel];
            }
        }
        
        if (newAdds.count > 0) {
            [self.channel removeObjectsInArray:newAdds];
        }
        
        if (newLocks.count > 0) {
            [self.channel removeObjectsInArray:newLocks];
        }
        
        // 重新按照原来的排序
        NSMutableArray *sortChannel = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (NSInteger i = 0; i < tmpChannelModel.channel.count; i ++) {
            
            LTNewChannelMainListModel *oldModel = tmpChannelModel.channel[i];
            
            for (NSInteger j = 0; j < self.channel.count; j ++) {
                LTNewChannelMainListModel *newModel = self.channel[j];

                if ([oldModel.mzcid isEqualToString:newModel.mzcid]) {
                    [sortChannel addObject:newModel];
                    break;
                }
            }
        }
        
#ifndef LT_IPAD_CLIENT
        NSMutableArray *sortOtherChannel = [[NSMutableArray alloc] initWithCapacity:10];

        for (NSInteger i = 0; i < tmpChannelModel.otherChannel.count; i ++) {
            
            LTNewChannelMainListModel *oldModel = tmpChannelModel.otherChannel[i];
            
            for (NSInteger j = 0; j < self.channel.count; j ++) {
                LTNewChannelMainListModel *newModel = self.channel[j];
                
                if ([oldModel.mzcid isEqualToString:newModel.mzcid]) {
                    [sortOtherChannel addObject:newModel];
                    break;
                }
            }
        }

        //删除其他频道已经是所状态的元素
        if (sortOtherChannel.count > 0 && newLocks.count > 0) {
            [sortOtherChannel removeObjectsInArray:newLocks];
        }
#endif
        
        [newLocks addObjectsFromArray:sortChannel];
        [newLocks addObjectsFromArray:newAdds];

        // 清理channel内所有数据
        self.channel = (NSMutableArray <LTNewChannelMainListModel, Optional> *)newLocks;
#ifndef LT_IPAD_CLIENT
        self.otherChannel = (NSMutableArray <LTNewChannelMainListModel, Optional> *)sortOtherChannel;
#endif
        if (YES == [isEdit boolValue]) {
            self.isEdit = isEdit;
        }
        dictionary = [self toDictionary];
    } else {
        // 对数据重新排序，把锁住的提到前面（注意：锁住的可能在中间）
        NSMutableArray *noLocks = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (NSInteger i = 0; i < self.channel.count; i ++) {
            
            LTNewChannelMainListModel *listModel = self.channel[i];
            
            if ([listModel.lock boolValue]) {
                // 网络数据锁住的
                [newLocks addObject:listModel];
                
            } else {
                [noLocks addObject:listModel];
            }
        }
        
        [newLocks addObjectsFromArray:noLocks];
        self.channel = (NSMutableArray <LTNewChannelMainListModel, Optional> *)newLocks;
        if (YES == [isEdit boolValue]) {
            self.isEdit = isEdit;
        }
        dictionary = [self toDictionary];
    }
 
    result = [dictionary writeToFile:endPath atomically:YES];


    if (!result) {
        LTLog(@"导航控制器写入失败");
    }
}
@end

