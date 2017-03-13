//
//  LTSearchAlbumDataModel.h
//  LetvIphoneClient
//
//  Created by bob on 13-11-10.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/LTSearchDataModel.h>

/**
     用于明星页下搜索专辑数据的解析
 */

@interface LTSearchAlbumDataModel : JSONModel
@property (nonatomic, strong) NSArray<LTSearchAlbumData, Optional> *album_list;
@property (nonatomic, assign) NSString<Optional> *album_count;
@end

