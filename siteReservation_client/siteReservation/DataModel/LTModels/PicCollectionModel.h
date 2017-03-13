//
//  PicCollectionModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

@protocol PicCollectionModel @end

@interface PicCollectionModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *pic1024_387;      // 1024*387	string	1024*387,pad使用
@property (strong, nonatomic) NSString<Optional> *pic800_407;       // 800*407	string	800*407,phone使用
@property (strong, nonatomic) NSString<Optional> *pic214_161;       // 214*161	string	尺寸为214*161的图片
@property (strong, nonatomic) NSString<Optional> *pic120_90;        // 120*90	string	尺寸为120*90的图片
@property (strong, nonatomic) NSString<Optional> *pic150_200;       // 150*200	string	尺寸为120*90的图片

@property (strong, nonatomic) NSString<Optional> *pic200_150;       // 200*150	string	尺寸为200*1500的图片
@property (strong, nonatomic) NSString<Optional> *pic400_300;       // 400*300	string	尺寸为400*300的图片
@property (strong, nonatomic) NSString<Optional> *pic300_300;
@property (strong, nonatomic) NSString<Optional> *pic300_400;
@property (strong, nonatomic) NSString<Optional> *pic320_200;
@property (strong, nonatomic) NSString<Optional> *pic169;

- (NSString *)getImage320_200;
- (NSString *)getMinSizeImage;
- (NSString *)getMaxSizeImage;

@end
