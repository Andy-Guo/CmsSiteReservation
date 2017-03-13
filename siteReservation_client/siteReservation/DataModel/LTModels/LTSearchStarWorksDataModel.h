//
//  LTSearchStarWorksDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-8.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTSearchDataModel.h>

/**
    用于进入明星资料页返回数据的解析 
 */

// 明星作品的分类
@protocol LTSearchStarWorksCategory @end
@interface LTSearchStarWorksCategory : JSONModel
@property (nonatomic, strong) NSString<Optional> *category;
@property (nonatomic, strong) NSString<Optional> *category_name;
@property (nonatomic, strong) NSString<Optional> *count;
@property (nonatomic, strong) NSString<Optional> *dataType;
@end


// 明星作品信息，包括明星作品分类及热门作品
@interface LTSearchStarWorksDataModel : JSONModel

// 作品分类
@property (nonatomic, strong) NSArray<LTSearchStarWorksCategory, Optional> *category_count_list;
// 热门作品
@property (nonatomic, strong) NSArray<LTSearchAlbumData, Optional> *album_list;

@end
