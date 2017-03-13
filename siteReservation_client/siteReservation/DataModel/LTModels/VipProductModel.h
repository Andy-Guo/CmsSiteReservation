//
//  VipProductModel.h
//  LetvIpadClient
//
//  Created by Ji Pengfei on 13-7-18.
//
//



@protocol  ProductInfoModel @end
@interface ProductInfoModel : JSONModel<NSCoding>
@property(copy, nonatomic)NSString <Optional>*name;
@property(copy, nonatomic)NSString <Optional>*productid;
@property(copy, nonatomic)NSString <Optional>*expire;  //几个月
@property(copy, nonatomic)NSString <Optional>*pid;
@property(copy, nonatomic)NSString <Optional>*mobileImg; //图片
@property(copy, nonatomic)NSString <Optional>*vipDesc;  //描述
@property(copy, nonatomic)NSString <Optional>*price;//带有货币符号价格，用于显示
@property(copy, nonatomic)NSString <Optional>*validatePrice;//float价格，用于后台验证
@property(strong, nonatomic)NSLocale <Optional>*priceLocale;//价格本地化


@end
@protocol  LeBProductInfoModel @end
@interface LeBProductInfoModel : JSONModel<NSCoding>

@property(nonatomic, readwrite, strong)   NSString  <Optional>*busiId;                   //商户号
@property(nonatomic, readwrite, strong)   NSString  <Optional>*lbPayNum;                 //购买乐币数
@property(nonatomic, readwrite, strong)   NSString  <Optional>*lbPrice;                  //乐币包价格
@property(nonatomic, readwrite, strong)   NSString  <Optional>*lbGiveNum;                //赠送乐币数
@property(nonatomic, readwrite, strong)   NSString  <Optional>*packageTerminal;          //所属终端
@property(nonatomic, readwrite, strong)   NSString  <Optional>*packageId;                //主包id
@property(nonatomic, readwrite, strong)   NSString  <Optional>*packageDetailId;          //子包id
@property(nonatomic, readwrite, strong)   NSString  <Optional>*expandId;                 //拓展包id
@property(nonatomic, readwrite, strong)   NSString  <Optional>*packageName;              //名称
@property(nonatomic, readwrite, strong)   NSString  <Optional>*packageDesc;              //描述
@property(nonatomic, readwrite, strong)   NSString  <Optional>*thumbnailsUrl;            //图片URL
@property(nonatomic, readwrite, strong)   NSString  <Optional>*hdDoc;                    //活动文案
@property(nonatomic, readwrite, strong)   NSString  <Optional>*price;                     //乐币包价格
@property(nonatomic, readwrite, strong)   NSLocale  <Optional>*priceLocale;    //价格本地化

@end

@class ProductInfoModel;
@class LeBProductInfoModel;
@interface ProductListModel : JSONModel<NSCoding>
@property (strong, nonatomic) NSMutableArray<ProductInfoModel,Optional> *vip;
@property (strong, nonatomic) NSMutableArray<ProductInfoModel,Optional> *svip;
@property (strong, nonatomic) NSMutableArray<ProductInfoModel,Optional> *live;
@property (strong, nonatomic) NSMutableArray<LeBProductInfoModel,Optional> *leb;

@property (copy, nonatomic) NSString<Optional> *share_secret;
@property (readonly, nonatomic, getter=getProductIdentifierArr) NSArray<Ignore> *allProductId;
@property (readonly, nonatomic, getter=getAllProducts) NSArray<Ignore> *allProducts;

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
- (ProductInfoModel *)getProductInfoByProductId:(NSString *)productId;

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
- (void)removeProductByProductInfo:(ProductInfoModel *)productInfo;

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
