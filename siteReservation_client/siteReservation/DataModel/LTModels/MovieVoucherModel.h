//
//  MovieVoucherModel.h
//  LetvIphoneClient
//
//  Created by pdh on 14-2-8.
//
//

#import <Foundation/Foundation.h>
#import <LetvMobileOpensource/LetvMobileOpensource.h>

@interface MovieVoucherModel : JSONModel
@property (nonatomic, strong) NSString *code; //观影券是否正常
@property (nonatomic, strong) NSString *values; //详细数据
@property (nonatomic, strong) NSString *size;  //观影券个数
@end

@protocol MovieVoucherTicketShows @end
@interface MovieVoucherTicketShows : JSONModel
@property (nonatomic, strong) NSString<Optional> *endTime;      //观影券到期时间 1970.1.1开始的毫秒数
@property (nonatomic, strong) NSString<Optional> *pid;          //专辑id
@property (nonatomic, strong) NSString<Optional> *biginTime;    //观影券开始时间
@property (nonatomic, strong) NSString<Optional> *ticketName;   //观影券名称
@property (nonatomic, strong) NSString<Optional> *ticketCode;   //观影券id
@property (nonatomic, strong) NSString<Optional> *totalNumber;  //观影券张数
@property (nonatomic, strong) NSString<Optional> *ticketSource; //观影券来源
@property (nonatomic, strong) NSString<Optional> *usedNumber;   //观影券使用的张数
@property (nonatomic, strong) NSString<Optional> *isExpired;    //是否过期，过期为1 没过期为0

- (BOOL)expired;
@end

@interface ServletInfoModel : JSONModel
@property (nonatomic, strong) NSArray<Optional> *content;
@property (nonatomic, strong) NSString<Optional> *mobilePic;
@property (nonatomic, strong) NSString<Optional> *padPic;
@end
@interface MovieVoucherValue:JSONModel
@property (nonatomic, strong) NSArray<MovieVoucherTicketShows,ConvertOnDemand> *ticketShows;
@property (nonatomic, strong) NSString<Optional> *totalSize;


- (NSInteger)total;

@end
@interface MovieVoucherListModel : JSONModel
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) MovieVoucherValue<Optional> *values;
@property (nonatomic, strong) ServletInfoModel<Optional> *ServletInfo;

@end
