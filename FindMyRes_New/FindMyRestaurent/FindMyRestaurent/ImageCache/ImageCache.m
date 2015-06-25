//
//  ImageCache.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *sharedInstance;

@interface ImageCache()

@property (nonatomic,strong) NSMutableDictionary *cachedImageDict;

@end

@implementation ImageCache

+ (ImageCache *)getSharedInstance
{
    if (!sharedInstance)
    {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.cachedImageDict = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}

- (void)setImageForKey:(NSString *)imageURlKey andImage:(UIImage *)image
{
    [self.cachedImageDict setValue:image forKey:imageURlKey];
    
}

- (UIImage *)getImageForkey:(NSString *)imageURLKey
{
    return [self.cachedImageDict objectForKey:imageURLKey];
}

@end
