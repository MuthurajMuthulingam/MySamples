//
//  InitialView.m
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "InitialView.h"

@interface InitialView ()

@property (nonatomic,strong) UIButton *journet,*pastJoury;

@end

@implementation InitialView
@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        //[self createViews];
    }
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.journet = [self createButton:[UIColor blackColor] andText:@"New Journey"];
    [self.journet addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.journet];
    
    self.pastJoury = [self createButton:[UIColor darkGrayColor] andText:@"Past Journey"];
    [self.pastJoury addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pastJoury];
}

- (void)btnClicked:(UIButton *)sender
{
    
    if (sender == self.journet)
    {
        [self.delegate newJourneyBtnClick];
    }
    else
    {
        [self.delegate pastJourneyBtnClcik];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.frame.size.width - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    self.journet.frame = CGRectMake(fullWidth/4, fullHeight/4, fullWidth/2, 50);
    self.pastJoury.frame = CGRectMake(fullWidth/4, self.journet.frame.origin.y + self.journet.frame.size.height + 10, fullWidth/2, 50);
}


@end
