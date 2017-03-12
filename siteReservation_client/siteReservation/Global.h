//
//  Global.h
//  siteReservation
//
//  Created by Nigel Lee on 19/02/2017.
//  Copyright © 2017 Apress. All rights reserved.
//

#ifndef Global_h
#define Global_h


#endif /* Global_h */

//设备屏幕大小
#define __MainScreenFrame   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define __MainScreen_Width  ((__MainScreenFrame.size.width)<(__MainScreenFrame.size.height)?(__MainScreenFrame.size.width):(__MainScreenFrame.size.height))
#define __MainScreen_Height ((__MainScreenFrame.size.height)>(__MainScreenFrame.size.width)?(__MainScreenFrame.size.height):(__MainScreenFrame.size.width))

//不同设备的屏幕大小
#define iPhone4 (CGSizeEqualToSize(CGSizeMake(320, 480), CGSizeMake(__MainScreen_Width, __MainScreen_Height)))
#define iPhone5 (CGSizeEqualToSize(CGSizeMake(320, 568), CGSizeMake(__MainScreen_Width, __MainScreen_Height)))
#define iPhone6 (CGSizeEqualToSize(CGSizeMake(375, 667), CGSizeMake(__MainScreen_Width, __MainScreen_Height)))
#define iPhone6plus (CGSizeEqualToSize(CGSizeMake(414, 736), CGSizeMake(__MainScreen_Width, __MainScreen_Height)))
