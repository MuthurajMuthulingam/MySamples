//
//  commonAttireScrollView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "commonAttireScrollView.h"

@interface commonAttireScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *commonScrollView;
@property (nonatomic,assign) int numberOfViews,currentPageNumber;
@property (nonatomic,strong) SingleAttireViewForDisplay *singleAttireScollView;

@end


@implementation commonAttireScrollView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self createViews];
        self.numberOfViews = 0;
    }
    
    return self;
}

- (void)createViews
{
    self.commonScrollView = [[UIScrollView alloc] init];
    self.commonScrollView.delegate = self;
    self.commonScrollView.pagingEnabled = YES;
    [self addSubview:self.commonScrollView];
    
    self.singleAttireScollView = [self createSingleAttireview];
    [self.commonScrollView addSubview:self.singleAttireScollView];
}

- (SingleAttireViewForDisplay *)createSingleAttireview
{
    SingleAttireViewForDisplay *singleAttireView = [[SingleAttireViewForDisplay alloc] init];
    return singleAttireView;
}

#pragma scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int pageNumber = [self calculatePageNumber:scrollView.contentOffset.x singlePageWidth:scrollView.frame.size.width];
    
    if (self.currentPageNumber != pageNumber)
    {
        self.currentPageNumber = pageNumber;
        
        if ( self.numberOfViews > self.currentPageNumber)
        {
            [self setFrameToSingleAttireView];
            
            [self.singleAttireScollView updateViewWithData:[self.dataSource commonAttireScrollView:self dataToSingleAttireView:self.singleAttireScollView forIndex:pageNumber]];
        }
    }
    
}

- (int)calculatePageNumber:(float)fullWidth singlePageWidth:(float)singlePageWidth
{
    int pageNumber = ceilf(fullWidth/singlePageWidth);
    return pageNumber;
}

- (void)setFrameToSingleAttireView
{
    self.singleAttireScollView.alpha = 0;
    
    self.singleAttireScollView.frame = CGRectMake(self.commonScrollView.frame.size.width * self.currentPageNumber, 0, self.commonScrollView.frame.size.width, self.commonScrollView.frame.size.height);
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.singleAttireScollView.alpha = 1;
        
    } completion:^(BOOL selected){
        
    } ];
}

- (void)reloadData
{
    self.numberOfViews = [self.dataSource commonArrireScrollView:self numberOfViewsInScrollView:self.commonScrollView];
    self.commonScrollView.contentSize = CGSizeMake((self.numberOfViews == 0) ? self.frame.size.width:self.frame.size.width*self.numberOfViews, self.frame.size.height);
    if (self.numberOfViews !=0)
    {
        [self.singleAttireScollView updateViewWithData:[self.dataSource commonAttireScrollView:self dataToSingleAttireView:self.singleAttireScollView forIndex:0]];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 0;
    float startYPos = 0;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.commonScrollView.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight);
    self.commonScrollView.contentSize = CGSizeMake((self.numberOfViews == 0) ? fullWidth:fullWidth*self.numberOfViews, fullHeight);
    
    [self setFrameToSingleAttireView];
}

@end
