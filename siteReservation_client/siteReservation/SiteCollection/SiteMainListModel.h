//
//  SiteMainListModel.h
//  siteReservation
//
//  Created by Nigel Lee on 13/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "JSONModel.h"

@protocol SiteDataModel <NSObject>
@end

@protocol SiteMainListModel <NSObject>
@end

@interface SiteDataModel : JSONModel
@property (nonatomic, strong) NSMutableArray <SiteMainListModel, Optional> *data;
@property (nonatomic, strong) NSString<Optional> *title;
@property (assign, nonatomic) id type;                     // 场地类型
@end

@interface SiteMainListModel : JSONModel
@property (strong, nonatomic) NSString<Optional> *site_name;
@property (strong, nonatomic) NSString<Optional> *site_pic;
@property (strong, nonatomic) NSMutableArray<SiteDataModel, Optional> *channel;
@property (assign, nonatomic) id type;                     // 场地类型
- (NSString *)getPicStringSelected:(BOOL)selected;
@end

