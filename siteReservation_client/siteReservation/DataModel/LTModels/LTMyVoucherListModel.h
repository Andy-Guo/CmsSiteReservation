//
//  LTMyVoucherListModel.h
//  LeTVMobileDataModel
//
//  Created by Speed on 15/11/6.
//  Copyright © 2015年 Kerberos Zhang. All rights reserved.
//

#import <LetvMobileOpensource/LetvMobileOpensource.h>

/*
 *http://wiki.letv.cn/pages/viewpage.action?pageId=50506395 卡券接口，及返回数据说明
 */

@protocol LTMyVoucherModel  @end
@interface LTMyVoucherModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *cancelTime;
@property (nonatomic,strong) NSString<Optional> *currentNum;
@property (nonatomic,strong) NSString<Optional> *desc;
@property (nonatomic,strong) NSString<Optional> *from;
@property (nonatomic,strong) NSString<Optional> *voucherId;
@property (nonatomic,strong) NSString<Optional> *name;
@property (nonatomic,strong) NSString<Optional> *subType;
@property (nonatomic,strong) NSString<Optional> *totalNum;
@property (nonatomic,strong) NSString<Optional> *type;

@property (nonatomic,strong) NSString<Optional> *modelFunction;

- (void) updateDateFormatter;

@end


@protocol LTMyVoucherListValuesModel @end
@interface LTMyVoucherListValuesModel : JSONModel

@property (nonatomic,strong) NSArray<LTMyVoucherModel,Optional> *list;

@end


@interface LTMyVoucherListModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *code;
@property (nonatomic,strong) LTMyVoucherListValuesModel<Optional> *values;

@end
