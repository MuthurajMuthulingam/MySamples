//
//  DataParser.h
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataParserDelegte <NSObject>

- (void)parsedData:(NSArray *)dataArray;

@end

@interface DataParser : NSOperation

@property (nonatomic,weak) id<DataParserDelegte>delegate;

- (instancetype)initWithData:(id)data;
@end
