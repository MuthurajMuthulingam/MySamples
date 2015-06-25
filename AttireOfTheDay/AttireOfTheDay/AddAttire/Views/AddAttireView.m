//
//  AddAttireView.m
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "AddAttireView.h"
#import "SingleAttireViewForAdding.h"

@interface AddAttireView ()<SingleAttireViewForAddingDelegate>

@property (nonatomic,strong) SingleAttireViewForAdding *attireView;

@end

@implementation AddAttireView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

- (void)createViews
{
    [super createViews];
    
    self.attireView = [[SingleAttireViewForAdding alloc] init];
    self.attireView.delegate = self;
    [self.baseContentView addSubview:self.attireView];
}

- (void)enableAddButton:(BOOL)enable
{
    [self.attireView enableAddButon:enable];
}

- (void)showAttireSelectionView:(BOOL)shouldShow
{
    [self.attireView showAddNewButtonView:shouldShow andView:nil];
}

- (void)updateImageToAddAtireView:(AddAttireView *)AttireView toView:(NSString *)ViewLoactionOnScreen andImage:(UIImage *)image
{
    [self.attireView updateView:ViewLoactionOnScreen withImage:image];
}

#pragma singleAttire View Delagates

- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)singleAttireView openCameraToLoadImage:(NSString *)viewPosition
{
    [self.attireViewDelegate addAttireView:self andSingleattireView:singleAttireView openCameraToLoadImage:viewPosition];
}

- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)singleAttireView openImagePickerToLoadImage:(NSString *)viewPosition
{
    [self.attireViewDelegate addAttireView:self andSingleattireView:singleAttireView openImageGalaryToLoadImage:viewPosition];
}

- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)SingleAttireViewForAdding addButtonClicked:(NSString *)viewPosition
{
    [self.attireViewDelegate addAttireView:self andSingleattireView:SingleAttireViewForAdding addBtnClicked:viewPosition];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float startXPos = 10;
    float startYPos = 10;
    float fullWidth = self.baseContentView.frame.size.width  - (startXPos*2);
    float fullHeight = self.baseContentView.frame.size.height - (startYPos*2);
    
    self.attireView.frame = CGRectMake(startXPos, startYPos, fullWidth, fullHeight);
}

@end
