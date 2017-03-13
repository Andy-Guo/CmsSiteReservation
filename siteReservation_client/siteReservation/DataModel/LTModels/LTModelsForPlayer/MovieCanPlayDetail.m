//
//  MovieCanPlayDetail.m
//  LetvIphoneClient
//
//  Created by pdh on 14-2-8.
//
//

#import "MovieCanPlayDetail.h"
@implementation App

@end


@implementation app
@end


@implementation MovieCanPlayDetail


- (MoviePayTicketType)moviePayTicketType{
    if ([self.ticketType isEqualToString:@"0"]) {
        return LT_TicketType_Vip;
    }
    
    if ([self.ticketType isEqualToString:@"1"]) {
        return LT_TicketType_General;
    }
    
    if ([NSString isBlankString:self.ticketType]) {
        return LT_TicketType_NotVip;
    }

    return LT_TicketType_NotVip;
    
}
@end
