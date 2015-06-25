//
//  UIImageView+MyImageView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "UIImageView+MyImageView.h"

@implementation UIImageView (MyImageView)

- (instancetype)initWithBackgroundColor:(UIColor *)bgColor
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = bgColor;
    }
    
    return self;
}

@end
