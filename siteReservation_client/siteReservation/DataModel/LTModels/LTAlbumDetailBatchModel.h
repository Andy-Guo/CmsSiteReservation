//
//  LTAlbumDetailBatchModel.h
//  LetvIpadClient
//
//  Created by bob on 14-9-16.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>
#import <LetvMobileDataModel/MovieDetailModel.h>


@interface LTAlbumDetailBatchModel : JSONModel

@property (nonatomic, strong) NSArray<MovieDetailModel, Optional> *data;

- (NSString *)getIDs;

@end
