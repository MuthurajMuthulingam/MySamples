//
//  AsynchronousImageDownloader.m
//  KE
//
//  Created by Muthuraj M on 11/5/14.
//
//

#import "AsynchronousImageDownloader.h"


static AsynchronousImageDownloader *sharedInstance;

@interface AsynchronousImageDownloader()

@property (nonatomic,retain) NSMutableDictionary *cachedImageDict;

@end

@implementation AsynchronousImageDownloader


+ (AsynchronousImageDownloader *)sharedInstance
{
    if (!sharedInstance)
    {
        sharedInstance = [[AsynchronousImageDownloader alloc] init];
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

- (void)loadImageFromURL:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, UIImage *image,NSString *urlString))completionBlock
{

    if ([self.cachedImageDict objectForKey:urlString])
    {
        UIImage *image = [self.cachedImageDict objectForKey:urlString];
        completionBlock (YES,image,urlString);
    }
    else
    {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDownloadTask *Imagetask = [session downloadTaskWithURL:url completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error)
        {
            if (!error)
            {
               dispatch_async(dispatch_get_main_queue(), ^{
                   UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                   [self.cachedImageDict setValue:downloadedImage forKey:urlString];
                   completionBlock(YES,downloadedImage,urlString);
               });
               }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(NO,nil,urlString);
                });

            }
        
        }];
        
        [Imagetask resume];
        
    }
}

@end
