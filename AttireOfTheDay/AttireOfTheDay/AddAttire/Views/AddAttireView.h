//
//  AddAttireView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@class AddAttireView;
@class SingleAttireViewForAdding;

@protocol attireViewDelegate <NSObject>

- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView openImageGalaryToLoadImage:(NSString *)viewPosition;
- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView openCameraToLoadImage:(NSString *)viewPosition;
- (void)addAttireView:(AddAttireView *)addAttireView andSingleattireView:(SingleAttireViewForAdding *)singleAttireView addBtnClicked:(NSString *)viewPosition;

@end

@interface AddAttireView : BaseView

@property (nonatomic,weak) id<attireViewDelegate> attireViewDelegate;

- (void)showAttireSelectionView:(BOOL)shouldShow;
- (void)updateImageToAddAtireView:(AddAttireView *)attireView toView:(NSString *)ViewLoactionOnScreen andImage:(UIImage *)image;

- (void)enableAddButton:(BOOL)enable;
@end
