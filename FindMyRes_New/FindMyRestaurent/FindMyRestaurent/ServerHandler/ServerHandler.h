//
//  ServerHandler.h
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol serverHandlerDelegate <NSObject>

- (void)finishedResponse:(id)rawData;

@end


@interface ServerHandler : NSOperation

@property (nonatomic,weak) id<serverHandlerDelegate>delegate;

- (instancetype)initWithURL:(NSURL *)serverURL;

@end
