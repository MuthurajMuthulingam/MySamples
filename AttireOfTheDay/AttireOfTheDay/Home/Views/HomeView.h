//
//  HomeView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"

@class HomeView;

@protocol HomeViewDelegate <NSObject>

- (void)homeView:(HomeView *)homeView selectedHomeViewButonTitle:(NSString *)buttonString;

@end

@interface HomeView : BaseView

@property (nonatomic,weak)id<HomeViewDelegate> homeViewDeleagte;

@end
