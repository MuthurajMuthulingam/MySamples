//
//  ImageListTableViewController.m
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "ImageListTableViewController.h"
#import "ServerHandler.h"
#import "ImageViewCell.h"

@interface ImageListTableViewController ()
//{
//    NSMutableArray *patterns;
//    NSMutableArray *patternImages;
//}


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

@end

@implementation ImageListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    self.title = @"Image List";
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTableData)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)refreshTableData
{
    id responseData = [ServerHandler getDataFromURL:[NSURL URLWithString:@"http://192.254.141.167/~fstech/pic.php"]];
    
    NSLog(@"response Data %@",responseData);
    
    [self parseCompleteDataFromServer:responseData];
}

- (void)parseCompleteDataFromServer:(id)rowData
{
    if ([rowData isKindOfClass:[NSArray class]]) // JSON Array
    {
        
    }
    else if ([rowData isKindOfClass:[NSDictionary class]]) // JSON Object
    {
        NSArray *jsonArray = [rowData objectForKey:@"items"];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:jsonArray];
        
        [self reloadTableData];
    }
}

- (void)reloadTableData
{
    if (self.refreshControl)
    {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray.count >0)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        return 1;
        
    }
    else
    {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentifier = @"cellidentifier";
    ImageViewCell *cell  = nil;
    
    NSLog(@"total Row Count %d",self.dataArray.count);
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (!cell)
    {
        cell = [[ ImageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        
        
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Delete"];
         [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Delete"];
        
        cell.leftUtilityButtons = leftUtilityButtons;
        cell.rightUtilityButtons = rightUtilityButtons;
        cell.delegate = self;
    }
    
    [cell updateViewsWithData:[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

#pragma SwipableCell Delegates

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    [self.dataArray removeObjectAtIndex:cellIndexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationRight];
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    [self.dataArray removeObjectAtIndex:cellIndexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

@end
