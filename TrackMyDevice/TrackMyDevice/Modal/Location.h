//
//  Location.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Journey;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitiude;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Journey *journey;

@end
