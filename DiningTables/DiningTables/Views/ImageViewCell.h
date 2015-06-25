//
//  ImageViewCell.h
//  Photomania
//
//  Created by Muthuraj M on 12/21/14.
//  Copyright (c) 2014 Market Simplified. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageViewDelegate <NSObject>

- (NSDictionary *)dataForVisibleView:(int)visibleViewIndex;
- (int)numberOfViewsInHorizontalScrollView;

@end

@interface ImageViewCell : UITableViewCell

@property (nonatomic,weak)id<ImageViewDelegate>delegate;

- (void)updateViewsWithData:(NSArray *)resDetails;

@end
