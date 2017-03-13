//
//  AtListModel.h
//  LetvIpadClient
//
//  Created by zhaochunyan on 13-7-2.
//
//


#import <LetvMobileOpensource/LetvMobileOpensource.h>


#ifndef LT_IPAD_CLIENT

@protocol AtListModel

@end

@interface AtWebModel : JSONModel

@property (strong, nonatomic) NSString *url;            // Url   跳出页面的地址

@end

@interface AtSubjectModel : JSONModel

@property (strong, nonatomic) NSString *specialId;      //  string	跳到客户端内专题的id

@end

@interface AtWebInnerModel : JSONModel

@property (strong, nonatomic) NSString *url;            //  string	跳到WebView地址

@end

@interface AtLivingModel : JSONModel

@property (strong, nonatomic) NSString *url_low;        // string	350码流直播地址
@property (strong, nonatomic) NSString *url_high;       // string	高清直播地址

@end

@interface AtTvLivingModel : JSONModel

@property (strong, nonatomic) NSString *url_low;        // string	350码流直播地址
@property (strong, nonatomic) NSString *url_high;       // string	高清直播地址
@property (strong, nonatomic) NSString *tv_code;        // string	电视台代码

@end

@interface AtListModel : JSONModel

@property (strong, nonatomic) AtWebModel<Optional> *atWeb;              // at_3	与at结合使用：at是3的扩展属性
@property (strong, nonatomic) AtSubjectModel<Optional> *atSubject;      // at_4	与at结合使用：at是4的扩展属性
@property (strong, nonatomic) AtWebInnerModel<Optional> *atWebInner;    // at_5	与at结合使用：at是5的扩展属性
@property (strong, nonatomic) AtLivingModel<Optional> *atLiving;        // at_6	与at结合使用：at是6的扩展属性
@property (strong, nonatomic) AtTvLivingModel<Optional> *atTvLiving;    // at_8	与at结合使用：at是8的扩展属性

@end

#else

@protocol AtListModel

@end

@interface AtWebModel : JSONModel

@property (strong, nonatomic) NSString *url;            // Url   跳出页面的地址

@end

@interface AtSubjectModel : JSONModel

@property (strong, nonatomic) NSString *specialId;      //  string	跳到客户端内专题的id

@end

@interface AtWebInnerModel : JSONModel

@property (strong, nonatomic) NSString *url;            //  string	跳到WebView地址

@end

@interface AtLivingModel : JSONModel

@property (strong, nonatomic) NSString *url_low;        // string	350码流直播地址
@property (strong, nonatomic) NSString *url_high;       // string	高清直播地址
@property (strong, nonatomic) NSString *tm;
@property (strong, nonatomic) NSString *streamCode;
@end

@interface AtTvLivingModel : JSONModel

@property (strong, nonatomic) NSString *url_low;        // string	350码流直播地址
@property (strong, nonatomic) NSString *url_high;       // string	高清直播地址
@property (strong, nonatomic) NSString *tv_code;        // string	电视台代码

@end

@interface AtListModel : JSONModel

@property (strong, nonatomic) AtWebModel<Optional> *atWeb;              // at_3	与at结合使用：at是3的扩展属性
@property (strong, nonatomic) AtSubjectModel<Optional> *atSubject;      // at_4	与at结合使用：at是4的扩展属性
@property (strong, nonatomic) AtWebInnerModel<Optional> *atWebInner;    // at_5	与at结合使用：at是5的扩展属性
@property (strong, nonatomic) AtLivingModel<Optional> *atLiving;        // at_6	与at结合使用：at是6的扩展属性
@property (strong, nonatomic) AtTvLivingModel<Optional> *atTvLiving;    // at_8	与at结合使用：at是8的扩展属性

@end

#endif

