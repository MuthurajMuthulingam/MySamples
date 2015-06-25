//
//  FeaturedListViewController.m
//  Games
//
//  Created by Muthuraj M on 5/5/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "FeaturedListViewController.h"
#import "CommonProcessingAPI.h"
#import "GenericTableViewCell.h"

@interface FeaturedListViewController ()<CommonAPIDelegate>

@property (nonatomic,strong) CommonProcessingAPI *commonProcessingUnit;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FeaturedListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.commonProcessingUnit = [[CommonProcessingAPI alloc] init];
    self.commonProcessingUnit.delegate = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_queue_t  myqueue = dispatch_queue_create("myQueue", nil);
    
    dispatch_async(myqueue, ^{
        [self.commonProcessingUnit performGenericProcessingWithURL:[NSURL URLWithString:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=cricket+football&rsz=8&userip=203.187.253.58"]];
    });
}

- (void)commonProcessingAPI:(CommonProcessingAPI *)commonProcessingAPI processedDataArray:(NSArray *)dataArray
{

    if (self.dataArray.count > 0)
    {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:dataArray];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellidentifier";
    GenericTableViewCell *cell  = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[GenericTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell updateViewWithData:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
