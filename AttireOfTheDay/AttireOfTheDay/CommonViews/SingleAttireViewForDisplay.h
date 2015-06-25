//
//  SingleAttireViewForDisplay.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/20/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SingleAttireViewForDisplay;

@protocol SingleAttireViewForDisplayDelegate <NSObject>

@end

@interface SingleAttireViewForDisplay : UIView

@property (nonatomic,weak) id<SingleAttireViewForDisplayDelegate> delegate;

- (void)updateViewWithData:(NSDictionary *)dataDict;

@end
