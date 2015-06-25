//
//  commonAttireScrollView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleAttireViewForDisplay.h"

@class commonAttireScrollView;

@protocol commonAttireScrollViewDelegate <NSObject>

@optional

- (void)commonAttireScrollView:(commonAttireScrollView *)coomonAttireScrollView selectedImageView:(UIImageView *)image;

@end

@protocol commonAttireScrollViewDataSource <NSObject>

- (int)commonArrireScrollView:(commonAttireScrollView *)commonAttireScrollView numberOfViewsInScrollView:(UIScrollView *)scrollView;
- (NSDictionary *)commonAttireScrollView:(commonAttireScrollView *)commonAttireScrollView dataToSingleAttireView:(SingleAttireViewForDisplay *)singleAttireView forIndex:(int)index;

@end


@interface commonAttireScrollView : UIView

@property (nonatomic,weak) id<commonAttireScrollViewDelegate>delegate;
@property (nonatomic,weak) id<commonAttireScrollViewDataSource>dataSource;

- (void)reloadData;

@end
