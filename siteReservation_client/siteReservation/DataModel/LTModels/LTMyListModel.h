//
//  LTMyListModel.h
//  LetvIphoneClient
//
//  Created by iosdev on 14-7-30.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol LTListDisplayModel @end

@interface LTListDisplayModel : JSONModel

@property (strong, nonatomic) NSString<Optional>* display;  //是否显示 1:显示;0:不显示
@property (strong, nonatomic) NSString<Optional>* name;     //标题
@property (strong, nonatomic) NSString<Optional>* pic;      //图片
@property (strong, nonatomic) NSString<Optional>* sort;     //序号
@property (strong, nonatomic) NSString<Optional>* subname;  //子标题
@property (strong, nonatomic) NSString<Optional>* type;     //类型 1:播放记录;2:我的收藏;3:我的下载;4:开通会员;5:我的积分;6:邀请有奖;7:提交邀请人;8:联通流量套餐
@end

@interface LTMyListModel : JSONModel

@property(nonatomic, strong) NSArray<LTListDisplayModel,Optional> *block1;
@property(nonatomic, strong) NSArray<LTListDisplayModel,Optional> *block2;
@property(nonatomic, strong) NSArray<LTListDisplayModel,Optional> *block3;

@end

@protocol LTMyListModel @end

@interface LTMyListModelArray : JSONModel

@property(nonatomic, strong) LTMyListModel<Optional> *profile;

@end

@interface LTMyListModelArray_ipad : JSONModel
@property(nonatomic,strong) NSArray <LTListDisplayModel,Optional> *profile;
@end
