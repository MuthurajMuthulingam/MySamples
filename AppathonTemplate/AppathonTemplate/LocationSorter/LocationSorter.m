//
//  LocationSorter.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/21/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "LocationSorter.h"

@interface LocationSorter()

@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,strong) NSArray *completeDataArray;

@end

@implementation LocationSorter
@synthesize deleagte;

- (instancetype)initWithCurrentLocation:(CLLocation *)location andCompleteDataArray:(NSArray *)completeDataArray
{
    self = [super init];
    
    if (self)
    {
        self.currentLocation = location;
        self.completeDataArray = [NSArray arrayWithArray:completeDataArray];
    }
    
    return self;
}

- (void)main
{
    [self sortLocations];
}

- (void)sortLocations
{
    NSMutableDictionary *unSortedDataDict = [[NSMutableDictionary alloc] init];
    
    for (NSMutableDictionary *singleDataObj in self.completeDataArray)
    {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[singleDataObj objectForKey:@"Latitude"] doubleValue] longitude:[[singleDataObj objectForKey:@"Longitude"] doubleValue]];
        CLLocationDistance distance = [self.currentLocation distanceFromLocation:location];
        
        [singleDataObj setValue:[NSNumber numberWithDouble:distance] forKey:@"calculatedDistance"];
        [unSortedDataDict setObject:singleDataObj forKey:[NSNumber numberWithDouble:distance]];
        
    }
    
    NSArray *sortedArray = [self sortedKeys:[unSortedDataDict allKeys]];
    [self.deleagte sortedListOfLocations:unSortedDataDict andSortedKeys:sortedArray];
}

- (NSArray *)sortedKeys:(NSArray *)unsortedKeys
{
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    
    return [unsortedKeys sortedArrayUsingDescriptors:@[sortDesc]];
}

@end
