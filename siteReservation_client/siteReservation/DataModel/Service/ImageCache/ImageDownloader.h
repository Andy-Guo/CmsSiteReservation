//
//  ImageDownloader.h
//  LetvIpadClient
//
//  Created by 谷硕 on 10-12-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LetvMobileFoundation/LetvMobileFoundation.h>
//#import "Global.h"

@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSObject
{
	NSString *imageURLString;
	UIImageView *imageView;
	id <ImageDownloaderDelegate> __weak delegate;
	
	NSMutableData *activeDownload;
	NSURLConnection *imageConnection;
	BOOL indicator;
    BOOL _flagNotify;
    ImageType _imgType;
    NSOperationQueue *operationQueue;
}

@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id <ImageDownloaderDelegate> delegate;
@property (nonatomic, assign) BOOL indicator;
@property (nonatomic, assign) BOOL flagNotify;
@property (nonatomic, assign) ImageType imgType;


- (void)startDownload;
- (void)cancelDownload;

@end

//暂时没用
@protocol ImageDownloaderDelegate 

- (void)imageDidLoad:(NSIndexPath *)indexPath;

@end
