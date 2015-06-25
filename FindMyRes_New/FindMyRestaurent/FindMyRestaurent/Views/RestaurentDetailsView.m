//
//  RestaurentDetailsView.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/17/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "RestaurentDetailsView.h"
#import "ImageViewCell.h"

@interface RestaurentDetailsView()

@property (nonatomic,strong) UISegmentedControl *segmentControl;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *sortedKeysArray;
@property (nonatomic,strong) NSMutableDictionary *dataDict;

@end

@implementation RestaurentDetailsView

- (instancetype)initWithViewController:(BaseViewController *)viewController
{
    self = [super initWithViewController:viewController];
    
    if (self)
    {
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"In Your City",@"Nearby", nil]];
    [self.segmentControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.segmentControl.selectedSegmentIndex = 1;
    [self addSubview:self.segmentControl];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    self.sortedKeysArray = [[NSMutableArray alloc] init];
    self.dataDict = [[NSMutableDictionary alloc] init];
}

- (void)MySegmentControlAction:(UISegmentedControl *)sender
{
    
}

- (void)updateTableWithData:(NSDictionary *)dataDict andSortedKeys:(NSArray *)sortedKeys
{
    [self.sortedKeysArray removeAllObjects];
    [self.sortedKeysArray  addObjectsFromArray:sortedKeys];
    [self.dataDict removeAllObjects];
    [self.dataDict addEntriesFromDictionary:dataDict];
    [self.tableView reloadData];
}

#pragma mark - Table view data source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortedKeysArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    ImageViewCell *cell  = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (!cell)
    {
        cell = [[ ImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    [cell updateViewsWithData:[self.dataDict objectForKey:[self.sortedKeysArray objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 5;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.segmentControl.frame = CGRectMake(startXPos, startYPos, fullWidth, 30);
    self.tableView.frame = CGRectMake(0, 50, fullWidth + (startXPos*2), fullHeight - 50);
}

@end
