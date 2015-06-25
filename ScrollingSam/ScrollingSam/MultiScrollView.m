//
//  MultiScrollView.m
//  ScrollingSam
//
//  Created by Muthuraj M on 2/26/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "MultiScrollView.h"

@interface MultiScrollView()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *horizontalSc;
@property (nonatomic,retain) UITableView *table1;
@property (nonatomic,retain) UITableView *table2;
@property (nonatomic,retain) UITableView *table3;


@property (nonatomic,assign) int numberOfHorizontalViews;
@property (nonatomic,assign) int currentPageNumber;

@end

@implementation MultiScrollView
@synthesize delegate;
@synthesize dataSource;

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
    self.horizontalSc = [[UIScrollView alloc] init];
    self.horizontalSc.delegate = self;
    self.horizontalSc.pagingEnabled = YES;
    [self addSubview:self.horizontalSc];
    
    self.table1 = [self createTable];
    self.table1.pagingEnabled = YES;
    [self.horizontalSc addSubview:self.table1];
    
    self.table2 = [self createTable];
    [self.horizontalSc addSubview:self.table2];
    
    self.table3 = [self createTable];
    [self.horizontalSc addSubview:self.table3];
    
    
    [self.table1 registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"Cell"];
    [self.table2 registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"Cell"];
    [self.table3 registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"Cell"];
}

- (void)reloadData
{
    int numberOfHorizontalPages = [self.dataSource numberOfViewsInHorizontalScrollView];
    NSLog(@"Number of Horizontal Page %d",numberOfHorizontalPages);
    self.numberOfHorizontalViews = numberOfHorizontalPages;
}

- (UITableView *)createTable
{
    UITableView *tb = [[UITableView alloc] init];
    tb.delegate = self;
    tb.dataSource = self;
    return tb;
}


- (int)calculatePageNumber:(float)fullWidth singlePageWidth:(float)singlePageWidth
{
    int pageNumber = floorf(fullWidth/singlePageWidth);
    return pageNumber;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.horizontalSc)
    {
      int pageNumber = [self calculatePageNumber:scrollView.contentOffset.x singlePageWidth:scrollView.frame.size.width];
      self.currentPageNumber = (pageNumber == -1) ? self.currentPageNumber:pageNumber;
      NSLog(@"Page Number %d",self.currentPageNumber);
        
// Calculate the View to be reused
        
        int viewIndex = self.currentPageNumber % 3;
        
        if (viewIndex == 0)
        {
             // [UIView animateWithDuration:<#(NSTimeInterval)#> delay:<#(NSTimeInterval)#> options:<#(UIViewAnimationOptions)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>]
            
                [UIView animateWithDuration:0.5 animations:^{
                    self.table1.frame = CGRectMake(self.horizontalSc.frame.size.width * self.currentPageNumber, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
                } completion:^(BOOL finished) {
                    
                }];
        }
        else if (viewIndex == 1)
        {
            self.table2.frame = CGRectMake(self.horizontalSc.frame.size.width * self.currentPageNumber, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
        }
        else if (viewIndex == 2)
        {
            self.table3.frame = CGRectMake(self.horizontalSc.frame.size.width * self.currentPageNumber, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
        }
    
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfViewsInVerticalScrollView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    
    if (tableView == self.table1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Test %ld and Table 1",(long)indexPath.row];
        
        cell.backgroundColor = [UIColor redColor];
    }
    else if (tableView == self.table2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Test %ld and Table 2",(long)indexPath.row];
        cell.backgroundColor = [UIColor greenColor];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Test %ld and Table 3",(long)indexPath.row];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.horizontalSc.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.table1.frame = CGRectMake(0, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
    self.table2.frame = CGRectMake(self.horizontalSc.frame.size.width, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
    self.table3.frame = CGRectMake(self.horizontalSc.frame.size.width*2, 0, self.horizontalSc.frame.size.width, self.horizontalSc.frame.size.height);
    
    self.horizontalSc.contentSize = CGSizeMake(self.table1.frame.size.width*self.numberOfHorizontalViews, self.table1.frame.size.height);
}

@end
