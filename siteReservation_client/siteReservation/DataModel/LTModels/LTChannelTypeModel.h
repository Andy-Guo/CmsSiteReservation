//
//  LTChannelTypeModel.h
//  LetvIphoneClient
//
//  Created by Ji Pengfei on 13-7-4.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>


@protocol SubCateModel @end
@interface SubCateModel : JSONModel
@property (strong, nonatomic) NSString *id;   //String 子分类id
@property (strong, nonatomic) NSString *name; //String 子分类名称
@end

@interface CateModel : JSONModel

@property (strong, nonatomic) NSString *name;                // String	分类名称
@property (strong, nonatomic) NSArray<SubCateModel,Optional> *sub;        // String 分类下的子分类
@end


@interface AreaModel : JSONModel

@property (strong, nonatomic) NSArray<SubCateModel,Optional> *sub;        // String 分类下的子分类
@end

@protocol OrderPropertyModel @end
@interface OrderPropertyModel : JSONModel

@property (strong, nonatomic) NSString *name;     //String 显示名称
@property (strong, nonatomic) NSString *shortname;  //String   显示短名称
@property (strong, nonatomic) NSString *id;     //String   排序值
@end

@interface OrderModel : JSONModel

@property (strong, nonatomic) NSArray<OrderPropertyModel,Optional> *album;  //专辑
@property (strong, nonatomic) NSArray<OrderPropertyModel,Optional> *vrsvideo;  //VRS视频
@property (strong, nonatomic) NSArray<OrderPropertyModel,Optional> *ptvvideo;  //PTV视频
@end


@interface VideoTypeModel : JSONModel

@property (strong, nonatomic) NSString *name;  //分类名称
@property (strong, nonatomic) NSArray<SubCateModel,Optional> *type;  //视频类型
@end

@interface YearTypeModel : JSONModel

@property (strong, nonatomic) NSArray<SubCateModel,Optional> *type;  //视频类型
@end


@interface LTChannelTypeModel : JSONModel

@property (strong, nonatomic) NSDictionary<Optional> *cate;
@property (strong, nonatomic) NSDictionary<Optional> *area;
@property (strong, nonatomic) NSDictionary<Optional> *order;
@property (strong, nonatomic) NSDictionary<Optional> *videotype;
@property (strong, nonatomic) NSDictionary<Optional> *year;

- (NSArray *)getCateArray:(NSString *)cid;
- (NSArray *)getYearArray:(NSString *)cid;
- (NSArray *)getAreaArray:(NSString *)cid;
- (NSArray *)getVideoTypeArray:(NSString *)cid;
- (NSArray *)resetSortArray:(NSString *)cid;
- (NSString*)getSortNameByIdx:(NSInteger)index Cid:(NSString *)cid;
- (NSString*)getSortIdByIdx:(NSInteger)index Cid:(NSString *)cid;
-(NSInteger)getSortCount:(NSString *)cid;

@end
