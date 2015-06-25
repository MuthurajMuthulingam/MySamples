//
//  ImageListTableViewController.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "RestaurentDetailsViewController.h"
#import "RestaurentDetailsView.h"
#import "ServerHandler.h"
#import "DataParser.h"
#import "LocationSorter.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface RestaurentDetailsViewController ()<serverHandlerDelegate,DataParserDelegte,LocationSorterDelegate>

@property (nonatomic,strong) RestaurentDetailsView *mainView;

@property (nonatomic,strong) NSOperationQueue *operationQueue;

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) NSMutableArray *parsedDataArray;

@property (nonatomic,strong) CLLocation *currentLocation;

@end

@implementation RestaurentDetailsViewController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    self.mainView = [[RestaurentDetailsView alloc] initWithViewController:self];
    [self.view addSubview:self.mainView];
}

- (void)viewWillLayoutSubviews
{
    self.mainView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Restaurants";
    
    self.parsedDataArray = [[NSMutableArray alloc] init];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    // setup location services
    
    [self setupLocationServices];
    
}

#pragma setup Location Services

- (void)setupLocationServices
{
    self.locationManager = [[CLLocationManager alloc] init];
     self.locationManager.delegate = self;
    self.locationManager.distanceFilter = CLLocationDistanceMax;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if(IS_OS_8_OR_LATER)
    {
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]))
        {
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"])
            {
                [self.locationManager requestAlwaysAuthorization];
            }
            else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"])
            {
                [self.locationManager  requestWhenInUseAuthorization];
            }
            else
            {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    
    [self.locationManager startUpdatingLocation]; // Will consume battery .  stop it if unwanted
}


#pragma location manager Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Locations %@",locations);
    
    CLLocation *location = manager.location;
    
    self.currentLocation = location;
    
    [self startLocationSorting:location andDataArray:self.parsedDataArray];
    
 //   [self.locationManager stopUpdatingHeading]; // to avoid unwanted Battery consumption
}

- (void)startLocationSorting:(CLLocation *)currentLocation andDataArray:(NSArray *)dataArray
{
    LocationSorter *locationSortingOperation = [[LocationSorter alloc] initWithCurrentLocation:currentLocation andCompleteDataArray:dataArray];
    locationSortingOperation.deleagte = self;
    [locationSortingOperation setQualityOfService:NSQualityOfServiceBackground];
    [locationSortingOperation setQueuePriority:NSOperationQueuePriorityLow];
    [self.operationQueue addOperation:locationSortingOperation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error %@",error.description);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mainView showLoadingMessage:@"Loading..." addedToView:self.mainView];
    
    ServerHandler *serverHandlerOperation = [[ServerHandler alloc] initWithURL:[NSURL URLWithString:@"https://stg1-hercules.urbanladder.com/api/variants?token=107fd0a0fc914faa981c90588cf7fe6dbd8cdd5578c83386&q[product_taxons_id_eq]=151"]];//http://staging.couponapitest.com/task_data.txt
    [serverHandlerOperation setQualityOfService:NSQualityOfServiceBackground];
    serverHandlerOperation.delegate = self;
    [serverHandlerOperation setQueuePriority:NSOperationQueuePriorityHigh];
    [self.operationQueue addOperation:serverHandlerOperation];
    
}

- (void)finishedResponse:(id)rawData
{
    if (rawData)
    {
            DataParser *dataParserOperation = [[DataParser alloc] initWithData:rawData];
            [dataParserOperation setQueuePriority:NSOperationQueuePriorityHigh];
            [dataParserOperation setQualityOfService:NSQualityOfServiceBackground];
            dataParserOperation.delegate = self;
            [self.operationQueue addOperation:dataParserOperation];
      }
}

- (void)parsedData:(NSArray *)dataArray
{
    [self.parsedDataArray removeAllObjects];
    [self.parsedDataArray addObjectsFromArray:dataArray];
    
    [self startLocationSorting:self.currentLocation andDataArray:dataArray];
    
    //[self performSelectorOnMainThread:@selector(reloadTableWithData:) withObject:self.completeTableDataArray waitUntilDone:YES];
}

- (void)sortedListOfLocations:(NSDictionary *)unSortedDictObjects andSortedKeys:(NSArray *)sortedKey
{
    NSArray *dataDetails = [NSArray arrayWithObjects:unSortedDictObjects,sortedKey, nil];
    [self performSelectorOnMainThread:@selector(reloadTableWithData:) withObject:dataDetails waitUntilDone:YES];
}

- (void)reloadTableWithData:(NSArray *)dataArray
{
    [self.mainView hideLoadingMessageForView:self.mainView];
    [self.mainView updateTableWithData:[dataArray objectAtIndex:0] andSortedKeys:[dataArray objectAtIndex:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
