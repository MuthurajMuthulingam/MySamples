//
//  ImageDownloader.h
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageDownloaderDeleagte <NSObject>

- (void)downloadedImage:(UIImage *)downloadedImage;

@end

@interface ImageDownloader : NSOperation

@property (nonatomic,weak) id<ImageDownloaderDeleagte>delegate;

- (instancetype)initWithImageURLString:(NSString *)imageURLString;

@end
