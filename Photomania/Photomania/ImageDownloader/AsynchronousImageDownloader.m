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
        NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:20.0];
        
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError)
            {
                UIImage *image = [UIImage imageWithData:data];
                [self.cachedImageDict setObject:image forKey:urlString];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completionBlock (YES,image,urlString);
                    
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completionBlock (NO,nil,urlString);
                    
                });
            }
        }];
    }
}

@end
