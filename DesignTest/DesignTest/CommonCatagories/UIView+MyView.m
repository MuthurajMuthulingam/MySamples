//
//  UIView+MyView.m
//  DesignTest
//
//  Created by Muthuraj M on 6/4/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UIView+MyView.h"

@implementation UIView (MyView)

- (instancetype)initWithBackgroundColor:(UIColor *)bgColor
{
    self = [[UIView alloc] init];
    
    self.backgroundColor = bgColor;
    
    return self;
}

@end
