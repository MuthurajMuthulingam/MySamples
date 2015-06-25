//
//  SampleView.m
//  AutoLayoutSanple
//
//  Created by Muthuraj M on 4/22/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SampleView.h"

@interface SampleView()
{
    UIButton *button,*button2;
    NSDictionary *viewsDict;
}
@end

@implementation SampleView

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        [self createViews];
    }
    
    return self;
}

- (void)createViews
{
    button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor redColor];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:button];
    
    button2 = [[UIButton alloc] init];
    button2.backgroundColor = [UIColor redColor];
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:button2];
    
    viewsDict = NSDictionaryOfVariableBindings(button,button2);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[button]-|" options:0 metrics:0 views:viewsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[button2]-|" options:0 metrics:0 views:viewsDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button]-5-[button2(==button)]-|" options:0 metrics:0 views:viewsDict]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
    
}


@end
