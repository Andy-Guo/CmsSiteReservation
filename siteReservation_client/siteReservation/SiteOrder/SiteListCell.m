//
//  SiteListCell.m
//  siteReservation
//
//  Created by Nigel Lee on 25/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import "SiteListCell.h"

@implementation SiteListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
