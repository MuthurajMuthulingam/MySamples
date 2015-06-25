//
//  DataParser.h
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataParser;

@protocol DataParserDelagate <NSObject>

- (void)dataParser:(DataParser *)dataParser finishedResponse:(NSArray *)jsonDataArray;

@end

@interface DataParser : NSOperation

- (instancetype)initWithData:(NSData *)jsonData;

@property (nonatomic,weak) id<DataParserDelagate>delegate;

@end
