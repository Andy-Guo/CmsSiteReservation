//
//  SiteListCell.m
//  siteReservation
//
//  Created by Nigel Lee on 25/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteListCell.h"
#import "Global.h"

@implementation SiteListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = COMMON_COLOUR;
        self.selectionStyle = UITableViewCellSeparatorStyleSingleLine;
        
        self.isOrederd = NO;
        
        [self.contentView addSubview:self.timeSlot]; //必须要写成self.timeSlot, 如果写成_timeSlot将不会执行重写的方法
        [self.contentView addSubview:self.siteStatus];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self setBackgroundColor:RGBACOLOR(0, 0, 0, 0.08)];
    }
}

#pragma mark-- Properties
- (UILabel *)timeSlot
{
    if (!_timeSlot) {
        _timeSlot = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height/2, 120, 30)];
        _timeSlot.textAlignment = NSTextAlignmentCenter;
        _timeSlot.textColor = [UIColor blackColor];
        _timeSlot.font = [UIFont systemFontOfSize:16.f];
        _timeSlot.backgroundColor = COMMON_COLOUR;
        _timeSlot.numberOfLines = 1;
    }
    return _timeSlot;
}

- (UIImageView *)siteStatus
{
    if (!_siteStatus) {
        _siteStatus = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 40, 0, 30, 50)];
        NSString *name = (!self.isOrederd) ? @"leso_history_icon" : @"leso_video_vip";
        _siteStatus.image = [UIImage imageNamed:name];//仅作测试用
        _siteStatus.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _siteStatus;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
