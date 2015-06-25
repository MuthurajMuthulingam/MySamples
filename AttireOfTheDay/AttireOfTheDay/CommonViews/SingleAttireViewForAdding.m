//
//  SingleAttireView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "SingleAttireViewForAdding.h"
#import "UIButton+MyButton.h"
#import "UIImageView+MyImageView.h"
#import "UILabel+MyLabel.h"


@interface SingleAttireViewForAdding ()<AddNewButtonViewDelegate>

@property (nonatomic,strong) UIImageView *topWear,*bottomWear;
@property (nonatomic,strong) UIButton *done;

@property (nonatomic,strong) AddNewButtonView *addNewbtnViewforTopWear,*addNewbtnViewforBottomWear;

@end

@implementation SingleAttireViewForAdding

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
    
    self.done = [[UIButton alloc] initWithBackgroundColor:[UIColor redColor] andTitleText:@"Done" andTextColor:[UIColor whiteColor]];
    [self.done addTarget:self action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.done];
}

- (void)addClicked:(UIButton *)sender
{
    [self.delegate SingleAttireViewForAdding:self addButtonClicked:@"add"];
}

- (void)createAddNewBtnView
{
    self.addNewbtnViewforBottomWear = [[AddNewButtonView alloc] init];
    self.addNewbtnViewforBottomWear.delegate = self;
    [self addSubview:self.addNewbtnViewforBottomWear];
    
    self.addNewbtnViewforTopWear = [[AddNewButtonView alloc] init];
    self.addNewbtnViewforTopWear.delegate = self;
    [self addSubview:self.addNewbtnViewforTopWear];
}

- (void)updateView:(NSString *)viewPositionOnScreen withImage:(UIImage *)image
{
    if ([viewPositionOnScreen isEqualToString:@"bottom"])
    {
        [self showAddNewButtonView:NO andView:self.addNewbtnViewforBottomWear];
        
        self.bottomWear.image = image;
    }
    else
    {
        [self showAddNewButtonView:NO andView:self.addNewbtnViewforTopWear];
        
        self.topWear.image = image;
    }
}

- (void)enableAddButon:(BOOL)enable
{
    self.done.hidden = !enable;
}

- (void)addNewButtonView:(AddNewButtonView *)addNewButtonView selectedButtonString:(NSString *)buttonTitle
{
    if (addNewButtonView == self.addNewbtnViewforBottomWear)
    {
        if ([buttonTitle isEqualToString:@"fromGallery"])
        {
            [self.delegate SingleAttireViewForAdding:self openImagePickerToLoadImage:@"bottom"];
        }
        else
        {
            [self.delegate SingleAttireViewForAdding:self openCameraToLoadImage:@"bottom"];
        }
    }
    else
    {
        if ([buttonTitle isEqualToString:@"fromGallery"])
        {
            [self.delegate SingleAttireViewForAdding:self openImagePickerToLoadImage:@"top"];
        }
        else
        {
            [self.delegate SingleAttireViewForAdding:self openCameraToLoadImage:@"top"];
        }
    }
}

- (void)showAddNewButtonView:(BOOL)shouldShow andView:(AddNewButtonView *)viewtoBeShown
{
    if (!self.addNewbtnViewforTopWear)
    {
        [self createAddNewBtnView];
        [self setNeedsLayout];
    }
    
    if (!viewtoBeShown)
    {
        self.addNewbtnViewforTopWear.hidden = !shouldShow;
        self.addNewbtnViewforBottomWear.hidden = !shouldShow;
    }
    else
    {
        viewtoBeShown.hidden = !shouldShow;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.frame.size.width  - (startXPos*2);
    float fullHeight = self.frame.size.height - (startYPos*2);
    
    float singleImageViewHeight = (fullHeight - 100)/2;
    
    self.topWear.frame = CGRectMake(startXPos, startYPos, fullWidth, singleImageViewHeight);
    self.bottomWear.frame = CGRectMake(startXPos, self.topWear.frame.size.height + self.topWear.frame.origin.y, fullWidth, singleImageViewHeight);
    self.done.frame = CGRectMake(startXPos, self.bottomWear.frame.size.height + self.bottomWear.frame.origin.y + 20, fullWidth, fullHeight - (self.bottomWear.frame.size.height + self.bottomWear.frame.origin.y + 20));
    
    self.addNewbtnViewforBottomWear.frame =  CGRectMake(startXPos, self.topWear.frame.size.height + self.topWear.frame.origin.y, fullWidth, singleImageViewHeight);
    self.addNewbtnViewforTopWear.frame = CGRectMake(startXPos, startYPos, fullWidth, singleImageViewHeight);
    
}

@end
