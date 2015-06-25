//
//  ServerHandler.h
//  ChatAppUI
//
//  Created by Muthuraj M on 6/13/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ServerHandler;

@protocol ServerHandlerDelegate <NSObject>

- (void)serverHandler:(ServerHandler *)serverHandler finishedResponse:(NSData *)rawData;

@end

@interface ServerHandler : NSOperation

@property (nonatomic,weak) id<ServerHandlerDelegate>delegate;

- (instancetype)initWithURL:(NSURL *)serverURL;

@end
