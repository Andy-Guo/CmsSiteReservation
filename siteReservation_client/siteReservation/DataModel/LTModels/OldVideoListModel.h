//
//  OldVideoListModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-3.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol OldVideoListModel @end

@interface OldVideoListModel : JSONModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString<Optional> *releasedate;
@property (strong, nonatomic) NSString<Optional> *videotype;
@property (strong, nonatomic) NSString<Optional> *vid;
@property (strong, nonatomic) NSString<Optional> *mmsid;
@property (strong, nonatomic) NSString<Optional> *brList;
@property (strong, nonatomic) NSString<Optional> *allownDownload;
@property (strong, nonatomic) NSString<Optional> *btime;
@property (strong, nonatomic) NSString<Optional> *etime;
@property (strong, nonatomic) NSString<Optional> *duration;
@property (strong, nonatomic) NSString<Optional> *icon;
@property (strong, nonatomic) NSString<Optional> *pay;  
@end
