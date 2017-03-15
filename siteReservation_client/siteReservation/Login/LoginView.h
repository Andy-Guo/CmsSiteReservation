//
//  LoginView.h
//  siteReservation
//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>
- (void)loginAction:(id)sender;
@end

@interface LoginView : UIView
@property (nonatomic, weak) id<LoginViewDelegate> delegate;
@end
