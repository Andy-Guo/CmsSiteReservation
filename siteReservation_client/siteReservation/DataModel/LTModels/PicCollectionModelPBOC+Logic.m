//
//  PicCollectionModelPBOC+Logic.m
//  LeTVMobileDataModel
//
//  Created by jeason on 16/3/9.
//  Copyright © 2016年 Kerberos Zhang. All rights reserved.
//

#import "PicCollectionModelPBOC+Logic.h"

@implementation PicCollectionModelPBOC(Logic)
- (NSString *)getImage320_200 {
    NSString *imageUrl = @"";
    
    if (![NSString empty:self.pic320_200]) {
        imageUrl = self.pic320_200;
    }
    else if (![NSString empty:self.pic200_150]) {
        imageUrl = self.pic200_150;
    }
    else if (![NSString empty:self.pic120_90]) {
        imageUrl = self.pic120_90;
    }
    else if (![NSString empty:self.pic150_200]) {
        imageUrl = self.pic150_200;
    }
    else if (![NSString empty:self.pic400_300]) {
        imageUrl = self.pic400_300;
    }
    else if (![NSString empty:self.pic300_300]) {
        imageUrl = self.pic300_300;
    }
    
    return imageUrl;
}


- (NSString *)getMinSizeImage{
    NSString *imageUrl = @"";
    
    if (![NSString empty:self.pic120_90]) {
        imageUrl = self.pic120_90;
    }
    else if (![NSString empty:self.pic200_150]) {
        imageUrl = self.pic200_150;
    }else  if (![NSString empty:self.pic150_200]) {
        imageUrl = self.pic150_200;
    }
    else if (![NSString empty:self.pic320_200]) {
        imageUrl = self.pic320_200;
    }
    else  if (![NSString empty:self.pic300_300]) {
        imageUrl = self.pic300_300;
    } else if (![NSString empty:self.pic400_300]) {
        imageUrl = self.pic400_300;
    }
    
    return imageUrl;
}

- (NSString *)getMaxSizeImage{
    NSString *imageUrl = @"";
    if (![NSString empty:self.pic400_300]) {
        imageUrl = self.pic400_300;
    }
    else if (![NSString empty:self.pic300_300])  {
        imageUrl = self.pic300_300;
    }else if (![NSString empty:self.pic320_200]) {
        imageUrl = self.pic320_200;
    }
    else if (![NSString empty:self.pic150_200]) {
        imageUrl = self.pic150_200;
    }
    else if (![NSString empty:self.pic200_150])  {
        imageUrl = self.pic200_150;
    } else if (![NSString empty:self.pic120_90]) {
        imageUrl = self.pic120_90;
    }
    return imageUrl;
}

- (id) initWithCoder: (NSCoder*) aDecoder
{
    self = [super init];
    if (self != nil) {
        self.pic1024_387 = [aDecoder decodeObjectForKey: @"pic1024_387"];
        self.pic800_407 = [aDecoder decodeObjectForKey: @"pic800_407"];
        self.pic214_161 = [aDecoder decodeObjectForKey: @"pic214_161"];
        self.pic120_90 = [aDecoder decodeObjectForKey: @"pic120_90"];
        self.pic150_200 = [aDecoder decodeObjectForKey: @"pic150_200"];
        self.pic200_150 = [aDecoder decodeObjectForKey: @"pic200_150"];
        self.pic400_300 = [aDecoder decodeObjectForKey: @"pic400_300"];
        self.pic300_300 = [aDecoder decodeObjectForKey: @"pic300_300"];
        self.pic320_200 = [aDecoder decodeObjectForKey: @"pic320_200"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder*) aCoder
{
    [aCoder encodeObject: self.pic1024_387 forKey: @"pic1024_387"];
    [aCoder encodeObject: self.pic800_407 forKey: @"pic800_407"];
    [aCoder encodeObject: self.pic214_161 forKey: @"pic214_161"];
    [aCoder encodeObject: self.pic120_90 forKey: @"pic120_90"];
    [aCoder encodeObject: self.pic150_200 forKey: @"pic150_200"];
    [aCoder encodeObject: self.pic200_150 forKey: @"pic200_150"];
    [aCoder encodeObject: self.pic400_300 forKey: @"pic400_300"];
    [aCoder encodeObject: self.pic300_300 forKey: @"pic300_300"];
    [aCoder encodeObject: self.pic320_200 forKey: @"pic320_200"];
}
@end
