//
//  ViewController.m
//  MapDirection
//
//  Created by Muthuraj M on 1/5/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "ViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic,strong) CLLocationManager *locationmanger;
@property (nonatomic,strong) CLLocation *location;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.showsUserLocation = YES;
    
    self.locationmanger = [[CLLocationManager alloc] init];
    self.locationmanger.delegate = self;
    self.locationmanger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationmanger.distanceFilter = kCLDistanceFilterNone;
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationmanger respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationmanger respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationmanger requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationmanger  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    
    [self.locationmanger startUpdatingLocation];
    
    self.location = [self.locationmanger location];
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location %@",locations);
    
    [self.locationmanger stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
