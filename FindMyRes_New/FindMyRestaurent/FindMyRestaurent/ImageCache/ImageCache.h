//
//  ImageCache.h
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCache : NSObject

+ (ImageCache *)getSharedInstance;
- (void)setImageForKey:(NSString *)imageURlKey andImage:(UIImage *)image;
- (UIImage *)getImageForkey:(NSString *)imageURLKey;

@end
