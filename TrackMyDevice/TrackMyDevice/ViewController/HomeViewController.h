//
//  HomeViewController.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate,UIActionSheetDelegate>

@property int seconds;
@property float distance;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end
