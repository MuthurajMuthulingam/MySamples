//
//  JourneyList.h
//  TrackMyDevice
//
//  Created by Muthuraj M on 2/23/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"
#import "Journey.h"

@protocol journeyListDelegate <NSObject>

- (void)selectedDataRow:(Journey *)journeyObject;
- (void)deleteDataRow:(Journey *)journeyObject;

@end

@interface JourneyList : BaseView

@property (nonatomic,weak) id<journeyListDelegate>delegate;

- (void)updateTableWithData:(NSArray *)data;

@end
