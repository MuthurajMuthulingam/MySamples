//
//  DataParser.m
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "DataParser.h"

@interface DataParser ()

@property (nonatomic,strong) NSData *jsonData;

@end

@implementation DataParser

- (instancetype)initWithData:(NSData *)jsonData {
    
    self = [super init];
    if (self) {
        self.jsonData = jsonData;
    }
    
    return self;
}

- (void)main {
    
    [self processIncomingData:self.jsonData];
}

- (void)processIncomingData:(NSData *)jsonData {
    id serialisedData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    NSLog(@"Data %@",serialisedData)
    ;
    if ([serialisedData isKindOfClass:[NSArray class]]) { // is JSON Array
        
        [self.delegate dataParser:self finishedResponse:serialisedData];
        
    } else { // is JSON Object
        
    }
}

@end
