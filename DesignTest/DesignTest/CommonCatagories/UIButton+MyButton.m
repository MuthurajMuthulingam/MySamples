//
//  UIButton+MyButton.m
//  DesignTest
//
//  Created by Muthuraj M on 6/4/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UIButton+MyButton.h"

@implementation UIButton (MyButton)

- (instancetype)initWithTitleText:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)bgColor
{
    self = [super init];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setBackgroundColor:bgColor];
    
    return self;
    
}

@end
