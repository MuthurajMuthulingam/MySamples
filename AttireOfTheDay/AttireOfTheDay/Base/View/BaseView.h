//
//  BaseView.h
//  AttireOfTheDay
//
//  Created by Muthuraj M on 5/18/15.
//  Copyright (c) 2015 Muthuraj Muthulingam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+MyButton.h"

@interface BaseView : UIView

@property (nonatomic,strong) UIView *baseContentView;

- (void)createViews;

@end
