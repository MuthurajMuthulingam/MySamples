//
//  RestaurentDetailsView.m
//  FindMyRestaurant
//
//  Created by Muthuraj M on 1/17/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "DiningTablesView.h"
#import "ImageViewCell.h"

@interface DiningTablesView()<UITableViewDelegate,UITableViewDataSource,ImageViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *sortedKeysArray;

@end

@implementation DiningTablesView

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
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    self.sortedKeysArray = [[NSMutableArray alloc] init];
}

- (void)updateTableWithData:(NSArray *)dataArray
{
    [self.sortedKeysArray removeAllObjects];
    [self.sortedKeysArray addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}

- (NSDictionary *)dataForVisibleView:(int)visibleViewIndex
{
    return [self.sortedKeysArray objectAtIndex:visibleViewIndex];
}
- (int)numberOfViewsInHorizontalScrollView
{
    return self.sortedKeysArray.count;
}

#pragma mark - Table view data source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//self.sortedKeysArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    ImageViewCell *cell  = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (!cell)
    {
        cell = [[ ImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.delegate = self;
    }
    if (self.sortedKeysArray.count > 0)
    {
        [cell updateViewsWithData:self.sortedKeysArray];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 5;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.tableView.frame = CGRectMake(0, 0, fullWidth + (startXPos*2), fullHeight);
}

@end
