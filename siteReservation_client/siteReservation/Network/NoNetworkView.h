//
//  NoNetworkView.h
//  siteReservation
//
//  Created by Nigel Lee on 01/03/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoNetworkViewDelegate <NSObject>
@end

@interface NoNetworkView : UIView

@property (nonatomic, weak) id<NoNetworkViewDelegate> delgate;
@property(nonatomic,strong)UILabel *lblTop;//一级提示信息
@property(nonatomic,strong)UILabel *lblSub;//二级提示信息
@property(nonatomic,strong)UIImageView *iconView;//图标
@property(nonatomic,assign)BOOL isServerWrong;

@end
