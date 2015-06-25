//
//  MyPreferncesView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/19/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import "BaseView.h"
#import "commonAttireScrollView.h"

@class MyPreferncesView;

@protocol MyPreferncesDelegate <NSObject>

- (void)myPreferencesView:(MyPreferncesView *)myPreferencesView shareBtnClicked:(commonAttireScrollView *)attireView;

@end

@interface MyPreferncesView : BaseView

- (void)updateViewWithData:(NSArray *)dataArray;
- (void)showNoPreferencesView:(BOOL)shouldShow;

@property (nonatomic,weak) id <MyPreferncesDelegate> MyPreferncesDelegate;

@end
