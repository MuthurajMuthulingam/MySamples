//
//  ServerHandler.m
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ServerHandler.h"

@interface ServerHandler ()

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
    [self getDataFromURL:self.serverURl completionBlock:^(BOOL succeeded, NSData *data, NSError *error) {
        if (succeeded) {
               [self.delegate serverHandler:self finishedResponse:data];
        } else {
            [self.delegate serverHandler:self finishedResponse:nil];
        }
    }];
}

- (void)getDataFromURL:(NSURL *)serverURL completionBlock:(void(^)(BOOL succeeded,id data,NSError *error))completionBlock
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:serverURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
         completionBlock(YES,data,error);
        } else    {
            completionBlock(NO,nil,error);
        }
    } ];
    
    [dataTask resume];
}

@end
