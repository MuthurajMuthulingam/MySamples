//
//  ServerHandler.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ServerHandler.h"
#import "AsynchronousImageDownloader.h"

@implementation ServerHandler

+ (id)getDataFromURL:(NSURL *)serverURL
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:25.0];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *jsonError = nil;
    
    NSLog(@"JSON Data %@",[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError]);
    
    return [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
}

@end
