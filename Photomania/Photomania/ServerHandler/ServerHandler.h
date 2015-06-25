//
//  ServerHandler.h
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerHandler : NSObject

+ (id)getDataFromURL:(NSURL *)serverURL;

@end
