//
//  SiteOrderHeaderView.m
//  siteReservation
//
//  Created by Nigel Lee on 25/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteOrderHeaderView.h"
#import "SiteListCell.h"

#define HEADERVIEW_HEIGHT  (45)

@interface SiteOrderHeaderView()
@property (nonatomic, strong) UIButton *yesterday;
@property (nonatomic, strong) UIButton *today;
@property (nonatomic, strong) UIButton *tomorrow;
@end

@implementation SiteOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _yesterday = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width/ 4, HEADERVIEW_HEIGHT)];
        [_yesterday setBackgroundColor:RGBACOLOR(0,0,255,1)];
        [_yesterday setTitle:@"前一天" forState:UIControlStateNormal];
        [_yesterday setTitleColor:RGBACOLOR(255,255,255,1) forState:UIControlStateNormal];
        [_yesterday setTitleColor:RGBACOLOR(204,204,204,1) forState:UIControlStateHighlighted];
        [_yesterday.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        _yesterday.layer.cornerRadius = 0;
        _yesterday.clipsToBounds = YES;
        [_yesterday addTarget:self action:@selector(showAnotherDay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_yesterday];
        
        _today = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width / 4, 0, __MainScreen_Width/ 2, HEADERVIEW_HEIGHT)];
        [_today setBackgroundColor:RGBACOLOR(228,33,18,1)];
        [_today setTitle:@"今天" forState:UIControlStateNormal];
        _today.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_today setTitleColor:RGBACOLOR(255,255,255,1) forState:UIControlStateNormal];
        [_today setTitleColor:RGBACOLOR(204,204,204,1) forState:UIControlStateHighlighted];
        [_today.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        _today.layer.cornerRadius = 0;
        _today.clipsToBounds = YES;
        [_today addTarget:self action:@selector(showCalendar) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_today];

        _tomorrow = [[UIButton alloc] initWithFrame:CGRectMake(self.today.frame.origin.x + self.today.frame.size.width, 0, __MainScreen_Width/ 4, HEADERVIEW_HEIGHT)];
        [_tomorrow setBackgroundColor:RGBACOLOR(0,255,0,1)];
        [_tomorrow setTitle:@"后一天" forState:UIControlStateNormal];
        [_tomorrow setTitleColor:RGBACOLOR(255,255,255,1) forState:UIControlStateNormal];
        [_tomorrow setTitleColor:RGBACOLOR(204,204,204,1) forState:UIControlStateHighlighted];
        [_tomorrow.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        _tomorrow.layer.cornerRadius = 0;
        _tomorrow.clipsToBounds = YES;
        [_tomorrow addTarget:self action:@selector(showAnotherDay:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tomorrow];
        
    }
    return self;
}

- (void)showAnotherDay:(NSString *)title
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showAnotherDay:)]) {
        [self.delegate showAnotherDay:title];
    }
}

- (void)showCalendar
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showCalendar)]) {
        [self.delegate showCalendar];
    }
}


@end
