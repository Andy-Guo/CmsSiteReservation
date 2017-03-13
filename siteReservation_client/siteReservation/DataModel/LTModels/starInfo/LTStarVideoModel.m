//
//  LTStarVideoModel.m
//  LeTVMobileDataModel
//
//  Created by 韩阳 on 15/9/1.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTStarVideoModel.h"
@implementation LTStarBaseModel
{
    @public
    LTStarModelCardType  _modelType;
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
@implementation LTStarImageModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"400*300":@"pic300",
                                                       @"400*250":@"pic250",
                                                       @"400*225":@"pic225"}];
}
@end
@implementation LTStarVideoModel

@end
@implementation LTStarSubListVideoModel
- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelVideoListCardType;
}
@end
@implementation LTStarSubListAlbumModel
- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelAlbumListCardType;
}
@end
@implementation LTStarSubListRingModel

- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelRingListCardType;
}
@end
@implementation LTStarSubListStarIdModel

-(void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelStarIDCardType;
}

@end
@implementation LTStarSubListMusicModel

- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelMusicCardType;
}

@end
@implementation LTStarInfoHeaderModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"tDescription"}];
}

@end

@implementation LTStarVideoListModel


@end
@implementation LTStarBigShotModel
- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelBigShotCardType;
}
@end
@implementation LTStarFansModel

@end
@implementation LTStarLiveListModel
- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelLiveListCardType;
}
@end
@implementation LTStarActivityModel
- (void)setSequence:(NSString<Optional> *)sequence{
    _sequence = sequence;
    _modelType = LTStarModelActivityCardType;
}
@end
