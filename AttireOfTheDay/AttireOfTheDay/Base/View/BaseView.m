//
//  BaseView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

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
    self.baseContentView = [[UIView alloc] init];
    self.baseContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.baseContentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 80;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos + 10);
    
    self.baseContentView.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight);
    
}

@end
