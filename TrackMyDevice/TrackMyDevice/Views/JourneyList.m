//
//  JourneyList.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "JourneyList.h"

@interface JourneyList ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation JourneyList
@synthesize delegate;

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
    [super createViews];
    
    self.data = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)updateTableWithData:(NSArray *)data
{
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:data];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return (self.data.count > 0) ? self.data.count:0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier   forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    //Journey *journey = (Journey *)[self.data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Journey %d",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate selectedDataRow:(Journey *)[self.data objectAtIndex:indexPath.row]];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Journey *journeyObj = (Journey *)[self.data objectAtIndex:indexPath.row];
        [self.data removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.delegate deleteDataRow:journeyObj];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


@end
