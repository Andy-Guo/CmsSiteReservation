//
//  LTTabListModel.m
//  LeTVMobileDataModel
//
//  Created by bob on 15/3/29.
//  Copyright (c) 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTTabListModel.h"



@implementation LTTabListModelElem

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    if (self = [super initWithDictionary:dict error:err]) {
    }
    return self;
}

-(void)setData:(NSDictionary<Optional> *)data
{
    if (_data != data) {
        _data = nil;
        _data = data;
    }
    [self setStyleValue];
    [self setTextLinkValue];
}

-(void)setStyleValue
{
    NSInteger value = [[self.data valueForKey:@"style"] integerValue];
    switch (value) {
        case 1:
            _movieShowStyle = MovieShowWithMatrix;
            break;
        case 2:
            _movieShowStyle = MovieShowWithTable;
            break;
        case 3:
            _movieShowStyle = MovieShowWithDate;
            break;

        default:
            _movieShowStyle = MovieShowWithUnknown;
            break;
    }
}

-(void)setTextLinkValue
{
    _textLinkData = [[BlockContent alloc]initWithDictionary:[self.data valueForKey:@"textLink"] error:nil];
}
@end

#if 0
@implementation AlbumInfoModel
@end
#endif

@implementation LTTabListModel
{
    LTSubjectDetailModel <Optional>* _subjectDetailModel;
    RecommendModel <Optional>* _recommendModel;
    VarityShowInfoModel  <Optional>* _varityShowInfoModel;
    VideoListModel <Optional>* _videoListModel;
}
-(void)setTabVideoList:(NSDictionary<Optional> *)tabVideoList
{
    if (_tabVideoList != tabVideoList) {
        _tabVideoList  = nil;
        _tabVideoList  = tabVideoList;
    }
    [self creatTabListModelElem];
}

-(void)setTabRelate:(NSDictionary<Optional> *)tabRelate
{
    if (_tabRelate != tabRelate) {
        _tabRelate = nil;
        _tabRelate = tabRelate;
    }
    [self creatTabListModelElem];
}

-(void)setTabZtList:(NSDictionary<Optional> *)tabZtList
{
    if (_tabZtList != tabZtList) {
        _tabZtList = nil;
        _tabZtList = tabZtList;
    }
    if (_tabZtList) {
        _subjectData = YES;
    }
}

//创建modelElem对象：剧集/相关数据
-(LTTabListModelElem*)creatTabListModelElem
{
    if (!_tabListModelElem) {
        if (![NSObject empty:self.tabVideoList]) {
            _tabListModelElem = [[LTTabListModelElem alloc]initWithDictionary:self.tabVideoList error:nil];
            if (![_tabListModelElem.isCurrent isEqualToString:@"1"]) {
                _tabListModelElem = nil;
            }
        }else if(![NSObject empty:self.tabRelate]){
            _tabListModelElem = [[LTTabListModelElem alloc]initWithDictionary:self.tabRelate error:nil];
            if (![_tabListModelElem.isCurrent isEqualToString:@"1"]) {
                _tabListModelElem = nil;
            }else{
                _recommendData = YES;
            }
        }

    }
    return _tabListModelElem;
}

-(VideoListModel*)getVideoListModel
{
    if (!_videoListModel) {
        LTTabListModelElem * tabListModelElem = self.tabListModelElem;
        if ([[NSString safeString:tabListModelElem.isCurrent] isEqualToString:@"1"]) {
            NSDictionary * dict = [tabListModelElem.data objectForKey:@"videoList"];
            _videoListModel = [[VideoListModel alloc]initWithDictionary:dict error:nil];
            
        }
    }
    return _videoListModel;
}

-(RecommendModel*)getRecommendModel
{
    if (!_recommendModel) {
        if (self.tabRelate && self.recommendData) {
            LTTabListModelElem * tabListModelElem = self.tabListModelElem;
            if ([[NSString safeString:tabListModelElem.isCurrent] isEqualToString:@"1"]) {
                NSDictionary * dict = [tabListModelElem.data objectForKey:@"videoList"];
                _recommendModel = [[RecommendModel alloc]initWithDictionary:dict error:nil];
                
            }
        }
    }
    return _recommendModel;
}

-(VarityShowInfoModel*)getVarityShowInfoModel
{
    if (!_varityShowInfoModel) {
        LTTabListModelElem * tabListModelElem = self.tabListModelElem;
        if ([[NSString safeString:tabListModelElem.isCurrent] isEqualToString:@"1"]) {
            NSDictionary * dict = [tabListModelElem.data objectForKey:@"videoList"];
            _varityShowInfoModel = [VarityShowInfoModel varityShowInfoModelWithDict:dict];
            
        }
    }
    return _varityShowInfoModel;
}

-(LTSubjectDetailModel*)getLTSubjectDetailModel
{
    if (!_subjectDetailModel) {
        if (self.tabZtList && self.subjectData) {
            NSError * error =nil;
            _subjectDetailModel = [[LTSubjectDetailModel alloc]initWithDictionary:self.tabZtList error:&error];
        }
    }
    return _subjectDetailModel;
}

-(MovieHalfScreenShowStyle)getHalfScreenShowStyle
{
    MovieHalfScreenShowStyle style = MovieHalfScreenShowStyleUnkown;
    
    if (self.subjectData) {
        if (_subjectDetailModel.subject.type == LTSubjectTypeAlbum) {
            style = MovieHalfScreenShowStyleThreeTab;
        }else{
            style = MovieHalfScreenShowStyleTwoTab;
        }
    }else{
        if (self.tabVideoList) {
            style = MovieHalfScreenShowStyleThreeTab;
        }else{
            style = MovieHalfScreenShowStyleTwoTab;
        }
        
    }
    return style;

}

-(NSArray*)getTabsTitle
{
    NSMutableArray * titles = [[NSMutableArray alloc]init];
    if (self.subjectData) {
        if (_subjectDetailModel.subject.type == LTSubjectTypeAlbum) {
#ifndef LT_IPAD_CLIENT
            [titles addObject:NSLocalizedString(@"简介", nil)];
#endif
#ifdef LT_IPAD_CLIENT
            [titles addObject:NSLocalizedString(@"专题列表", nil)];
#else
            [titles addObject:NSLocalizedString(@"乐视综合", nil)];
#endif
            if (self.tabListModelElem.movieShowStyle == MovieShowWithDate) {
                [titles addObject:NSLocalizedString(@"期数", @"期数")];
            }else{
                [titles addObject:NSLocalizedString(@"剧集", nil)];
            }
        }else{
#ifndef LT_IPAD_CLIENT
            [titles addObject:NSLocalizedString(@"简介", nil)];
#endif
            [titles addObject:NSLocalizedString(@"专题列表", nil)];
        }
    }else{
        
        NSString * str = NSLocalizedString(@"相关", @"相关");

        if (self.tabVideoList) {
            if (self.tabListModelElem.movieShowStyle == MovieShowWithDate) {
                [titles addObject:NSLocalizedString(@"期数", @"期数")];
            }else{
                if ([self.albumInfo.cid integerValue] == NewCID_Music) {
                    [titles addObject:NSLocalizedString(@"列表", @"列表")];
                }else{
                    [titles addObject:NSLocalizedString(@"剧集", nil)];
                }
            }
            //只在有剧集的时候处理会员的逻辑
#ifndef LT_IPAD_CLIENT
            if (self.albumInfo.pay) {
                str = NSLocalizedString(@"会员", nil);
            }
#endif
        }
#ifndef LT_IPAD_CLIENT
        [titles addObject:NSLocalizedString(@"详情 · 评论", @"详情 · 评论")];
#else
        [titles addObject:NSLocalizedString(@"评论", nil)];
#endif
        
        if (self.tabRelate) {
            [titles addObject:str];
        }

    }
    return titles;
}

- (NSString *)getFirstTabTitleName{
    NSString * title = NSLocalizedString(@"剧集", nil);
    
    if (self.subjectData) {
        if (_subjectDetailModel.subject.type == LTSubjectTypeAlbum) {
            if (self.tabListModelElem.movieShowStyle == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", @"期数");
            }else{
                title = NSLocalizedString(@"剧集", nil);
            }

        }else{
            title = NSLocalizedString(@"列表", @"列表");
        }
    }else{
        if (self.tabVideoList) {
            if (self.tabListModelElem.movieShowStyle == MovieShowWithDate) {
                title = NSLocalizedString(@"期数", @"期数");
            }else{
                if ([self.albumInfo.cid integerValue] == NewCID_Music) {
                    title = NSLocalizedString(@"列表", @"列表");
                }else{
                    title = NSLocalizedString(@"剧集", nil);
                }
            }
        }else if (self.tabRelate) {
            title = NSLocalizedString(@"相关", @"相关");
        }
    }

    return title;
}


-(MovieShowStyle)getMovieShowStyle
{
    return self.tabListModelElem.movieShowStyle;
}

-(BlockContent*)getTextLink{
    return self.tabListModelElem.textLinkData;
}

@end
