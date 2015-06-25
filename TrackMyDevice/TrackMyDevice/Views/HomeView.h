//
//  HomeView.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"
#import <MapKit/MapKit.h>

@protocol HomeViewDelegate <NSObject>

- (void)startClecked;
- (void)stopClicked;


@end


@interface HomeView : BaseView

@property (nonatomic,weak)id<HomeViewDelegate>delegate;

- (void)updateViewWithData:(NSDictionary *)dataDict;

@end
