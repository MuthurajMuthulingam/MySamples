//
//  CommonProcessingAPI.m
//  Games
//
//  Created by Muthuraj M on 5/6/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "CommonProcessingAPI.h"
#import "ServerHandler.h"
#import "DataParser.h"

@interface CommonProcessingAPI ()<serverHandlerDelegate,DataParserDelegte>

@end

@implementation CommonProcessingAPI

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)performGenericProcessingWithURL:(NSURL *)serverURL
{
    ServerHandler *serverHandler = [[ServerHandler alloc] initWithURL:serverURL];
    serverHandler.delegate = self;
    [serverHandler start];
}

- (void)finishedResponse:(id)rawData
{
    DataParser *dataParser = [[DataParser alloc] initWithData:rawData];
    dataParser.delegate = self;
    [dataParser start];
}

- (void)parsedData:(NSArray *)dataArray
{
    [self.delegate commonProcessingAPI:self processedDataArray:dataArray];
}


@end
