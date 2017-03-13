//
//  LT_FindBaseModel.h
//  LeTVMobileDataModel
//
//  Created by 王同龙 on 1/19/15.
//  Copyright (c) 2015 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpenSource/LetvMobileOpenSource.h>

@protocol   LT_findColumsDataDatail @end
@interface LT_findColumsDataDataily : JSONModel
@property (nonatomic, strong) NSString<Optional> *type;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSString<Optional> *pic;
@property (nonatomic, strong) NSString<Optional> *cmsid;
@property (nonatomic, strong) NSString<Optional> *webViewUrl;
@property (nonatomic, strong) NSString<Optional> *nameCn;
@property (nonatomic, strong) NSString<Optional> *subTitle;
@property (nonatomic, strong) NSString<Optional> *at;
@property (nonatomic, strong) NSString<Optional> *mobilePic;
@property (nonatomic, strong) NSString<Optional> *padPic;
@property (nonatomic, strong) NSArray <Optional> *showTagList;
@property (nonatomic, strong) NSString<Optional> *is_rec;
@property (nonatomic, strong) NSString<Optional> *extends_extendRange;
@property (nonatomic, strong) NSString<Optional> *extends_extendCid;
@property (nonatomic, strong) NSString<Optional> *extends_extendPid;
@property (nonatomic, strong) NSString<Optional> *startTime;
@property (nonatomic, strong) NSString<Optional> *endTime;
@end

@protocol LT_findColumsDataArray @end
@interface LT_findColumsDataArray : JSONModel
 @property (nonatomic, strong) NSString<Optional> *name;
 @property (nonatomic, strong) NSString<Optional> *type;
 @property (nonatomic, strong) NSArray <Optional> *dataDetails;
 @property (nonatomic, strong) NSString<Optional> *mobilePic;
 @property (nonatomic, strong) NSString<Optional> *title;
 @property (nonatomic, strong) NSString<Optional> *url;
 @property (nonatomic, strong) NSString<Optional> *pic;
 @property (nonatomic, strong) NSString<Optional> *subTitle;
@end


@protocol  LT_findColumsData   @end
@interface LT_findColumsData : JSONModel
  @property (nonatomic, strong) NSString<Optional> *name;  // 区块名
  @property (nonatomic, strong) NSArray <Optional,LT_findColumsDataArray> *dataBlocks;
  @property (strong, nonatomic) NSString<Optional> *area;  // 区块ID
  @property (nonatomic, strong) NSString<Optional> *mtime; // 时间戳
  @property (nonatomic,strong) NSString<Optional> *redPointValue;
@end


@interface LT_FindBaseModel : JSONModel
@property (nonatomic,  strong) NSArray<Optional> *datas;
@end

@interface LT_ActiveTimeModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *date;
@property (nonatomic, strong) NSString<Optional> *week_day;
@end
