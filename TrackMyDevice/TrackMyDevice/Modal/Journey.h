//
//  Journey.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Journey : NSManagedObject

@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSOrderedSet *location;
@end

@interface Journey (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inLocationAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLocationAtIndex:(NSUInteger)idx;
- (void)insertLocation:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLocationAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLocationAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceLocationAtIndexes:(NSIndexSet *)indexes withLocation:(NSArray *)values;
- (void)addLocationObject:(NSManagedObject *)value;
- (void)removeLocationObject:(NSManagedObject *)value;
- (void)addLocation:(NSOrderedSet *)values;
- (void)removeLocation:(NSOrderedSet *)values;
@end
