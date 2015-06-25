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

    }
    return self;
}

- (void)storeImageToLocal:(UIImage *)image andImageName:(NSString *)imageName
{
    if (image)
    {
       NSData *pngData = UIImagePNGRepresentation(image);
       NSString *filePath = [self documentsPathForFileName:imageName];
      [pngData writeToFile:filePath atomically:YES]; //Write the file
    }
    
}

- (UIImage *)retriveImageWithName:(NSString *)imageName
{
    NSString *filePath = [self documentsPathForFileName:imageName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    
    if (image)
    {
        return image;
    }
    
    return nil;
}

- (NSString *)documentsPathForFileName:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:imageName];
}

@end
