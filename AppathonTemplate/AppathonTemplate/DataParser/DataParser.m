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
        
        NSDictionary *statusDict = [rawData objectForKey:@"status"];
        
        NSString *message = [statusDict objectForKey:@"message"];
        
        if ([message isEqualToString:@"OK"])
        {
            NSDictionary *dataDict = [rawData objectForKey:@"data"];
            
            NSMutableArray *dictObjectArray = [[NSMutableArray alloc] init];
            
            for (NSString *key1 in [dataDict allKeys])
            {
                NSMutableDictionary *dictObj = [[NSMutableDictionary alloc] init];
                [dictObj addEntriesFromDictionary:[dataDict objectForKey:key1]];
                NSString *catagoryString = [self parseCatagoryString:[dataDict objectForKey:key1]];
                [dictObj setObject:catagoryString forKey:@"combinedCatagoryString"];
                
                //NSLog(@"single Dict Obj %@",dictObj);
                
                [dictObjectArray addObject:dictObj];
            }
            
            [self.delegate parsedData:dictObjectArray];
            
        }
    }
}


- (NSString *)parseCatagoryString:(NSDictionary *)catagoryDict
{
    NSArray *catagoryArray = [catagoryDict objectForKey:@"Categories"];
    
    NSMutableString *catagoryString = [[NSMutableString alloc] init];
    
    for (NSDictionary *singleObj in catagoryArray)
    {
        [catagoryString appendString:[singleObj objectForKey:@"Name"]];
        [catagoryString appendString:@","];
    }
    
    return catagoryString;
}


@end
