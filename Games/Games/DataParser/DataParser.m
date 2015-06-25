//
//  DataParser.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "DataParser.h"

@interface DataParser()

@property (nonatomic,strong) id rawData;

@end

@implementation DataParser

@synthesize delegate;


- (instancetype)initWithData:(id)data
{
    self = [super init];
    
    if (self)
    {
        self.rawData = data;
    }
    
    return self;
}

- (void)main
{
    [self parseCompleteResponseData:self.rawData];
}

- (void)parseCompleteResponseData:(id)rawData
{
    if ([rawData isKindOfClass:[NSArray class]]) // JSON Array
    {
    }
    else if ([rawData isKindOfClass:[NSDictionary class]]) // JSON Object
    {

        NSString *statusCode = [rawData objectForKey:@"responseStatus"];
        
        if ([statusCode doubleValue] == 200)
        {
            NSDictionary *responseData = [rawData objectForKey:@"responseData"];
            
            NSArray *dataArray = [responseData objectForKey:@"results"];
            
            [self.delegate parsedData:dataArray];
            
        }
    }
}

@end