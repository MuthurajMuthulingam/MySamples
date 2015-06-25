//
//  DetailViewController.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "DetailViewController.h"
#import "MathController.h"
#import "Location.h"

#import "DetailsView.h"

@interface DetailViewController ()

@property (nonatomic,strong) DetailsView *initialView;

@end

@implementation DetailViewController

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
    
    self.initialView = [[DetailsView alloc] init];
    [self.view addSubview:self.initialView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.title = @"Journey Details";
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"FB Share" style:UIBarButtonItemStyleDone target:self action:@selector(shareFacebook)];
    self.navigationItem.rightBarButtonItem = bar;
}

- (void)setJourney:(Journey *)journey
{
    if (_journey !=journey)
    {
        _journey = journey;
        
        [self configureView];
    }
}

- (void)configureView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [self.initialView updateViewWithData:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [MathController stringifySecondCount:self.journey.duration.intValue usingLongFormat:YES],@"time",
                                          [MathController stringifyDistance:self.journey.distance.floatValue],@"distance",
                                          [MathController stringifySpeedFromDist:self.journey.distance.floatValue overTime:self.journey.duration.intValue],@"speed",
                                          [formatter stringFromDate:self.journey.timestamp],@"date",nil]]; // stringifyAvgPaceFromDist:self.journey.distance.floatValue overTime:self.journey.duration.intValue]
    [self loadMap];
}

- (void)loadMap
{
    if (self.journey.location.count > 0)
    {
        NSArray *colorSegmentArray = [MathController colorSegmentsForLocations:self.journey.location.array];
        [self.initialView updateMapWithRegion:[self mapRegion] andOverlay:colorSegmentArray];
        
    }
    else
    {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Sorry, this Journey has no locations saved."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)shareFacebook
{
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        
        [fbController setInitialText:@"This is My Journey Details"];
        [fbController addImage:[self imageByRenderingView:self.initialView]];
        
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sign in!" message:@"Please first Sign In!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIImage *)imageByRenderingView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.bounds.size.width, view.bounds.size.height), view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}


- (MKCoordinateRegion)mapRegion
{
    MKCoordinateRegion region;
    Location *initialLoc = self.journey.location.firstObject;
    
    float minLat = initialLoc.latitude.floatValue;
    float minLng = initialLoc.longitiude.floatValue;
    float maxLat = initialLoc.latitude.floatValue;
    float maxLng = initialLoc.longitiude.floatValue;
    
    for (Location *location in self.journey.location)
    {
        if (location.latitude.floatValue < minLat)
        {
            minLat = location.latitude.floatValue;
        }
        if (location.longitiude.floatValue < minLng)
        {
            minLng = location.longitiude.floatValue;
        }
        if (location.latitude.floatValue > maxLat) {
            maxLat = location.latitude.floatValue;
        }
        if (location.longitiude.floatValue > maxLng)
        {
            maxLng = location.longitiude.floatValue;
        }
    }
    
    region.center.latitude = (minLat + maxLat) / 2.0f;
    region.center.longitude = (minLng + maxLng) / 2.0f;
    
    region.span.latitudeDelta = (maxLat - minLat) * 1.1f; // 10% padding
    region.span.longitudeDelta = (maxLng - minLng) * 1.1f; // 10% padding
    
    return region;
}

- (MKPolyline *)polyLine
{
     CLLocationCoordinate2D coords[self.journey.location.count];
    
    for (int i = 0; i < self.journey.location.count; i++) {
        Location *location = [self.journey.location objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitiude.doubleValue);
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:self.journey.location.count];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.initialView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
}


@end
