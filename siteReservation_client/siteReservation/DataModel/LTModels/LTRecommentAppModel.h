//
//  LTRecommentAppModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-8-26.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTRecommentAppInfo@end
@interface LTRecommentAppInfo : JSONModel
@property (strong, nonatomic) NSString<Optional >*desc;
@property (strong, nonatomic) NSString<Optional >*icon;
@property (strong, nonatomic) NSString<Optional >*name;
@property (strong, nonatomic) NSString<Optional >*url;
@property (strong, nonatomic) NSString<Optional > *exchid;
@property (strong, nonatomic) NSString<Optional > *icon_big;
@property (strong, nonatomic) NSString<Optional > *app_name;

@end


@protocol LTExchangeModel@end
@interface LTExchangeModel : JSONModel
@property (strong, nonatomic)NSArray<LTRecommentAppInfo, Optional>* data;  //应用列表
@property (strong, nonatomic)NSString<Optional>* exchid;  //当前栏目id
@property (strong, nonatomic)NSString<Optional>* total;  //总记录数
@end



@interface LTRecommentAppModel : JSONModel
@property (strong, nonatomic) LTExchangeModel<Optional>* exchange;
@property (strong, nonatomic) NSArray<LTRecommentAppInfo, Optional>* exchangechannel;
@property (strong, nonatomic) NSArray<LTRecommentAppInfo, Optional>* exchangefocus;

@end
