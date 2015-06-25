//
//  SuggestionView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SuggestionView.h"
#import "SingleAttireViewForDisplay.h"
#import "commonAttireScrollView.h"

@interface SuggestionView ()<commonAttireScrollViewDelegate,commonAttireScrollViewDataSource>

@property (nonatomic,strong) UILabel *noSuggestionlabel;
@property (nonatomic,strong) UIButton *addAttire;
@property (nonatomic,strong) UIButton *done;

@property (nonatomic,strong) UIButton *dislikeButton,*bookmarkButon;

@property (nonatomic,strong) commonAttireScrollView *commonAttireScrollView;

@property (nonatomic,strong) NSMutableArray *attiresList;
@property (nonatomic,assign) int currentIndex;

@end

@implementation SuggestionView

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
    self.backgroundColor = [UIColor whiteColor];
    
    [super createViews];
    
    self.dislikeButton = [[UIButton alloc] initWithBackgroundColor:[UIColor redColor] andTitleText:@"DL" andTextColor:[UIColor whiteColor]];
    [self.dislikeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.dislikeButton];
    
    self.bookmarkButon = [[UIButton alloc] initWithBackgroundColor:[UIColor greenColor] andTitleText:@"B/M" andTextColor:[UIColor blackColor]];
    [self.bookmarkButon addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.bookmarkButon];
    
    self.commonAttireScrollView = [[commonAttireScrollView alloc] init];
    self.commonAttireScrollView.delegate = self;
    self.commonAttireScrollView.dataSource = self;
    [self.baseContentView addSubview:self.commonAttireScrollView];
    
    self.done = [[UIButton alloc] initWithBackgroundColor:[UIColor redColor] andTitleText:@"Done" andTextColor:[UIColor whiteColor]];
    [self.done addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.done];
    
    [self createNoSuggestionView];
    
    self.attiresList = [[NSMutableArray alloc] init];
}

- (void)buttonClicked:(UIButton *)sender
{
    if (sender == self.bookmarkButon)
    {
        [self.suggestionViewdelegate suggestionView:self bookmarkButtonClicked:sender andSeletedAttirePairDict:[self.attiresList objectAtIndex:self.currentIndex]];
    }
    else if (sender == self.dislikeButton)
    {
        [self.suggestionViewdelegate suggestionView:self dislikeButtonClicked:sender andSeletedAttirePairDict:[self.attiresList objectAtIndex:self.currentIndex]];
    }
    else if (sender == self.done)
    {
        [self.suggestionViewdelegate suggestionView:self selectedAttire:[self.attiresList objectAtIndex:self.currentIndex]];
    }
    else
    {
        [self.suggestionViewdelegate suggestionView:self addButtonClicked:sender];;
    }
}

- (void)createNoSuggestionView
{
    self.noSuggestionlabel = [[UILabel alloc] init];
    self.noSuggestionlabel.textAlignment = NSTextAlignmentCenter;
    self.noSuggestionlabel.backgroundColor = [UIColor greenColor];
    self.noSuggestionlabel.numberOfLines = 0;
    self.noSuggestionlabel.text = @"No Attires Available. Please add some attires";
    [self.baseContentView addSubview:self.noSuggestionlabel];
    
    self.addAttire = [[UIButton alloc] initWithBackgroundColor:[UIColor purpleColor] andTitleText:@"Add Attire" andTextColor:[UIColor whiteColor]];
    [self.addAttire addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseContentView addSubview:self.addAttire];
}

- (void)updateViewWithData:(NSArray *)attiresList
{
    if (self.attiresList.count > 0)
    {
        [self.attiresList removeAllObjects];
    }
    
    [self.attiresList addObjectsFromArray:attiresList];
    [self.commonAttireScrollView reloadData];
}

- (void)showNoAttireView:(BOOL)isShow
{
    self.noSuggestionlabel.hidden = !isShow;
    
    self.done.hidden = isShow;
    self.bookmarkButon.hidden = isShow;
    self.dislikeButton.hidden = isShow;
    self.commonAttireScrollView.hidden = isShow;
    
//    if (!isShow)
//    {
//        [self.commonAttireScrollView reloadData];
//    }
    
    [self setNeedsLayout];
}


#pragma commonAttire View Delegates and DataSources

- (int)commonArrireScrollView:(commonAttireScrollView *)commonAttireScrollView numberOfViewsInScrollView:(UIScrollView *)scrollView
{
    return (int)self.attiresList.count;
}


- (NSDictionary *)commonAttireScrollView:(commonAttireScrollView *)commonAttireScrollView dataToSingleAttireView:(SingleAttireViewForDisplay *)singleAttireView forIndex:(int)index
{
    self.currentIndex = index;
    return [self.attiresList objectAtIndex:index];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.baseContentView.frame.size.width  - (startXPos*2);
    float fullHeight = self.baseContentView.frame.size.height - (startYPos*2);
    
    self.dislikeButton.frame = CGRectMake(startXPos, startYPos, 50, 50);
    self.bookmarkButon.frame = CGRectMake(fullWidth - 60, startYPos, 50, 50);
        
    self.commonAttireScrollView.frame = CGRectMake(startXPos, self.dislikeButton.frame.size.height + self.dislikeButton.frame.origin.y, fullWidth, fullHeight - 150);
    self.noSuggestionlabel.frame = CGRectMake(startXPos, self.dislikeButton.frame.size.height + self.dislikeButton.frame.origin.y, fullWidth, fullHeight - 150);
    
    self.done.frame = CGRectMake(startXPos, self.noSuggestionlabel.frame.size.height + self.noSuggestionlabel.frame.origin.y + 5, fullWidth, 50);
    
    if (self.done.isHidden)
    {
        self.addAttire.frame = CGRectMake(startXPos, self.noSuggestionlabel.frame.size.height + self.noSuggestionlabel.frame.origin.y + 5, fullWidth, 50);
    }
    else
    {
        self.addAttire.frame = CGRectMake(startXPos, self.done.frame.size.height + self.done.frame.origin.y + 5, fullWidth, 50);
    }
    
    
}

@end
