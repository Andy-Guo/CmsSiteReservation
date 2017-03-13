//
//  LTDownItemModel.m
//  LeTVMobileDataModel
//
//  Created by dong on 15/12/22.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import "LTDownItemModel.h"
#import "LTRequestURLDefine.h"

@implementation LTDownItemModel

- (NSArray*)getDownItemModelArrayWithVideoList:(VideoListModel *)videoList withMovieDetail:(MovieDetailModel *)MovieDetail withVarityShowVideoList:(VarityShowVideoListModel *)varityShowInfo withStyle:(MovieShowStyle)movieShowStyle withRecommendModel:(NSArray *)RecommendArray subjectListType:(BOOL)subjectType
{
    __block NSMutableArray * regionItems = [[NSMutableArray alloc]init];
    NSInteger totalRegionCount = 0;
    if (videoList.videoInfo.count > 0 && !subjectType) {
        totalRegionCount = NUMBER_OF_ROW([videoList.totalNum integerValue], LT_VIDEOLIST_REQUEST_NUM);
        
        if (movieShowStyle == MovieShowWithDate) {
            totalRegionCount = varityShowInfo.arrayOrderedYears.count;
        }
    }else{
        totalRegionCount = 1;
    }
    
    @synchronized(self) {
        dispatch_queue_t queue = dispatch_queue_create([@"setter" UTF8String], NULL);
        @try {
            dispatch_apply(totalRegionCount, queue, ^(size_t index) {
                LTDownItemModel *item = [[LTDownItemModel alloc] init];
                item.movieDetail = MovieDetail;
                item.recommendPidName = nil;
                item.pic320_200 = nil;
                if (videoList.videoInfo.count > 0) {
                    if (movieShowStyle == MovieShowWithDate) {
                        item.pageIndex = index;
                        item.currPageIndex = varityShowInfo.indexForYearList;
                        item.year = OBJECT_OF_ATINDEX(varityShowInfo.arrayOrderedYears, index);
                        item.currentYear = varityShowInfo.currentYear;
                        item.regionName = [NSString safeString:[NSString stringWithFormat:@"%@%@",item.year,NSLocalizedString(@"年", nil)]];
                        item.style = movieShowStyle;
                        if (item.currPageIndex == item.pageIndex) {
                            item.videoList = varityShowInfo.videoListModel;
                        }
                    }else{
                        item.regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%lu",LT_VIDEOLIST_REQUEST_NUM*index +1,LT_VIDEOLIST_REQUEST_NUM*(index+1)]];
                        item.totalNum = [videoList.totalNum integerValue];
                        item.pageIndex = index;
                        item.style = movieShowStyle;
                        item.currPageIndex = [videoList.__pagenum integerValue] - 1;
                        if (item.currPageIndex < 0 ) {
                            item.currPageIndex = 0;
                        }
                        if (item.currPageIndex == item.pageIndex) {
                            item.videoList = videoList;
                        }
                    }
                    if (totalRegionCount - 1 == index) {
                        item.isLastItem = YES;
                        if (movieShowStyle != MovieShowWithDate) {
                            item.regionName = [NSString safeString:[NSString stringWithFormat:@"%lu-%@",LT_VIDEOLIST_REQUEST_NUM*index +1,videoList.totalNum]];
                        }
                    }
                }else{
                    item.regionName = @"1";
                    item.totalNum = [RecommendArray count];
                    item.pageIndex = index;
                    item.style = movieShowStyle;
                    item.currPageIndex = 0;
                    if (nil == self.itemsArray) {
                        self.itemsArray = (NSMutableArray<VideoModel, ConvertOnDemand> *)[NSMutableArray array];
                    }
                    for (int i =0; i<[RecommendArray count]; i++) {
                        RecommendItem * recomitem = [RecommendArray objectAtIndex:i];
                        VideoModel * video = [[VideoModel alloc]init];
                        if ([recomitem.pid isEqualToString:item.movieDetail.pid]) {
                            recomitem.pidname = item.movieDetail.nameCn;
                        }
                        [video convertToRecommendItem:recomitem];
                        item.recommendPidName = recomitem.pidname;
                        item.pic320_200 = @"";
                        [_itemsArray addObject:video];
                    }
                    item.videoList = videoList;
                    item.videoList.videoInfo = _itemsArray;
                    item.itemsArray = _itemsArray;
                }
                [regionItems addObject:item];
            });
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            ;
        }
        queue = nil;
    }
    return regionItems;
}

@end
