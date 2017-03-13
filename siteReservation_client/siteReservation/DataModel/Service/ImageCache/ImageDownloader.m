//
//  ImageDownloader.m
//  LetvIpadClient
//
//  Created by 谷硕 on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "ImageCacheManager.h"
#import "LTDataModelEngine.h"
//#import "NSObject+ObjectEmpty.h"


@implementation ImageDownloader

@synthesize imageURLString;
@synthesize imageView;
@synthesize delegate;
@synthesize indicator;
@synthesize flagNotify = _flagNotify;
@synthesize imgType = _imgType;

#pragma mark

- (void)startDownload
{
    if (    self.imageView
        &&  self.indicator) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.tag = 8080;
        indicatorView.frame = CGRectMake(0, 0, LTSystemLoadingSize, LTSystemLoadingSize);
        [self.imageView addSubview:indicatorView];	
        indicatorView.center = CGPointMake(self.imageView.center.x - self.imageView.frame.origin.x,
                                           self.imageView.center.y - self.imageView.frame.origin.y);
        [indicatorView startAnimating];
    }
	
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLString]];
     operationQueue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL bResult = NO;
            if (![NSObject empty:data]) {
                // 写入缓存
                bResult = [ImageCacheManager setImageData:data
                                             ForUrlString:self.imageURLString
                                                 withType:self.imgType];
                
                UIImage *image = [[UIImage alloc] initWithData:data];
                
                if (self.imageView) {
                    self.imageView.image = image;
                }
                
                if (self.indicator) {
                    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.imageView viewWithTag:8080];
                    [indicatorView stopAnimating];
                    [indicatorView removeFromSuperview];
                }
                
                // call our delegate and tell it that our icon is ready for display
                [delegate imageDidLoad:nil];
                [ImageCacheManager removeDownloader:self];
            }
            
            // 发通知
            if (self.flagNotify) {
                [ImageCacheManager postImageDidLoadNotification:self.imageURLString
                                                   andImageType:self.imgType
                                                  andLoadResult:bResult];
            }
        });
        
    }];
}

- (void)cancelDownload
{
    [operationQueue cancelAllOperations];
  
}


@end