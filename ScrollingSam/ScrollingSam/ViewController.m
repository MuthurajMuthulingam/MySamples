//
//  ViewController.m
//  ScrollingSam
//
//  Created by Muthuraj M on 2/25/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "ViewController.h"
#import "MultiScrollView.h"

@interface ViewController ()<MultiScrollViewDataSource,MultiScrollViewDelegate>

@property (nonatomic,strong) MultiScrollView *multiScrollView;

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.multiScrollView = [[MultiScrollView alloc] init];
    self.multiScrollView.delegate = self;
    self.multiScrollView.dataSource = self;
    [self.view addSubview:self.multiScrollView];
    
    [self.multiScrollView reloadData];
    
    //[self deleteDuplicateEntries:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:8], nil]];
}


- (int)numberOfViewsInHorizontalScrollView
{
    return 20;
}

- (int)numberOfViewsInVerticalScrollView
{
    return 3;
}

- (void)deleteDuplicateEntries:(NSArray *)fullSortedArray
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:fullSortedArray];
    
Muthu:
    
    for (int i =0; i < array.count; i++)
    {
        if (array[i+1])
        {
            if (array[i] == array[i+1])
            {
                [array removeObjectAtIndex:i+1];
                
                goto Muthu;
            }
        }
        
    }
    
    NSLog(@"Final array %@",array);
}
    
    


- (UIView *)MultiScrollView:(MultiScrollView *)multiscrollView ViewForHorizontalScrollViewForIndex:(int)Index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor purpleColor];
    return view;
    
}

- (UIView *)MultiScrollView:(MultiScrollView *)multiscrollView ViewForVerticalScrollViewForIndex:(int)Index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.multiScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
