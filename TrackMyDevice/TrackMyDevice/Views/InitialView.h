//
//  InitialView.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@protocol InitialViewDelegate <NSObject>

- (void)newJourneyBtnClick;
- (void)pastJourneyBtnClcik;

@end

@interface InitialView : BaseView

@property (nonatomic,weak) id<InitialViewDelegate>delegate;

@end
