//
//  LocationSorter.h
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/21/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationSorterDelegate <NSObject>

- (void)sortedListOfLocations:(NSDictionary *)unSortedDictObjects andSortedKeys:(NSArray *)sortedKey;

@end

@interface LocationSorter : NSOperation

- (instancetype)initWithCurrentLocation:(CLLocation *)location andCompleteDataArray:(NSArray *)completeDataArray;

@property (nonatomic,weak) id<LocationSorterDelegate>deleagte;

@end
