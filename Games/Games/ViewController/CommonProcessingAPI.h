//
//  CommonProcessingAPI.h
//  Games
//
//  Created by Muthuraj M on 5/6/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommonProcessingAPI;

@protocol CommonAPIDelegate <NSObject>

- (void)commonProcessingAPI:(CommonProcessingAPI *)commonProcessingAPI processedDataArray:(NSArray *)dataArray;

@end


@interface CommonProcessingAPI : NSObject

@property (nonatomic,weak) id <CommonAPIDelegate> delegate;

- (void)performGenericProcessingWithURL:(NSURL *)serverURL;

@end
