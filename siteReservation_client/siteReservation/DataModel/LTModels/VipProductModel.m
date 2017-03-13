//
//  VipProductModel.m
//  LetvIpadClient
//
//  Created by Ji Pengfei on 13-7-18.
//
//
#import "VipProductModel.h"
#ifdef LT_IPAD_CLIENT

@implementation ProductInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.productid forKey:@"productid"];
    [aCoder encodeObject:self.expire forKey:@"expire"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.mobileImg forKey:@"mobileImg"];
    [aCoder encodeObject:self.vipDesc forKey:@"vipDesc"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.validatePrice forKey:@"validatePrice"];
    [aCoder encodeObject:self.priceLocale forKey:@"priceLocale"];

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil)
    {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.productid = [aDecoder decodeObjectForKey:@"productid"];
        self.expire = [aDecoder decodeObjectForKey:@"expire"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
        self.mobileImg = [aDecoder decodeObjectForKey:@"mobileImg"];
        self.vipDesc = [aDecoder decodeObjectForKey:@"vipDesc"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.validatePrice = [aDecoder decodeObjectForKey:@"validatePrice"];
        self.priceLocale = [aDecoder decodeObjectForKey:@"priceLocale"];

    }
    return self;
}
@end

@interface ProductListModel ()

@end

@implementation ProductListModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.vip forKey:@"vip"];
    [aCoder encodeObject:self.svip forKey:@"svip"];
    [aCoder encodeObject:self.live forKey:@"live"];
    [aCoder encodeObject:self.share_secret forKey:@"share_secret"];

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil)
    {

        self.vip = [aDecoder decodeObjectForKey:@"vip"];
        self.svip = [aDecoder decodeObjectForKey:@"svip"];
        self.live = [aDecoder decodeObjectForKey:@"live"];
        self.share_secret = [aDecoder decodeObjectForKey:@"share_secret"];
    }
    return self;
}

/**
 *  productId数组
 *
 *  @return
 */
- (NSArray *)getProductIdentifierArr
{
    NSMutableArray *allProductId;
    
    if (!allProductId) {
        allProductId = [[NSMutableArray alloc] initWithCapacity:9];
    }
    [allProductId removeAllObjects];
    
    //移动会员
    for (ProductInfoModel *productInfo in self.vip) {
        [allProductId addObject:productInfo.productid];
        
    }
    
    //全屏会员
    for (ProductInfoModel *productInfo in self.svip) {
        [allProductId addObject:productInfo.productid];
        
    }
    
    //直播
    for (ProductInfoModel *productInfo in self.live) {
        [allProductId addObject:productInfo.productid];
        
    }
    
    return allProductId;
    
}

/**
 *  productId数组
 *
 *  @return
 */
- (NSArray *)getAllProducts{
    NSMutableArray *allProducts;
    if (!allProducts) {
        allProducts = [[NSMutableArray alloc] initWithCapacity:9];
    }
    [allProducts removeAllObjects];
    [allProducts addObjectsFromArray:self.vip];
    [allProducts addObjectsFromArray:self.svip];
    [allProducts addObjectsFromArray:self.live];
    return allProducts;
}


/**
 *  根据productId获取商品信息
 *
 *  @param productId 商品id
 *
 *  @return 商品信息
 */
- (ProductInfoModel *)getProductInfoByProductId:(NSString *)productId{
    ProductInfoModel *productInfo = nil;
    //移动会员
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    return productInfo;
}

/**
 *  商品数量
 *
 *  @return 商品数量
 */
- (NSInteger)getProductCount{
    NSInteger count = 0;
    count = self.vip.count + self.svip.count +self.live.count;
    return count;
}

/**
 *  返回对应商品数量
 *
 *  @param type
 *
 *  @return
 */
- (NSInteger)countOfProduct:(ProductType)type{
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

/**
 *  移除指定product
 *
 *  @param
 */
- (void)removeProductByProductInfo:(ProductInfoModel *)productInfo{
    [self.vip removeObject:productInfo];
    [self.svip removeObject:productInfo];
    [self.live removeObject:productInfo];
}
/**
 *  根据productid获取商品index
 *
 *  @param productId
 *
 *  @return
 */
- (NSInteger)getProductInfoIndexWithProductId:(NSString *)productId{
    //移动会员
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.vip indexOfObject:productInfoTemp];
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.svip indexOfObject:productInfoTemp];
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
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
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvVip;
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvSVip;
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvLive;
        }
    }
    return LetvVip;
}
@end
#else


@implementation ProductInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.productid forKey:@"productid"];
    [aCoder encodeObject:self.expire forKey:@"expire"];
    [aCoder encodeObject:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.mobileImg forKey:@"mobileImg"];
    [aCoder encodeObject:self.vipDesc forKey:@"vipDesc"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.validatePrice forKey:@"validatePrice"];
    [aCoder encodeObject:self.priceLocale forKey:@"priceLocale"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil)
    {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.productid = [aDecoder decodeObjectForKey:@"productid"];
        self.expire = [aDecoder decodeObjectForKey:@"expire"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
        self.mobileImg = [aDecoder decodeObjectForKey:@"mobileImg"];
        self.vipDesc = [aDecoder decodeObjectForKey:@"vipDesc"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.validatePrice = [aDecoder decodeObjectForKey:@"validatePrice"];
        self.priceLocale = [aDecoder decodeObjectForKey:@"priceLocale"];
        
    }
    return self;
}
@end

@implementation LeBProductInfoModel

@end

@interface ProductListModel ()
{
    NSMutableArray *_allProductId;
    NSMutableArray *_allProducts;
}
@end

@implementation ProductListModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.vip forKey:@"vip"];
    [aCoder encodeObject:self.svip forKey:@"svip"];
    [aCoder encodeObject:self.live forKey:@"live"];
    [aCoder encodeObject:self.leb forKey:@"leb"];
    [aCoder encodeObject:self.share_secret forKey:@"share_secret"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self != nil)
    {
        
        self.vip = [aDecoder decodeObjectForKey:@"vip"];
        self.svip = [aDecoder decodeObjectForKey:@"svip"];
        self.live = [aDecoder decodeObjectForKey:@"live"];
        self.leb = [aDecoder decodeObjectForKey:@"leb"];
        self.share_secret = [aDecoder decodeObjectForKey:@"share_secret"];
    }
    return self;
}

/**
 *  productId数组
 *
 *  @return
 */
- (NSArray *)getProductIdentifierArr{
    
    if (!_allProductId) {
        _allProductId = [[NSMutableArray alloc] initWithCapacity:9];
    }
    [_allProductId removeAllObjects];
    
    //移动会员
    for (ProductInfoModel *productInfo in self.vip) {
        [_allProductId addObject:productInfo.productid];
        
    }
    
    //全屏会员
    for (ProductInfoModel *productInfo in self.svip) {
        [_allProductId addObject:productInfo.productid];
        
    }
    
    //直播
    for (ProductInfoModel *productInfo in self.live) {
        [_allProductId addObject:productInfo.productid];
        
    }
    
    for (LeBProductInfoModel *productInfo in self.leb) {
        [_allProductId addObject:productInfo.expandId];
        
    }
    
    return _allProductId;
    
}

/**
 *  productId数组
 *
 *  @return
 */
- (NSArray *)getAllProducts{
    
    if (!_allProducts) {
        _allProducts = [[NSMutableArray alloc] initWithCapacity:9];
    }
    [_allProducts removeAllObjects];
    [_allProducts addObjectsFromArray:self.vip];
    [_allProducts addObjectsFromArray:self.svip];
    [_allProducts addObjectsFromArray:self.live];
    [_allProducts addObjectsFromArray:self.leb];
    return _allProducts;
}


/**
 *  根据productId获取商品信息
 *
 *  @param productId 商品id
 *
 *  @return 商品信息
 */
- (ProductInfoModel *)getProductInfoByProductId:(NSString *)productId{
    ProductInfoModel *productInfo = nil;
    //移动会员
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    
    //道具
    for (LeBProductInfoModel *productInfoTemp in self.leb) {
        if ([productInfoTemp.expandId isEqualToString:productId]) {
            productInfo = productInfoTemp;
            return productInfo;
        }
    }
    return productInfo;
}

/**
 *  商品数量
 *
 *  @return 商品数量
 */
- (NSInteger)getProductCount{
    NSInteger count = 0;
    count = self.vip.count + self.svip.count +self.live.count + self.leb.count;
    return count;
}

/**
 *  返回对应商品数量
 *
 *  @param type
 *
 *  @return
 */
- (NSInteger)countOfProduct:(ProductType)type{
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
        case LetvProp:
            return self.leb.count;
        default:
            break;
    }
    return 0;
}

/**
 *  移除指定product
 *
 *  @param
 */
- (void)removeProductByProductInfo:(ProductInfoModel *)productInfo{
    [self.vip removeObject:productInfo];
    [self.svip removeObject:productInfo];
    [self.live removeObject:productInfo];
    [self.leb removeObject:productInfo];
}
/**
 *  根据productid获取商品index
 *
 *  @param productId
 *
 *  @return
 */
- (NSInteger)getProductInfoIndexWithProductId:(NSString *)productId{
    //移动会员
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.vip indexOfObject:productInfoTemp];
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.svip indexOfObject:productInfoTemp];
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return [self.live indexOfObject:productInfoTemp];
        }
    }
    
    //道具
    for (LeBProductInfoModel *productInfoTemp in self.leb) {
        if ([productInfoTemp.expandId isEqualToString:productId]) {
            return [self.leb indexOfObject:productInfoTemp];
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
    for (ProductInfoModel *productInfoTemp in self.vip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvVip;
        }
    }
    
    //全屏会员
    for (ProductInfoModel *productInfoTemp in self.svip) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvSVip;
        }
    }
    
    //直播
    for (ProductInfoModel *productInfoTemp in self.live) {
        if ([productInfoTemp.productid isEqualToString:productId]) {
            return LetvLive;
        }
    }
    
    //道具
    for (LeBProductInfoModel *productInfoTemp in self.leb) {
        if ([productInfoTemp.expandId isEqualToString:productId]) {
            return LetvProp;
        }
    }
    return LetvVip;
}
@end
#endif
