//
//  AddNewButtonView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/19/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "AddNewButtonView.h"
#import "UIButton+MyButton.h"
#import "UILabel+MyLabel.h"

@interface AddNewButtonView ()

@property (nonatomic,strong) UIButton *addFromImageGallery,*addFromCamera;
@property (nonatomic,strong) UILabel *orLabel;

@end

@implementation AddNewButtonView

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
    self.addFromImageGallery = [[UIButton alloc] initWithBackgroundColor:[UIColor redColor] andTitleText:@"fromGallery" andTextColor:[UIColor whiteColor]];
    [self.addFromImageGallery addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addFromImageGallery];
    
    self.addFromCamera = [[UIButton alloc] initWithBackgroundColor:[UIColor greenColor] andTitleText:@"Take a Pic" andTextColor:[UIColor blackColor]];
    [self.addFromCamera addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addFromCamera];
    
    self.orLabel = [[UILabel alloc] initWithText:@"Or" andAlignment:NSTextAlignmentCenter andTextColor:[UIColor blackColor]];
    [self addSubview:self.orLabel];
}

- (void)buttonClicked:(UIButton *)sender
{
    [self.delegate addNewButtonView:self selectedButtonString:sender.titleLabel.text];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = self.frame.size.width / 4;
    float startYPos = 10;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    float singleViewHeight = (fullHeight - 30) / 3;
    
    self.addFromImageGallery.frame = CGRectMake(startXPos, startYPos, fullWidth, singleViewHeight);
    
    self.orLabel.frame = CGRectMake(startXPos, self.addFromImageGallery.frame.size.height + self.addFromImageGallery.frame.origin.y + 10, fullWidth, singleViewHeight);
    
    self.addFromCamera.frame = CGRectMake(startXPos, self.orLabel.frame.size.height + self.orLabel.frame.origin.y + 20, fullWidth, fullHeight - (self.orLabel.frame.size.height + self.orLabel.frame.origin.y + 10));

    
}


@end
