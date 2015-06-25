//
//  MultiScrollView.h
//  ScrollingSam
//
//  Created by Muthuraj M on 2/26/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiScrollView;

@protocol MultiScrollViewDelegate <NSObject>

@optional

- (void)MultiScrollView:(MultiScrollView *)multiscrollView visibleViewIndexInVerticalScrollView:(int)index;
- (void)MultiScrollView:(MultiScrollView *)multiscrollView visibleViewIndexInHorizontalScrollView:(int)index;

@end

@protocol MultiScrollViewDataSource <NSObject>

- (int)numberOfViewsInHorizontalScrollView;
- (int)numberOfViewsInVerticalScrollView;
- (UIView *)MultiScrollView:(MultiScrollView *)multiscrollView ViewForVerticalScrollViewForIndex:(int)Index;
- (UIView *)MultiScrollView:(MultiScrollView *)multiscrollView ViewForHorizontalScrollViewForIndex:(int)Index;

@end


@interface MultiScrollView : UIView

@property (nonatomic,weak)id<MultiScrollViewDelegate>delegate;
@property (nonatomic,weak)id<MultiScrollViewDataSource>dataSource;

- (void)reloadData;

@end
