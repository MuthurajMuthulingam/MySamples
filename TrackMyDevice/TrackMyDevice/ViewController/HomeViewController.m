//
//  HomeViewController.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "HomeViewController.h"
#import "MathController.h"
#import "Journey.h"
#import "Location.h"
#import "AppDelegate.h"
#import "HomeView.h"
#import "JourneyTableViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface HomeViewController ()<HomeViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) Journey *journey;

@property (nonatomic,strong) HomeView *initialView;

@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.initialView = [[HomeView alloc] init];
    self.initialView.delegate = self;
    [self.view addSubview:self.initialView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"New Journey";
    
    self.managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.initialView updateViewWithData:nil];
    
}

- (void)startLocationUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    
    if(IS_OS_8_OR_LATER)
    {
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)eachSecond
{
    self.seconds++;
    
    [self.initialView updateViewWithData:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [MathController stringifySecondCount:self.seconds usingLongFormat:NO],@"time",
                                         [MathController stringifyDistance:self.distance],@"distance",
    [MathController stringifySpeedFromDist:self.distance overTime:self.seconds],@"speed", nil]];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.initialView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
}


#pragma Location delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"Locations %@",locations);
    
    
    for (CLLocation *newLocation in locations)
    {
        if (newLocation.horizontalAccuracy < 20)
        {
           
            // update distance
            if (self.locations.count > 0)
            {
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
            }
            
            [self.locations addObject:newLocation];
        }
    }
}

- (void)startClecked
{
    self.seconds = 0;
    self.distance = 0;
    self.locations = [NSMutableArray array];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self
                                                selector:@selector(eachSecond) userInfo:nil repeats:YES];
    [self startLocationUpdates];
}

- (void)stopClicked
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self
                                                    cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save", @"Discard", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)saveJourney
{
    Journey *newJourney = [NSEntityDescription insertNewObjectForEntityForName:@"Journey"
                                                inManagedObjectContext:self.managedObjectContext];
    
    newJourney.distance = [NSNumber numberWithFloat:self.distance];
    newJourney.duration = [NSNumber numberWithInt:self.seconds];
    newJourney.timestamp = [NSDate date];
    
    NSMutableArray *locationArray = [NSMutableArray array];
    for (CLLocation *location in self.locations)
    {
        Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                 inManagedObjectContext:self.managedObjectContext];
        
        locationObject.timestamp = location.timestamp;
        locationObject.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationObject.longitiude = [NSNumber numberWithDouble:location.coordinate.longitude];
        [locationArray addObject:locationObject];
    }
    
    newJourney.location = [NSOrderedSet orderedSetWithArray:locationArray];
    self.journey = newJourney;
    
    // Save the context.
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // save
    if (buttonIndex == 0)
    {
        [self saveJourney];
        [self.timer invalidate];
        [self.locationManager stopUpdatingLocation];
        
        JourneyTableViewController *detailVC = [[JourneyTableViewController alloc] init];
        [self navigateToViewController:detailVC];
        
    } else if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
