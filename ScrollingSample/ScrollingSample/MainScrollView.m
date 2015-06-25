//
//  MainScrollView.m
//  ScrollingSample
//
//  Created by Muthuraj M on 1/30/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

#import "MainScrollView.h"

@implementation MainScrollView

- (id)init
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
    self.horizontalScrollView = [[UIScrollView alloc] init];
    self.horizontalScrollView.backgroundColor = [UIColor greenColor];
    self.horizontalScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*2);
    [self addSubview:self.horizontalScrollView];
    
    self.verticalScrollView = [[UIScrollView alloc] init];
    self.verticalScrollView.backgroundColor = [UIColor redColor];
    self.verticalScrollView.contentSize = CGSizeMake(self.frame.size.width*2, self.frame.size.height);
    [self addSubview:self.verticalScrollView];
    
    [self addBlankViewtoScrollView:self.horizontalScrollView andColor:[UIColor yellowColor]];
    [self addBlankViewtoScrollView:self.verticalScrollView andColor:[UIColor purpleColor]];
    
}

- (void)addBlankViewtoScrollView:(UIScrollView *)scrollview andColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*2, self.frame.size.height*2)];
    view.backgroundColor = bgColor;
    view.tag = 1;
    [scrollview addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = bgColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Testssssssss";
    label.tag = 2;
    [scrollview addSubview:label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.horizontalScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.verticalScrollView.frame = CGRectMake(0, 0, self.frame.size.width  - 20 , self.frame.size.height  - 20);
    ((UIView *)[self.horizontalScrollView viewWithTag:1]).frame = CGRectMake(0, 0, self.horizontalScrollView.frame.size.width*2, self.horizontalScrollView.frame.size.height*2);
    ((UIView *)[self.verticalScrollView viewWithTag:1]).frame = CGRectMake(0, 0, self.verticalScrollView.frame.size.width*2, self.verticalScrollView.frame.size.height*2);
    
    ((UILabel *)[self.horizontalScrollView viewWithTag:2]).frame = CGRectMake(0, 0, self.horizontalScrollView.frame.size.width*2, self.horizontalScrollView.frame.size.height*2);
    ((UILabel *)[self.verticalScrollView viewWithTag:2]).frame = CGRectMake(0, 0, self.verticalScrollView.frame.size.width*2, self.verticalScrollView.frame.size.height*2);
    
}

@end
