//
//  SingleAttireView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewButtonView.h"

@class SingleAttireViewForAdding;

@protocol SingleAttireViewForAddingDelegate <NSObject>

- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)SingleAttireViewForAdding openImagePickerToLoadImage:(NSString *)viewPosition;
- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)SingleAttireViewForAdding openCameraToLoadImage:(NSString *)viewPosition;
- (void)SingleAttireViewForAdding:(SingleAttireViewForAdding *)SingleAttireViewForAdding addButtonClicked:(NSString *)viewPosition;

@end

@interface SingleAttireViewForAdding : UIView

- (void)showAddNewButtonView:(BOOL)shouldShow andView:(AddNewButtonView *)viewToBeShown;

@property (nonatomic,weak) id<SingleAttireViewForAddingDelegate> delegate;

- (void)updateView:(NSString *)viewPositionOnScreen withImage:(UIImage *)image;
- (void)enableAddButon:(BOOL)enable;
@end
