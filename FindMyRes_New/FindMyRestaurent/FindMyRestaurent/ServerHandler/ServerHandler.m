//
//  ServerHandler.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ServerHandler.h"
#import "AsynchronousImageDownloader.h"

@interface ServerHandler()

@property (nonatomic,strong) NSURL *serverURl;

@end

@implementation ServerHandler
@synthesize delegate;

- (instancetype)initWithURL:(NSURL *)serverURL
{
    self = [super init];
    self.serverURl = serverURL;
    return self;
}

- (void)main
{
    [self getDataFromURL:self.serverURl completionBlock:^(BOOL succeeded, id data, NSError *error) {
        if (succeeded)
        {
            [self.delegate finishedResponse:data];
            //[self parseCompleteResponseData:data];
        }
        else
        {
            [self.delegate finishedResponse:nil];
        }
    }];
}

- (void)getDataFromURL:(NSURL *)serverURL completionBlock:(void(^)(BOOL succeeded,id data,NSError *error))completionBlock
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:serverURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            completionBlock(YES,[NSJSONSerialization JSONObjectWithData:data options:0 error:nil],error);
        }
        else
        {
            completionBlock(NO,nil,error);
        }
    } ];
    
    [dataTask resume];
}


@end
