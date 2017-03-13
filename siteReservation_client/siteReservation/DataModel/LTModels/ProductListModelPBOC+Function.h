//
//  ProductListModelPBOC+Function.h
//  LeTVMobileDataModel
//
//  Created by dullgrass on 16/7/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <LetvMobileProtobuf/LetvMobileProtobuf.h>
@interface ProductInfoModelPBOC (Function)
@end

@interface ProductListModelPBOC (Function)

/**
 *  获取所有product
 *
 *  @return
 */
- (NSArray *)getAllProducts;

/**
 *  productId数组
 *
 *  @return
 */
- (NSArray *)getProductIdentifierArr;

/**
 *  根据productId获取商品信息
 *
 *  @param productId 商品id
 *
 *  @return 商品信息
 */
- (ProductInfoModelPBOC *)getProductInfoByProductId:(NSString *)productId;

/**
 *  商品总数量
 *
 *  @return 商品总数量
 */
- (NSInteger)getProductCount;

/**
 *  返回对应商品数量
 *
 *  @param type
 *
 *  @return
 */
- (NSInteger)countOfProduct:(ProductType)type;

/**
 *  移除指定product
 *
 *  @param
 */
- (void)removeProductByProductInfo:(ProductInfoModelPBOC *)productInfo;

/**
 *  根据productid获取商品index
 *
 *  @param productId
 *
 *  @return
 */
- (NSInteger)getProductInfoIndexWithProductId:(NSString *)productId;

/**
 *  根据productid获取商品类型
 *
 *  @param productId
 *
 *  @return
 */
- (ProductType)getProductTypeWithProductId:(NSString *)productId;

@end
