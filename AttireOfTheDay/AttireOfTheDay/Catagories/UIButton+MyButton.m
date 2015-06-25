//
//  UIButton+MyButton.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UIButton+MyButton.h"

@implementation UIButton (MyButton)

- (instancetype)initWithBackgroundColor:(UIColor *)bgColor andTitleText:(NSString *)titleText andTextColor:(UIColor *)textColor
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = bgColor;
        [self setTitle:titleText forState:UIControlStateNormal];
        [self setTitle:titleText forState:UIControlStateHighlighted];
        [self setTitle:titleText forState:UIControlStateSelected];
        
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateHighlighted];
        [self setTitleColor:textColor forState:UIControlStateSelected];
    }
    return self;
}

@end
