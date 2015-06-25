//
//  MyTableViewController.m
//  ImagewithTableview
//
//  Created by Muthuraj M on 11/15/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import "MyTableViewController.h"
#import "CustomTableViewCell.h"

@interface MyTableViewController ()

@property (nonatomic,strong) NSMutableDictionary *dataDict;

@end

@implementation MyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataDict = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_2.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg",@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_3.jpg", nil] forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11", nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataDict.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    CustomTableViewCell *cell = nil;
    
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSURL *imageURL = [NSURL URLWithString:[self.dataDict objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]]];
    
    NSLog(@"imageURL %@",imageURL);
    
    [cell updateImageView:imageURL];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
