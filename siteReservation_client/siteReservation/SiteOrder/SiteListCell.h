//
//  SiteListCell.h
//  siteReservation
//
//  Created by Nigel Lee on 25/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteListCell : UITableViewCell
@property (nonatomic, assign) BOOL isOrederd;
@property (nonatomic, strong) UILabel *timeSlot;
@property (nonatomic, strong) UIImageView *siteStatus;

@end
