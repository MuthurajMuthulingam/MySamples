//
//  MyPreferncesView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/19/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "MyPreferncesView.h"

@interface MyPreferncesView ()<commonAttireScrollViewDataSource,commonAttireScrollViewDelegate>

@property (nonatomic,strong) UIButton *share;
@property (nonatomic,strong) commonAttireScrollView *commonAttireScrollView;
@property (nonatomic,strong) NSMutableArray *attiresList;

@property (nonatomic,strong) UILabel *noPreferncesLabel;

@end

@implementation MyPreferncesView

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
    
    self.attiresList = [[NSMutableArray alloc] init];
    
    self.share = [[UIButton alloc] initWithBackgroundColor:[UIColor purpleColor] andTitleText:@"Share" andTextColor:[UIColor whiteColor]];
    [self.share addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.share];
    
    self.commonAttireScrollView = [[commonAttireScrollView alloc] init];
    self.commonAttireScrollView.delegate = self;
    self.commonAttireScrollView.dataSource = self;
    [self.baseContentView addSubview:self.commonAttireScrollView];
    
    self.noPreferncesLabel = [[UILabel alloc] init];
    self.noPreferncesLabel.textAlignment = NSTextAlignmentCenter;
    self.noPreferncesLabel.backgroundColor = [UIColor greenColor];
    self.noPreferncesLabel.numberOfLines = 0;
    self.noPreferncesLabel.text = @"You have no Preferred Attires.";
    [self.baseContentView addSubview:self.noPreferncesLabel];
}

- (void)showNoPreferencesView:(BOOL)shouldShow
{
    self.noPreferncesLabel.hidden = !shouldShow;
    
    self.share.hidden = shouldShow;
    self.commonAttireScrollView.hidden = shouldShow;
}

- (void)buttonClicked:(UIButton *)sender
{
    [self.MyPreferncesDelegate myPreferencesView:self shareBtnClicked:self.commonAttireScrollView];
}

- (void)updateViewWithData:(NSArray *)dataArray
{
    [self showNoPreferencesView:NO];
    
    if (self.attiresList.count > 0)
    {
        [self.attiresList removeAllObjects];
    }
    
    [self.attiresList addObjectsFromArray:dataArray];
    [self.commonAttireScrollView reloadData];
}

#pragma commonAttire View Delegates and DataSources

- (int)commonArrireScrollView:(commonAttireScrollView *)commonAttireScrollView numberOfViewsInScrollView:(UIScrollView *)scrollView
{
    return (int)self.attiresList.count;
}


- (NSDictionary *)commonAttireScrollView:(commonAttireScrollView *)commonAttireScrollView dataToSingleAttireView:(SingleAttireViewForDisplay *)singleAttireView forIndex:(int)index
{
    return [self.attiresList objectAtIndex:index];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.baseContentView.frame.size.width  - (startXPos*2);
    float fullHeight = self.baseContentView.frame.size.height - (startYPos*2);
    
    self.share.frame = CGRectMake(fullWidth - 120, startYPos, 100, 50);
    
    self.commonAttireScrollView.frame = CGRectMake(startXPos, self.share.frame.origin.y + self.share.frame.size.height + 10, fullWidth, fullHeight - (self.share.frame.origin.y + self.share.frame.size.height + 10));
    self.noPreferncesLabel.frame = CGRectMake(startXPos, self.share.frame.origin.y + self.share.frame.size.height + 10, fullWidth, fullHeight - (self.share.frame.origin.y + self.share.frame.size.height + 10));
}

@end
