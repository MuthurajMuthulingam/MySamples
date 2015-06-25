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

- (void)storeImageToLocal:(UIImage *)image andImageName:(NSString *)imageName;
- (UIImage *)retriveImageWithName:(NSString *)imageName;

@end
