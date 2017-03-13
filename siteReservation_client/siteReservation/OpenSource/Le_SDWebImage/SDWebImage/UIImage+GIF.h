#ifndef _LT_FIX_DUPLICATED_IMPORT_UIIMAGE_PLUS_GIF_H_ 
#define _LT_FIX_DUPLICATED_IMPORT_UIIMAGE_PLUS_GIF_H_
//
//  UIImage+GIF.h
//  LBGIFImage
//
//  Created by Laurin Brandner on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSData+GIF.h"
#import <UIKit/UIKit.h>

@interface UIImage (GIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end

#endif /* _LT_FIX_DUPLICATED_IMPORT_UIIMAGE_PLUS_GIF_H_ */
