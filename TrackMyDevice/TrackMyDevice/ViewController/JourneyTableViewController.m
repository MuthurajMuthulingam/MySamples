//
//  JourneyTableViewController.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "JourneyTableViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "Journey.h"
#import "JourneyList.h"

@interface JourneyTableViewController ()<journeyListDelegate>

@property (strong,nonatomic)JourneyList *initialView;

@property (strong, nonatomic) NSArray *data;
@property (strong,nonatomic) Journey *selectedJourneyObject;
@end

@implementation JourneyTableViewController

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
    
    self.initialView = [[JourneyList alloc] init];
    self.initialView.delegate = self;
    [self.view addSubview:self.initialView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Journey List";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self fetchFullData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.initialView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70);
}


- (void)fetchFullData
{
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Journey"];
    NSError *error = nil;
    self.data = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"error %@",error.description);
    }
    else
    {
        
        [self.initialView updateTableWithData:self.data];
    }
}

- (void)selectedDataRow:(Journey *)journeyObject
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.journey = journeyObject;
    [self navigateToViewController:detailVC];
}

- (void)deleteDataRow:(Journey *)journeyObject
{
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    [context deleteObject:journeyObject];
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
