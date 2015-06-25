//
//  AddNewButtonView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/19/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddNewButtonView;

@protocol AddNewButtonViewDelegate <NSObject>

- (void)addNewButtonView:(AddNewButtonView *)addNewButtonView selectedButtonString:(NSString *)buttonTitle;

@end

@interface AddNewButtonView : UIView

@property (nonatomic,weak) id<AddNewButtonViewDelegate> delegate;

@end
