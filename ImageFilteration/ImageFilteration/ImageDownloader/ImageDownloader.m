//
//  ImageDownloader.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader()

@property (nonatomic,strong) NSString *imageURLString;


@end

@implementation ImageDownloader

- (instancetype)initWithImageURLString:(NSString *)imageURLString
{
    self = [super init];
    
    if (self)
    {
        self.imageURLString = imageURLString;
        
    }
    
    return self;
}

- (void)main
{
    [self checkImageAvailablityOrDownload];
}

- (void)checkImageAvailablityOrDownload
{
    [self loadImageFromURL:self.imageURLString completionBlock:^(BOOL succeeded, UIImage *image, NSString *urlString)
    {
        if (succeeded)
        {
            [self.delegate downloadedImage:image];
        }
    }];
}

- (void)loadImageFromURL:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image,NSString *urlString))completionBlock
{
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDownloadTask *Imagetask = [session downloadTaskWithURL:url completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error)
                                               {
                                                   if (!error)
                                                   {
                                                           UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                           completionBlock(YES,downloadedImage,urlString);
                                                     }
                                                   else
                                                   {
                                                              completionBlock(NO,nil,urlString);
                                                       
                                                   }
                                                   
                                               }];
        
        [Imagetask resume];
        
}


@end
