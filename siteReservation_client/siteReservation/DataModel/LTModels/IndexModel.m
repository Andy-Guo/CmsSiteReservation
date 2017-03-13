//
//  IndexModel.m
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

#import "IndexModel.h"
//#import "NSString+HTTPExtensions.h"

@implementation BlockModel

//#pragma mark - properties
//- (void)setIslinkWithNSString:(NSString *)islink
//{
//    _islink = ([islink integerValue] == 1) ? TRUE : FALSE;
//}
//
//- (void)setIsmaskWithNSString:(NSString *)ismask
//{
//    _ismask = ([ismask integerValue] == 1) ? TRUE : FALSE;
//}

@end



@implementation BootimgModel

//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//            @"800*1280" : @"pic800_1280",
//            @"1024*768" : @"pic1024_768",
//            @"640*960"  : @"pic640_960",
//            @"640*1136" : @"pic640_1136"
//            }];
//}
//
#pragma mark - properties
- (void)setPushpic_starttimeWithNSString:(NSString *)pushpic_starttime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _pushpic_starttime = [formatter dateFromString:pushpic_starttime];
}

- (void)setPushpic_endtimeWithNSString:(NSString *)pushpic_endtime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _pushpic_endtime = [formatter dateFromString:pushpic_endtime];
}
//
//- (void)setSettopWithNSString:(NSString *)settop
//{
//    _settop = ([settop integerValue] == 1) ? TRUE : FALSE;
//}

#pragma mark - others

- (NSString *)getPushPicName
{
    // 只有ipad用
    return self.pic_1;
//#ifdef LT_IPAD_CLIENT
//    return self.pic_1;
//#else
//    if (iPhone5) {
//        return self.pic640_1136;
//    }else{
//        return self.pic640_960;
//    }
//#endif
}

- (LTBootImagePriority)getPushPicPriority{
    
//    if (self.settop) {
//        return 1;
//    }
    
    return 0;
}

@end

@implementation PopinfoModel

@end

@implementation IndexModel

- (BOOL)isPushPicExisted:(NSString *)picname
{
    
    if ([NSString isBlankString:picname]) {
        return NO;
    }
    
    NSInteger countBootImage = self.bootimg.count;
    for (int i=0; i<countBootImage; i++) {
        NSString *strpicname = [((BootimgModel *)self.bootimg[i]) getPushPicName];
        if ([picname isEqualToString:strpicname]) {
            return YES;
        }
    }
    
    return NO;
    
}

- (void)removeInvalidData:(NSMutableArray *)dataArray {
    
    if (dataArray == nil || [dataArray count] == 0) {
        return;
    }
    
    NSMutableArray *toBeRemove = [[NSMutableArray alloc] init];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FocusPicModel *picModel = (FocusPicModel *)obj;
        
        if ([picModel isValid] == NO) {
            [toBeRemove addObject:picModel];
        }
    }];
    
    if ([toBeRemove count] > 0) {
        [dataArray removeObjectsInArray:toBeRemove];
    }
}

- (void)removeInvalidData {
    
    // 去除首页焦点图的非法数据
    if (self.focuspic != nil) {
        [self removeInvalidData:self.focuspic];
    }
    
    // 去除首页区块的非法数据
    if (self.block != nil) {
        [self.block enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BlockModel *blockModel = (BlockModel *)obj;
            
            if (blockModel != nil) {
                [self removeInvalidData:blockModel.video];
            }
        }];
    }
    
    // 去除内容推荐的非法数据
    if (self.recommend != nil) {
        [self removeInvalidData:self.recommend];
    }
}


@end
