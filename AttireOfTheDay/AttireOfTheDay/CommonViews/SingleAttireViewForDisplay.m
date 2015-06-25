//
//  SingleAttireViewForDisplay.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SingleAttireViewForDisplay.h"
#import "UIButton+MyButton.h"
#import "UIImageView+MyImageView.h"
#import "UILabel+MyLabel.h"
#import "StorageHandler.h"

@interface SingleAttireViewForDisplay ()

@property (nonatomic,strong) UIImageView *topWear,*bottomWear;


@end

@implementation SingleAttireViewForDisplay

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
    self.topWear = [[UIImageView alloc] initWithBackgroundColor:[UIColor grayColor]];
    [self addSubview:self.topWear];
    
    self.bottomWear = [[UIImageView alloc] initWithBackgroundColor:[UIColor yellowColor]];
    [self addSubview:self.bottomWear];

}

- (void)updateViewWithData:(NSDictionary *)dataDict
{
    self.bottomWear.image = [[StorageHandler getSharedInstance] retriveImageFromDocumentDirectory:[dataDict objectForKey:@"bottom"]];
    
    //NSLog(@"image %@",[[StorageHandler getSharedInstance] retriveImageFromDocumentDirectory:[dataDict objectForKey:@"bottom"]]);
    
    self.topWear.image = [[StorageHandler getSharedInstance] retriveImageFromDocumentDirectory:[dataDict objectForKey:@"top"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    float singleImageViewHeight = (fullHeight)/2;
    
    self.topWear.frame = CGRectMake(startXPos, startYPos, fullWidth, singleImageViewHeight);
    self.bottomWear.frame = CGRectMake(startXPos, self.topWear.frame.size.height + self.topWear.frame.origin.y, fullWidth, singleImageViewHeight);
}

@end
