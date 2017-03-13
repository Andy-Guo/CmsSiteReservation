//
//  ProductListModelPBOC+Function.m
//  LeTVMobileDataModel
//
//  Created by dullgrass on 16/7/26.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "ProductListModelPBOC+Function.h"
@implementation ProductInfoModelPBOC (Function)
@end
@implementation ProductListModelPBOC (Function)

- (NSArray *)getProductIdentifierArr
{
    NSMutableArray *allProductId = [[NSMutableArray alloc] initWithCapacity:9];
    //移动会员
    for (ProductInfoModelPBOC *productInfo in self.vip) {
        [allProductId addObject:productInfo.productid];
    }
    
    //全屏会员
    for (ProductInfoModelPBOC *productInfo in self.svip) {
        [allProductId addObject:productInfo.productid];
    }
    
    //直播
    for (ProductInfoModelPBOC *productInfo in self.live) {
        [allProductId addObject:productInfo.productid];
    }
    return allProductId;
}

- (NSArray *)getAllProducts
{
    NSMutableArray *allProducts = [[NSMutableArray alloc] initWithCapacity:9];
    [allProducts removeAllObjects];
    [allProducts addObjectsFromArray:self.vip];
    [allProducts addObjectsFromArray:self.svip];
    [allProducts addObjectsFromArray:self.live];
    return allProducts;
}

- (ProductInfoModelPBOC *)getProductInfoByProductId:(NSString *)productId
{
    ProductInfoModelPBOC *productInfo = nil;
    //移动会员
    for (ProductInfoModelPBOC *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    //全屏会员
    for (ProductInfoModelPBOC *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    //直播
    for (ProductInfoModelPBOC *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    return productInfo;
}

- (NSInteger)getProductCount
{
    NSInteger count = 0;
    count = self.vip.count + self.svip.count +self.live.count;
    return count;
}

- (NSInteger)countOfProduct:(ProductType)type
{
    switch (type) {
        case LetvVip:
            return self.vip.count;
            break;
        case LetvSVip:
            return self.svip.count;
            break;
        case LetvLive:
            return self.live.count;
            break;
        default:
            break;
    }
    return 0;
}

- (void)removeProductByProductInfo:(ProductInfoModelPBOC *)productInfo
{
    [self.vip removeObject:productInfo];
    [self.svip removeObject:productInfo];
    [self.live removeObject:productInfo];
}

- (NSInteger)getProductInfoIndexWithProductId:(NSString *)productId
{
    //移动会员
    for (ProductInfoModelPBOC *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.vip indexOfObject:productInfoTemp];
        }
    }
    //全屏会员
    for (ProductInfoModelPBOC *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.svip indexOfObject:productInfoTemp];
        }
    }
    //直播
    for (ProductInfoModelPBOC *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.live indexOfObject:productInfoTemp];
        }
    }
    return -1;
}

/**
 *  根据productid获取商品类型
 *
 *  @param productId
 *
 *  @return
 */
- (ProductType)getProductTypeWithProductId:(NSString *)productId{
    //移动会员
    for (ProductInfoModelPBOC *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvVip;
        }
    }
    //全屏会员
    for (ProductInfoModelPBOC *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvSVip;
        }
    }
    //直播
    for (ProductInfoModelPBOC *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvLive;
        }
    }
    return LetvVip;
}
@end
